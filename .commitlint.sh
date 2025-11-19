#!/bin/bash
# Test script to validate commit message format
# Usage: ./scripts/test-commit-msg.sh <path-to-commit-msg-file>

set -e

# Read the commit message from the file
commit_msg_file="$1"
commit_msg=$(cat "$commit_msg_file")

echo "Testing commit message validation..."
echo ""

# Extract the validation logic
pattern="^(feat|fix|docs|style|refactor|test|chore|perf|ci|build|revert)(\(.+\))?: .{1,}"

if echo "$commit_msg" | grep -qE "$pattern"; then
  echo "✅ Valid commit message!"
  echo "Message: $commit_msg"
  exit 0
else
  echo "❌ Invalid commit message!"
  echo ""
  echo "Commit message must follow Conventional Commits format:"
  echo "  <type>(<scope>): <subject>"
  echo ""
  echo "Examples:"
  echo "  feat(api): add user authentication endpoint"
  echo "  fix(database): resolve connection pool leak"
  echo "  docs: update README with setup instructions"
  echo ""
  echo "Your message: $commit_msg"
  exit 1
fi
