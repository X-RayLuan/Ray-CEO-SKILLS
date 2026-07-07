#!/usr/bin/env python3
import json
import sys

try:
    from sympy import Eq, simplify, solve, sympify
except ImportError as exc:  # pragma: no cover
    IMPORT_ERROR = exc
    Eq = simplify = solve = sympify = None
else:
    IMPORT_ERROR = None


def emit(payload):
    sys.stdout.write(json.dumps(payload, ensure_ascii=True) + "\n")


def ok_result(kind, result, notes=None, warnings=None):
    return {
        "ok": True,
        "type": kind,
        "result": result,
        "notes": notes or [],
        "warnings": warnings or [],
    }


def error_result(kind, warning, notes=None):
    return {
        "ok": False,
        "type": kind,
        "result": {},
        "notes": notes or [],
        "warnings": [warning],
    }


def require_sympy():
    if IMPORT_ERROR is not None:
        raise RuntimeError(f"sympy unavailable: {IMPORT_ERROR}")


def parse_symbol(symbol_name):
    symbol = sympify(symbol_name)
    if getattr(symbol, "is_Symbol", False):
        return symbol
    raise ValueError("symbol must be a single variable name")


def parse_equation(raw):
    if "=" not in raw:
        raise ValueError("equation must contain '='")
    left, right = raw.split("=", 1)
    return Eq(sympify(left.strip()), sympify(right.strip()))


def solve_equation(payload):
    symbol = parse_symbol(payload.get("symbol", "x"))
    equation = parse_equation(payload["equation"])
    solutions = solve(equation, symbol)
    return ok_result(
        "solve_equation",
        {"solutions": [str(item) for item in solutions]},
    )


def evaluate_expression(payload):
    value = simplify(sympify(payload["expression"]))
    return ok_result("evaluate_expression", {"value": str(value)})


def simplify_expression(payload):
    value = simplify(sympify(payload["expression"]))
    return ok_result("simplify_expression", {"value": str(value)})


def check_answer(payload):
    symbol = parse_symbol(payload.get("symbol", "x"))
    equation = parse_equation(payload["equation"])
    candidate = sympify(payload["candidate"])
    left_value = equation.lhs.subs(symbol, candidate)
    right_value = equation.rhs.subs(symbol, candidate)
    is_correct = bool(simplify(left_value - right_value) == 0)
    return ok_result(
        "check_answer",
        {"is_correct": is_correct, "candidate": str(candidate)},
    )


HANDLERS = {
    "solve_equation": solve_equation,
    "evaluate_expression": evaluate_expression,
    "simplify_expression": simplify_expression,
    "check_answer": check_answer,
}


def main():
    try:
        require_sympy()
        payload = json.load(sys.stdin)
        kind = payload.get("type", "unknown")
        handler = HANDLERS.get(kind)
        if handler is None:
            emit(error_result(kind, "unsupported type"))
            return 0
        emit(handler(payload))
        return 0
    except Exception as exc:
        emit(error_result("internal_error", str(exc)))
        return 0


if __name__ == "__main__":
    raise SystemExit(main())
