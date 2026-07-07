import { readdir, readFile, stat } from 'node:fs/promises';
import { join, relative, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const REQUIRED_FIELDS = ['type', 'object_id', 'status', 'visibility', 'owner', 'source', 'last_reviewed'];
const VALID_STATUSES = new Set(['verified', 'needs_review', 'conflicting', 'deprecated']);
const VALID_VISIBILITIES = new Set(['public', 'dealer', 'internal', 'management']);

async function listMarkdownFiles(root, dir = root) {
  const entries = await readdir(dir, { withFileTypes: true });
  const files = [];

  for (const entry of entries) {
    if (entry.name === '.git' || entry.name === 'node_modules') continue;
    const path = join(dir, entry.name);
    if (entry.isDirectory()) {
      files.push(...await listMarkdownFiles(root, path));
    } else if (entry.isFile() && entry.name.endsWith('.md')) {
      files.push(path);
    }
  }

  return files;
}

function parseFrontmatter(text) {
  if (!text.startsWith('---\n')) return { data: null, body: text };
  const end = text.indexOf('\n---', 4);
  if (end === -1) return { data: null, body: text };

  const raw = text.slice(4, end).trim();
  const body = text.slice(end + 4).trim();
  const data = {};
  let currentKey = null;

  for (const line of raw.split('\n')) {
    if (!line.trim()) continue;
    const listMatch = line.match(/^\s+-\s+(.*)$/);
    if (listMatch && currentKey) {
      if (!Array.isArray(data[currentKey])) data[currentKey] = [];
      data[currentKey].push(listMatch[1].trim().replace(/^["']|["']$/g, ''));
      continue;
    }

    const match = line.match(/^([A-Za-z0-9_-]+):\s*(.*)$/);
    if (!match) continue;

    currentKey = match[1];
    const value = match[2].trim();
    if (value === '') {
      data[currentKey] = '';
    } else if (value === '[]') {
      data[currentKey] = [];
    } else {
      data[currentKey] = value.replace(/^["']|["']$/g, '');
    }
  }

  return { data, body };
}

function countCjk(text) {
  const matches = text.match(/[\u3400-\u9fff]/g);
  return matches ? matches.length : 0;
}

function compactBodyLength(text) {
  return text.replace(/\s+/g, '').length;
}

export async function validateVault(options = {}) {
  const vault = resolve(options.vault || process.cwd());
  const exists = await stat(vault).then((item) => item.isDirectory()).catch(() => false);
  if (!exists) throw new Error('Vault directory not found: ' + vault);

  const markdownFiles = await listMarkdownFiles(vault);
  const missingFrontmatter = [];
  const missingRequired = [];
  const invalidStatus = [];
  const invalidVisibility = [];
  const missingActionId = [];
  const unverifiedPublic = [];
  const duplicateIds = [];
  const ids = new Map();
  let hotCache = null;

  for (const file of markdownFiles) {
    const text = await readFile(file, 'utf8');
    const rel = relative(vault, file);
    const parsed = parseFrontmatter(text);

    if (!parsed.data) {
      missingFrontmatter.push(rel);
      continue;
    }

    for (const field of REQUIRED_FIELDS) {
      const value = parsed.data[field];
      if (value === undefined || value === '') {
        missingRequired.push({ file: rel, field });
      }
    }

    if (parsed.data.object_id) {
      const prior = ids.get(parsed.data.object_id);
      if (prior) duplicateIds.push({ object_id: parsed.data.object_id, files: [prior, rel] });
      ids.set(parsed.data.object_id, rel);
    }

    if (parsed.data.status && !VALID_STATUSES.has(parsed.data.status)) {
      invalidStatus.push({ file: rel, status: parsed.data.status });
    }

    if (parsed.data.visibility && !VALID_VISIBILITIES.has(parsed.data.visibility)) {
      invalidVisibility.push({ file: rel, visibility: parsed.data.visibility });
    }

    if (parsed.data.visibility === 'public' && parsed.data.status !== 'verified') {
      unverifiedPublic.push(rel);
    }

    if (parsed.data.type === 'action' && !parsed.data.action_id) {
      missingActionId.push(rel);
    }

    if (rel === 'hot.md') {
      hotCache = {
        path: rel,
        bodyLength: compactBodyLength(parsed.body),
        cjkLength: countCjk(parsed.body)
      };
    }
  }

  const hotCacheIssues = [];
  if (!hotCache) {
    hotCacheIssues.push('missing hot.md');
  } else if (hotCache.cjkLength > 0 && hotCache.bodyLength > 500) {
    hotCacheIssues.push('hot.md exceeds 500 compact characters');
  } else if (hotCache.cjkLength === 0 && hotCache.bodyLength > 900) {
    hotCacheIssues.push('hot.md exceeds 900 compact characters');
  }

  const issues = {
    missingFrontmatter,
    missingRequired,
    invalidStatus,
    invalidVisibility,
    missingActionId,
    duplicateIds,
    unverifiedPublic,
    hotCacheIssues
  };

  const issueCount = Object.values(issues).reduce((total, value) => total + value.length, 0);

  return {
    status: issueCount === 0 ? 'PASS' : 'FAIL',
    vault,
    markdownFiles: markdownFiles.length,
    hotCache,
    issues
  };
}

function parseArgs(argv) {
  const args = {};
  for (let index = 0; index < argv.length; index += 1) {
    if (argv[index] === '--vault') {
      args.vault = argv[index + 1];
      index += 1;
    }
  }
  return args;
}

const isMain = process.argv[1] && resolve(process.argv[1]) === fileURLToPath(import.meta.url);

if (isMain) {
  const result = await validateVault(parseArgs(process.argv.slice(2)));
  process.stdout.write(JSON.stringify(result, null, 2) + '\n');
  if (result.status !== 'PASS') process.exitCode = 1;
}
