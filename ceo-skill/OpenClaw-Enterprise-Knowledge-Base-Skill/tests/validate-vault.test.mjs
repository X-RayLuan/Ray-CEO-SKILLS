import test from 'node:test';
import assert from 'node:assert/strict';
import { mkdtemp, mkdir, writeFile } from 'node:fs/promises';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { validateVault } from '../scripts/validate-vault.mjs';

test('validateVault passes an OpenClaw-ready enterprise vault', async () => {
  const vault = await mkdtemp(join(tmpdir(), 'enterprise-kb-'));
  await mkdir(join(vault, 'openclaw'), { recursive: true });
  await mkdir(join(vault, 'actions'), { recursive: true });

  const frontmatter = [
    '---',
    'type: hot_cache',
    'object_id: hot-cache',
    'status: verified',
    'visibility: internal',
    'owner: knowledge',
    'source:',
    '  - internal',
    'last_reviewed: 2026-06-08',
    '---'
  ].join('\n');

  await writeFile(join(vault, 'hot.md'), frontmatter + '\n\n2026-06-08 | Enterprise KB | Current focus is OpenClaw Q&A readiness. Related pages: Home.md. Next step: run QA tests.\n');
  await writeFile(join(vault, 'Home.md'), [
    '---',
    'type: dashboard',
    'object_id: home',
    'status: verified',
    'visibility: internal',
    'owner: knowledge',
    'source:',
    '  - internal',
    'last_reviewed: 2026-06-08',
    '---',
    '',
    '# Home'
  ].join('\n'));
  await writeFile(join(vault, 'actions', 'Create-Quote-Draft.md'), [
    '---',
    'type: action',
    'object_id: action-create-quote-draft',
    'action_id: create-quote-draft',
    'status: verified',
    'visibility: internal',
    'owner: sales',
    'source:',
    '  - internal',
    'last_reviewed: 2026-06-08',
    '---',
    '',
    '# Create Quote Draft'
  ].join('\n'));

  const result = await validateVault({ vault });
  assert.equal(result.status, 'PASS');
  assert.equal(result.markdownFiles, 3);
  assert.deepEqual(result.issues.hotCacheIssues, []);
});

test('validateVault flags unverified public pages and duplicate IDs', async () => {
  const vault = await mkdtemp(join(tmpdir(), 'enterprise-kb-bad-'));
  const page = [
    '---',
    'type: product',
    'object_id: duplicate',
    'status: needs_review',
    'visibility: public',
    'owner: sales',
    'source:',
    '  - internal',
    'last_reviewed: 2026-06-08',
    '---',
    '',
    '# Product'
  ].join('\n');

  await writeFile(join(vault, 'A.md'), page);
  await writeFile(join(vault, 'B.md'), page);

  const result = await validateVault({ vault });
  assert.equal(result.status, 'FAIL');
  assert.equal(result.issues.duplicateIds.length, 1);
  assert.equal(result.issues.unverifiedPublic.length, 2);
  assert.deepEqual(result.issues.hotCacheIssues, ['missing hot.md']);
});

test('validateVault flags action pages without action_id', async () => {
  const vault = await mkdtemp(join(tmpdir(), 'enterprise-kb-action-'));
  await writeFile(join(vault, 'hot.md'), [
    '---',
    'type: hot_cache',
    'object_id: hot-cache',
    'status: verified',
    'visibility: internal',
    'owner: knowledge',
    'source:',
    '  - internal',
    'last_reviewed: 2026-06-08',
    '---',
    '',
    '2026-06-08 | Enterprise KB | Current focus is validation.'
  ].join('\n'));
  await writeFile(join(vault, 'Action.md'), [
    '---',
    'type: action',
    'object_id: action-missing-id',
    'status: verified',
    'visibility: internal',
    'owner: knowledge',
    'source:',
    '  - internal',
    'last_reviewed: 2026-06-08',
    '---',
    '',
    '# Action'
  ].join('\n'));

  const result = await validateVault({ vault });
  assert.equal(result.status, 'FAIL');
  assert.deepEqual(result.issues.missingActionId, ['Action.md']);
});
