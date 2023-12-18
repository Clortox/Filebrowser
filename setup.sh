#!/bin/bash
#
# Generic script to setup the repository for local development

echo "Installing pre-commit"
pip install pre-commit
pre-commit install

echo "Installing commit-msg"

HOOK_LOCATION=".git/hooks/commit-msg"
VERB_LOCATION=".git/hooks/verbs.txt"

cat << 'EOF' > "$HOOK_LOCATION"
#!/bin/sh
#
# Git hook to check for semantic commit messages in the form mentioned here

export VERB=$(cut -d ' ' -f1 < "$1")
(grep "$VERB" .git/hooks/verbs.txt > /dev/null) || (echo "Missing a verb"; exit 1)
EOF

chmod +x $HOOK_LOCATION

cat << 'EOF' > "$VERB_LOCATION"
Add
Update
Fix
Refactor
Remove
Implement
Enhance
Optimize
Revise
Adjust
Modify
Rewrite
Improve
Correct
Debug
Delete
Replace
Create
Design
Develop
Build
Configure
Resolve
Patch
Extend
Reduce
Increase
Simplify
Merge
Split
Release
Deploy
Test
Validate
Format
Organize
Reorganize
Rename
Repackage
Refine
Rework
Expand
Collapse
Integrate
Extract
Introduce
Finalize
Prepare
Generate
Convert
Upload
Download
Sync
Encrypt
Decrypt
Authenticate
Authorize
Invalidate
Sanitize
Analyze
Inspect
Probe
Examine
Index
Compress
Decompress
Archive
Restore
Save
Load
Export
Import
Visualize
Illustrate
Diagram
Plot
Map
Scan
Seek
Find
Discover
Track
Monitor
Observe
Watch
Alert
Notify
Log
Record
Report
Summarize
Detail
Document
Annotate
Comment
Explain
Clarify
Define
Enumerate
Stabilize
EOF
