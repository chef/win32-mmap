# GitHub Copilot Instructions for win32-mmap

## Purpose

This document defines the authoritative operational workflow for AI assistants contributing to the `win32-mmap` Ruby gem repository. This library provides memory mapped I/O functionality for Windows systems through FFI bindings to Win32 APIs. AI assistants MUST follow these guidelines for issue retrieval, structured planning, implementation gating, testing & coverage enforcement, DCO-compliant commits, PR authoring, labeling, and safety guardrails.

## Repository Structure

```
win32-mmap/
├── .expeditor/                    # Expeditor CI/CD automation configs
│   ├── config.yml                 # Main Expeditor configuration
│   ├── run_windows_tests.ps1      # Windows test execution script
│   ├── update_version.sh          # Version bump automation
│   └── verify.pipeline.yml        # PR validation pipeline
├── .github/
│   ├── CODEOWNERS                 # Repository ownership definitions
│   ├── ISSUE_TEMPLATE.md          # GitHub issue template
│   ├── PULL_REQUEST_TEMPLATE.md   # PR template with DCO requirements
│   ├── prompts/                   # AI assistant prompts
│   └── workflows/                 # GitHub Actions CI workflows
│       ├── lint.yml               # RuboCop/Cookstyle linting
│       └── unit.yml               # Unit tests on Windows platforms
├── examples/                      # Usage examples and demos
│   ├── example_mmap_client.rb     # Client usage pattern
│   ├── example_mmap_file.rb       # File mapping example
│   └── example_mmap_server.rb     # Server usage pattern
├── lib/                          # Main library code
│   ├── win32-mmap.rb             # Top-level require file
│   └── win32/
│       ├── mmap.rb               # Core MMap class implementation
│       └── windows/              # Win32 API bindings
│           ├── constants.rb      # Windows constants
│           ├── functions.rb      # Windows API function bindings
│           ├── structs.rb        # Windows structure definitions
│           └── version.rb        # Gem version definition
├── test/                         # Test suite
│   └── test_win32_mmap.rb        # Main test file
├── CHANGELOG.md                  # Release history
├── Gemfile                       # Development dependencies
├── Rakefile                      # Build and test tasks
├── README.md                     # Project documentation
├── VERSION                       # Current version file
└── win32-mmap.gemspec           # Gem specification
```

## Tooling & Ecosystem

**Language**: Ruby (3.1+ required)
**Platform**: Windows-specific (Windows Server 2022/2025 supported)
**Testing**: test-unit framework
**Linting**: Cookstyle (Chef's RuboCop extension)
**Dependencies**: FFI gem for native API bindings
**Build Tool**: Rake
**Package Manager**: RubyGems
**Coverage**: Manual assessment (no automated coverage tooling configured)

## Issue (Jira/Tracker) Integration

If an issue key is supplied (e.g., ABC-123), AI MUST:
1. Fetch issue details via configured MCP issue source
2. Parse: summary, description, acceptance criteria, issue type, linked issues, labels, story points
3. Create Implementation Plan covering:
   - Goal and scope
   - Impacted files (focus on `lib/win32/` for core changes)
   - Public API/Interface changes to `Win32::MMap` class
   - Windows API integration considerations
   - Platform-specific test strategy (Windows-only testing)
   - Edge cases (file permissions, memory allocation, concurrent access)
   - Risks & mitigations for memory management
   - Rollback strategy
4. FREEZE: No code changes until user approves plan with explicit "yes"
5. If acceptance criteria absent → prompt user to confirm inferred criteria

## Workflow Overview

AI MUST follow these phases in order:
1. **Intake & Clarify** - Understand requirements and scope
2. **Repository Analysis** - Review current codebase and identify impact areas
3. **Plan Draft** - Create detailed implementation plan with Windows considerations
4. **Plan Confirmation** (gate) - User MUST approve with "yes"
5. **Incremental Implementation** - Small, cohesive changes with immediate testing
6. **Lint / Style** - Cookstyle compliance validation
7. **Test & Coverage Validation** - Windows-specific test execution and coverage mapping
8. **DCO Commit** - Developer Certificate of Origin compliant commits
9. **Push & Draft PR Creation** - Create draft PR with proper labeling
10. **Label & Risk Application** - Apply appropriate repository labels
11. **Final Validation** - Confirm all requirements met

Each phase ends with: Step Summary + Checklist + "Continue to next step? (yes/no)"

## Detailed Step Instructions

AI MUST follow these principles:
- **Smallest cohesive change per commit** - Focus on single logical units
- **Add/adjust tests immediately** with each behavior change
- **Present mapping of changes to tests** before committing
- **Consider Windows-specific behaviors** (file handles, memory mapping, security)

**Example Step Output:**
```
Step: Add boundary guard in memory mapping
Summary: Added nil check & size constraint in MMap.new; tests added for empty input & overflow scenarios.
Checklist:
- [x] Plan
- [x] Implementation  
- [ ] Tests
- [ ] Windows validation
Proceed? (yes/no)
```

If user responds other than explicit "yes" → AI MUST pause & clarify.

## Branching & PR Standards

**Branch Naming** (MUST): 
- EXACT issue key if provided (e.g., `ABC-123`)
- Else kebab-case slug ≤40 chars (e.g., `fix-memory-leak-mapping`)

**One logical change set per branch** (MUST)

**PR MUST remain draft until:**
- Tests pass on Windows platforms
- Cookstyle linting passes
- Coverage mapping completed
- All commits DCO-signed

**PR Description Sections** (MUST use existing template with additions):
Since `.github/PULL_REQUEST_TEMPLATE.md` exists, AI MUST use that structure and inject additional required sections:

### Description
[Use existing template field]

### Issues Resolved
[Use existing template field - include issue links]

### Changes
- Modified: [list changed files]
- Added: [list new files]

### Tests & Coverage
- Changed lines: N
- Estimated covered: ~X%
- Mapping complete: [Yes/No]
- Windows-specific test validation: [Yes/No]

### Risk & Mitigations
**Risk Classification**: [Low/Moderate/High]
- **Low**: Localized, non-breaking changes
- **Moderate**: Shared module or light interface changes  
- **High**: Public API changes, memory management, Windows API changes

**Rollback Strategy**: `revert commit <SHA>` or feature toggle reference

### Check List
[Use existing template checklist with additions]
- [ ] New functionality includes tests
- [ ] All tests pass on Windows platforms
- [ ] Windows-specific edge cases tested
- [ ] Memory management validated
- [ ] All commits have been signed-off for DCO
- [ ] Cookstyle linting passes

## Commit & DCO Policy

**Commit Format** (MUST):
```
{{TYPE}}({{OPTIONAL_SCOPE}}): {{SUBJECT}} ({{ISSUE_KEY}})

Rationale explaining what and why.

Issue: {{ISSUE_KEY or none}}
Signed-off-by: Full Name <email@domain>
```

**Types**: feat, fix, docs, style, refactor, test, chore
**Scopes**: mmap, api, windows, examples, test

Missing DCO sign-off → block and request name/email from user.

## Testing & Coverage

**Changed Logic → Test Assertions Mapping** (MUST provide):

| File | Method/Block | Change Type | Test File | Assertion Reference |
|------|--------------|-------------|-----------|-------------------|
| lib/win32/mmap.rb | initialize | Modified validation | test/test_win32_mmap.rb | test_new_with_invalid_args |

**Coverage Threshold** (MUST): ≥80% changed lines
If below threshold: add tests or refactor for testability.

**Windows-Specific Edge Cases** (MUST enumerate):
- **File Permissions**: Windows file access rights and sharing violations
- **Memory Limits**: Large file mapping beyond available virtual memory
- **Handle Management**: Proper cleanup of file/mapping handles
- **Path Handling**: Windows path separators and long path names
- **Concurrent Access**: Multiple processes accessing same mapped file
- **Security Context**: User permissions for file mapping operations
- **Platform Versions**: Windows Server 2022 vs 2025 differences

**Testing Requirements**:
- All tests MUST run on Windows platforms only
- Use test-unit framework conventions
- Mock Windows API calls where appropriate for unit testing
- Integration tests MUST use real file system operations

## Labels Reference

| Name | Description | Typical Use |
|------|-------------|-------------|
| Aspect: Documentation | How do we use this project? | README, API docs, examples |
| Aspect: Integration | Works correctly with other projects | FFI compatibility, Windows integration |
| Aspect: Packaging | Distribution artifacts | Gem building, release prep |
| Aspect: Performance | System performance impact | Memory usage, mapping efficiency |
| Aspect: Portability | Platform compatibility | Windows version support |
| Aspect: Security | Security vulnerabilities | Memory access, file permissions |
| Aspect: Stability | Consistent results | Bug fixes, reliability |
| Aspect: Testing | Coverage and CI status | Test improvements, CI fixes |
| Expeditor: Bump Version Major | Major version bump trigger | Breaking API changes |
| Expeditor: Bump Version Minor | Minor version bump trigger | New features |
| Expeditor: Skip All | Skip all merge actions | Emergency bypasses |
| Expeditor: Skip Changelog | Skip changelog update | Documentation-only changes |
| Expeditor: Skip Version Bump | Skip version increment | Hotfixes |
| hacktoberfest-accepted | Hacktoberfest participation | Community contributions |
| oss-standards | OSS standardization | Repository maintenance |

**Platform Labels**: Windows-specific project - other platform labels not applicable.

## CI / Release Automation Integration

**GitHub Actions Workflows:**
- **lint.yml**: Triggers on PR/push to main; runs Cookstyle linting with Ruby 3.1 on Ubuntu
- **unit.yml**: Triggers on PR/push to master; runs test suite on Windows 2022/2025 with Ruby 3.1/3.4

**Expeditor Release Automation:**
- **Version Bumping**: Automatic via merged PR labels (`Expeditor: Bump Version Minor`)
- **Changelog Management**: Auto-generated from merged PRs
- **Gem Publishing**: Automatic to RubyGems on promotion
- **Branch Management**: Auto-delete merged PR branches

**Version Mechanism**: 
- Manual file updates via `.expeditor/update_version.sh`
- Tag format: `win32-mmap-{{version}}`
- Release branch: `main`

**AI MUST NOT directly edit release automation configs without explicit user instruction.**

## Security & Protected Files

**Protected Files** (NEVER edit without explicit approval):
- `LICENSE` - Artistic 2.0 license
- `.github/CODEOWNERS` - Repository ownership
- `.expeditor/config.yml` - Release automation
- `.github/workflows/*.yml` - CI configurations
- Security-related documentation

**AI MUST NEVER:**
- Exfiltrate or inject secrets
- Force-push to main branch
- Merge PR autonomously
- Insert new binaries without review
- Remove license headers
- Fabricate issue or label data
- Reference credentials in guidance

## Prompts Pattern (Interaction Model)

After each step AI MUST output:
```
Step: {{STEP_NAME}}
Summary: {{CONCISE_OUTCOME}}
Checklist: 
- [x] Planning complete
- [ ] Implementation pending
- [ ] Testing pending
- [ ] Windows validation pending
Prompt: "Continue to next step? (yes/no)"
```

Non-affirmative response → AI MUST pause & clarify requirements.

## Validation & Exit Criteria

Task is COMPLETE ONLY IF:
1. ✅ Feature/fix branch exists & pushed
2. ✅ Cookstyle linting passes  
3. ✅ Tests pass on Windows platforms (Windows Server 2022/2025)
4. ✅ Windows-specific edge cases validated
5. ✅ Coverage mapping complete + ≥80% changed lines
6. ✅ PR open (draft or ready) with required template sections
7. ✅ Appropriate repository labels applied
8. ✅ All commits DCO-compliant
9. ✅ No unauthorized Protected File modifications
10. ✅ Memory management and Windows API usage validated
11. ✅ User explicitly confirms completion

Otherwise AI MUST list unmet items and request resolution.

## Issue Planning Template

```
Issue: {{ISSUE_KEY}}
Summary: {{from_issue_tracker}}

Acceptance Criteria:
- {{criterion_1}}
- {{criterion_2}}

Implementation Plan:
- **Goal**: {{clear_objective}}
- **Impacted Files**: {{file_list_with_lib_win32_focus}}
- **Public API Changes**: {{MMap_class_modifications}}
- **Data/Integration Considerations**: {{Windows_API_dependencies}}
- **Test Strategy**: {{Windows_platform_specific_tests}}
- **Edge Cases**: {{memory_mapping_file_permissions_concurrency}}
- **Risks & Mitigations**: {{memory_leaks_handle_management}}
- **Rollback**: {{revert_strategy}}

Proceed? (yes/no)
```

## PR Description Canonical Template

Since `.github/PULL_REQUEST_TEMPLATE.md` exists, AI MUST use that structure and inject the additional required sections within or appended to existing headings:

**Additional sections to inject:**

**Tests & Coverage** (add after existing checklist):
- Changed lines: {{N}}
- Estimated covered: ~{{X}}%
- Mapping complete: {{Yes/No}}
- Windows platform validation: {{Yes/No}}

**Risk & Mitigations** (add new section):
- Risk: {{Low/Moderate/High}}
- Mitigation: {{revert_commit_SHA_or_feature_toggle}}
- Windows-specific considerations: {{memory_handles_permissions}}

**DCO Confirmation** (add to existing checklist):
- [ ] All commits signed off per DCO requirements

## Idempotency Rules

**Re-entry Detection Order** (MUST check):
1. Branch existence: `git rev-parse --verify {{branch}}`
2. PR existence: `gh pr list --head {{branch}}`  
3. Uncommitted changes: `git status --porcelain`

**Delta Summary** (MUST provide):
- **Added Sections**: {{new_functionality}}
- **Modified Sections**: {{changed_behavior}}  
- **Deprecated Sections**: {{removed_features}}
- **Rationale**: {{why_changes_needed}}

## Failure Handling

**Decision Tree** (MUST follow):
- **Labels fetch fails** → Abort; prompt: "Provide label list manually or fix auth. Retry? (yes/no)"
- **Issue fetch incomplete** → Ask: "Missing acceptance criteria—provide or proceed with inferred? (provide/proceed)"
- **Coverage < threshold** → Add tests; re-run; block commit until satisfied
- **Windows tests fail** → Investigate platform-specific issues; add Windows-specific assertions
- **Missing DCO** → Request user name/email for sign-off
- **Protected file modification** → Reject & restate policy
- **Memory management concerns** → Review for leaks, handle cleanup, validation

## Glossary

- **Changed Lines Coverage**: Portion of modified lines executed by test assertions
- **Implementation Plan Freeze Point**: No code changes allowed until user approval
- **Protected Files**: Policy-restricted assets requiring explicit authorization
- **Idempotent Re-entry**: Resuming workflow without duplicated/conflicting state
- **Risk Classification**: Impact assessment (Low/Moderate/High)
- **Rollback Strategy**: Concrete reversal action (revert commit/disable feature)
- **DCO**: Developer Certificate of Origin sign-off confirming contribution rights
- **Memory Mapped I/O**: Windows technique for mapping files into virtual memory
- **Win32 API**: Windows system APIs for file and memory management
- **FFI**: Foreign Function Interface for calling native APIs from Ruby

## Quick Reference Commands

```bash
# Standard development workflow
git checkout -b {{BRANCH_NAME}}
bundle install
bundle exec rake            # Run tests on Windows
bundle exec cookstyle       # Lint with Cookstyle
git add .
git commit -m "feat(mmap): add boundary validation (ABC-123)" \
    -m "Added size validation to prevent overflow conditions." \
    -m "Issue: ABC-123" \
    -m "Signed-off-by: Full Name <email@domain>"
git push -u origin {{BRANCH_NAME}}
gh pr create --base main --head {{BRANCH_NAME}} \
    --title "ABC-123: Add memory mapping validation" --draft
gh pr edit {{PR_NUMBER}} --add-label "Aspect: Stability"

# Windows-specific testing
bundle exec ruby test/test_win32_mmap.rb
ruby -c lib/win32/mmap.rb   # Syntax check

# Coverage assessment (manual)
# Review changed files and ensure corresponding test coverage
```