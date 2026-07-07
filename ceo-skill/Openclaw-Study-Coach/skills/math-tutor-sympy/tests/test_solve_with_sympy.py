import json
import subprocess
import sys
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "solve_with_sympy.py"


def run_case(payload):
    return subprocess.run(
        [sys.executable, str(SCRIPT)],
        input=json.dumps(payload),
        text=True,
        capture_output=True,
        check=False,
    )


def parse_stdout(proc):
    return json.loads(proc.stdout)


class SolveWithSympyTests(unittest.TestCase):
    def test_solves_linear_equation(self):
        proc = run_case({"type": "solve_equation", "equation": "2*x + 3 = 11", "symbol": "x"})
        self.assertEqual(proc.returncode, 0)
        data = parse_stdout(proc)
        self.assertTrue(data["ok"])
        self.assertEqual(data["type"], "solve_equation")
        self.assertEqual(data["result"]["solutions"], ["4"])

    def test_evaluates_fraction_expression_exactly(self):
        proc = run_case({"type": "evaluate_expression", "expression": "1/3 + 1/6"})
        self.assertEqual(proc.returncode, 0)
        data = parse_stdout(proc)
        self.assertTrue(data["ok"])
        self.assertEqual(data["result"]["value"], "1/2")

    def test_checks_candidate_answer(self):
        proc = run_case(
            {
                "type": "check_answer",
                "equation": "x + 5 = 12",
                "symbol": "x",
                "candidate": "7",
            }
        )
        self.assertEqual(proc.returncode, 0)
        data = parse_stdout(proc)
        self.assertTrue(data["ok"])
        self.assertTrue(data["result"]["is_correct"])

    def test_rejects_invalid_payload(self):
        proc = run_case({"type": "unknown"})
        self.assertEqual(proc.returncode, 0)
        data = parse_stdout(proc)
        self.assertFalse(data["ok"])
        self.assertTrue(data["warnings"])
