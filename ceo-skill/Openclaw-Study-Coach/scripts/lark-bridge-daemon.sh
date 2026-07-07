#!/usr/bin/env bash
# lark-bridge-daemon.sh
# ----------------------------------------------------------------------------
# SSH-friendly launchd daemon manager for lark-channel-bridge.
#
# Why this exists:
#   `lark-channel-bridge start` 默认装到 user/$UID launchd domain (LaunchAgent),
#   这个 domain 在 SSH session 里**完全不可操作** (macOS Tahoe / Sequoia 收紧了),
#   会报 "Bootstrap failed: 125: Domain does not support specified action" 或
#   "Bootstrap failed: 5: Input/output error"。
#
#   这个脚本改用 **system domain** (LaunchDaemon),plist 放到
#   /Library/LaunchDaemons/,以 root 加载、但通过 UserName 字段以 brian
#   身份运行(不 root 跑 node)。system domain 在 SSH session 里也能管。
#
# Usage:
#   ./scripts/lark-bridge-daemon.sh install     # 一次性装(需要 sudo)
#   ./scripts/lark-bridge-daemon.sh status      # 看状态
#   ./scripts/lark-bridge-daemon.sh logs        # 实时 tail 日志
#   ./scripts/lark-bridge-daemon.sh restart     # 重启
#   ./scripts/lark-bridge-daemon.sh stop        # 停止(不卸载)
#   ./scripts/lark-bridge-daemon.sh start       # 启动(已装,临时关掉的)
#   ./scripts/lark-bridge-daemon.sh uninstall   # 卸载
# ----------------------------------------------------------------------------

set -euo pipefail

LABEL="ai.lark-channel-bridge.bot"
PLIST_PATH="/Library/LaunchDaemons/${LABEL}.plist"
SERVICE_TARGET="system/${LABEL}"
LOG_DIR="${HOME}/.lark-channel/logs"
NODE_BIN="$(command -v node || true)"
BRIDGE_BIN="$(command -v lark-channel-bridge || true)"
RUN_USER="${USER:-$(whoami)}"

color() { printf '\033[%sm%s\033[0m\n' "$1" "$2"; }
green()  { color "0;32" "$*"; }
yellow() { color "0;33" "$*"; }
red()    { color "0;31" "$*"; }
bold()   { color "1"    "$*"; }

require_macos() {
  [ "$(uname)" = "Darwin" ] || { red "✗ This script only works on macOS"; exit 1; }
}

require_node_bridge() {
  if [ -z "$NODE_BIN" ]; then
    red "✗ node not found in PATH. Install Node.js 20+ first."
    exit 1
  fi
  if [ -z "$BRIDGE_BIN" ]; then
    red "✗ lark-channel-bridge not found. Run: npm install -g lark-channel-bridge"
    exit 1
  fi
}

generate_plist() {
  # node binary 必须用绝对路径(daemon 启动时 PATH 是空的)
  # 解析符号链接拿真实路径(npm 全局 bin 通常是 symlink)
  local real_node real_bridge
  real_node="$(readlink -f "$NODE_BIN" 2>/dev/null || python3 -c "import os,sys;print(os.path.realpath(sys.argv[1]))" "$NODE_BIN")"
  real_bridge="$BRIDGE_BIN"  # 这个本身就是绝对路径

  cat <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>${LABEL}</string>

    <!-- 以 ${RUN_USER} 身份运行,不要 root -->
    <key>UserName</key>
    <string>${RUN_USER}</string>

    <key>ProgramArguments</key>
    <array>
        <string>${real_node}</string>
        <string>${real_bridge}</string>
        <string>run</string>
    </array>

    <key>WorkingDirectory</key>
    <string>${HOME}</string>

    <key>RunAtLoad</key>
    <true/>

    <key>KeepAlive</key>
    <true/>

    <!-- 崩溃后等 10s 再重启,防 thrash -->
    <key>ThrottleInterval</key>
    <integer>10</integer>

    <!-- 进程级 wall-clock soft limit:超过 1h CPU 才 kill,正常工作不会触 -->
    <key>SoftResourceLimits</key>
    <dict>
        <key>NumberOfFiles</key>
        <integer>4096</integer>
    </dict>

    <key>StandardOutPath</key>
    <string>${LOG_DIR}/daemon-stdout.log</string>
    <key>StandardErrorPath</key>
    <string>${LOG_DIR}/daemon-stderr.log</string>

    <key>EnvironmentVariables</key>
    <dict>
        <key>HOME</key>
        <string>${HOME}</string>
        <key>PATH</key>
        <string>/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin</string>
        <!-- 避免 daemon 进程的输出被 Homebrew cache 等环境变量污染 -->
        <key>NODE_OPTIONS</key>
        <string>--no-deprecation</string>
    </dict>

    <!-- macOS Tahoe+ 推荐:让系统知道这是个长期运行的服务 -->
    <key>ProcessType</key>
    <string>Background</string>
</dict>
</plist>
EOF
}

cmd_install() {
  require_macos
  require_node_bridge

  bold "==> 准备安装 lark-channel-bridge system daemon"
  echo "  Label:        $LABEL"
  echo "  Plist path:   $PLIST_PATH"
  echo "  Run as user:  $RUN_USER"
  echo "  Node binary:  $NODE_BIN"
  echo "  Bridge bin:   $BRIDGE_BIN"
  echo "  Log dir:      $LOG_DIR"
  echo

  # 先停掉任何前台 / nohup 跑的 bridge,避免 app id 冲突
  if pgrep -f "lark-channel-bridge.*run" > /dev/null; then
    yellow "  → 发现已有 bridge 进程在跑,先停掉..."
    pkill -TERM -f "lark-channel-bridge.*run" || true
    sleep 2
    pkill -KILL -f "lark-channel-bridge.*run" 2>/dev/null || true
  fi

  # 同时清理可能存在的失败 user-domain plist
  if [ -f "${HOME}/Library/LaunchAgents/${LABEL}.plist" ]; then
    yellow "  → 清理失败的 user-domain plist"
    launchctl bootout "user/$(id -u)/${LABEL}" 2>/dev/null || true
    rm -f "${HOME}/Library/LaunchAgents/${LABEL}.plist"
  fi

  mkdir -p "$LOG_DIR"

  # 把生成的 plist 写到 /tmp,再 sudo 拷过去
  local tmp_plist
  tmp_plist="$(mktemp -t lark-bridge-plist).plist"
  generate_plist > "$tmp_plist"

  bold "==> sudo 安装 plist 到 $PLIST_PATH"
  echo "    需要你的密码(或 Touch ID)"
  sudo install -m 644 -o root -g wheel "$tmp_plist" "$PLIST_PATH"
  rm -f "$tmp_plist"
  green "  ✓ plist 已就位"
  echo

  # 如果已经 bootstrap 过,先 bootout 避免冲突
  if launchctl print "$SERVICE_TARGET" >/dev/null 2>&1; then
    yellow "  → 服务已存在,先 bootout"
    sudo launchctl bootout "system" "$PLIST_PATH" 2>/dev/null || true
    sleep 1
  fi

  bold "==> bootstrap 到 system domain"
  sudo launchctl bootstrap system "$PLIST_PATH"
  green "  ✓ bootstrap 成功"
  echo

  bold "==> enable + kickstart"
  sudo launchctl enable "$SERVICE_TARGET" 2>/dev/null || true
  sudo launchctl kickstart -k "$SERVICE_TARGET" 2>/dev/null || true
  green "  ✓ 已启动"
  echo

  sleep 3
  cmd_status
}

cmd_status() {
  require_macos
  bold "==> daemon 状态"
  if launchctl print "$SERVICE_TARGET" 2>/dev/null | head -1 | grep -q "$LABEL"; then
    green "  ✓ daemon 已注册"
    echo
    sudo launchctl print "$SERVICE_TARGET" 2>/dev/null | \
      grep -E "^\s*(state|pid|last exit code|spawn type|program)" | \
      sed 's/^[[:space:]]*/  /'
  else
    red "  ✗ daemon 未注册或已 bootout"
    return 1
  fi
  echo
  bold "==> 实际进程"
  pgrep -af "lark-channel-bridge.*run" || yellow "  (无进程)"
  echo
  bold "==> 最近 stderr (最后 5 行)"
  if [ -f "${LOG_DIR}/daemon-stderr.log" ]; then
    tail -5 "${LOG_DIR}/daemon-stderr.log" | sed 's/^/  /'
  else
    yellow "  (还没产生日志)"
  fi
}

cmd_logs() {
  require_macos
  bold "==> 实时 tail 三个日志文件 (Ctrl-C 退出)"
  echo "  - daemon-stdout.log    daemon 主输出"
  echo "  - daemon-stderr.log    daemon 错误"
  echo "  - $(date +%Y-%m-%d).log         今天结构化 JSONL"
  echo
  tail -f \
    "${LOG_DIR}/daemon-stdout.log" \
    "${LOG_DIR}/daemon-stderr.log" \
    "${LOG_DIR}/$(date +%Y-%m-%d).log" 2>/dev/null || \
    yellow "  (有日志文件还没生成)"
}

cmd_stop() {
  require_macos
  bold "==> 停止 daemon (保留 plist,可以 start 回来)"
  sudo launchctl bootout "system" "$PLIST_PATH" 2>&1 | tail -3
  sleep 1
  pgrep -af "lark-channel-bridge" || green "  ✓ 已停"
}

cmd_start() {
  require_macos
  bold "==> 启动 daemon"
  if [ ! -f "$PLIST_PATH" ]; then
    red "  ✗ plist 还没装,先跑: $0 install"
    exit 1
  fi
  sudo launchctl bootstrap system "$PLIST_PATH"
  sudo launchctl enable "$SERVICE_TARGET" 2>/dev/null || true
  sudo launchctl kickstart -k "$SERVICE_TARGET" 2>/dev/null || true
  sleep 2
  cmd_status
}

cmd_restart() {
  cmd_stop || true
  sleep 1
  cmd_start
}

cmd_uninstall() {
  require_macos
  bold "==> 完全卸载"
  echo "    - bootout daemon"
  echo "    - 删除 $PLIST_PATH"
  echo "    - 保留 ~/.lark-channel/(配置 + 日志)"
  echo
  read -r -p "  确认卸载? [y/N] " ans
  case "$ans" in
    y|Y|yes|YES) ;;
    *) yellow "  取消"; return 0;;
  esac

  sudo launchctl bootout "system" "$PLIST_PATH" 2>/dev/null || true
  sudo rm -f "$PLIST_PATH"
  green "  ✓ 已卸载"
  yellow "  (config + logs 保留在 ~/.lark-channel/,不动)"
}

cmd_help() {
  cat <<EOF
$(bold "lark-channel-bridge SSH-friendly system daemon manager")

Usage: $0 <command>

Commands:
  install      装 daemon (需要 sudo,一次性)
  status       看状态 (sudo,看 daemon 注册情况 + 进程 + 日志)
  logs         实时 tail 日志 (Ctrl-C 退出)
  restart      重启 (sudo)
  stop         停止 (sudo,保留 plist)
  start        启动 (sudo,plist 已装的情况下)
  uninstall    完全卸载 (sudo)
  help         本帮助

为什么不用 lark-channel-bridge 自带的 \`start\` 命令?
  它默认装到 user/\$UID launchd domain,这个 domain 在 SSH 里完全不可操作。
  这个脚本装到 system domain 解决这个问题。
  详见脚本顶部注释。

Daemon 装好后:
  - 机器重启自动启动 ✓
  - 进程崩溃自动重启 ✓ (10 秒 throttle)
  - SSH 进来能管理 ✓ (status / restart / stop / start 都 work)
  - 以 \$USER 身份运行,不 root 提权 ✓
EOF
}

# ---- 主入口 -----
cmd="${1:-help}"
case "$cmd" in
  install)   cmd_install ;;
  status)    cmd_status ;;
  logs)      cmd_logs ;;
  restart)   cmd_restart ;;
  stop)      cmd_stop ;;
  start)     cmd_start ;;
  uninstall) cmd_uninstall ;;
  help|-h|--help) cmd_help ;;
  *) red "未知命令: $cmd"; cmd_help; exit 1 ;;
esac
