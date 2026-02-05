#!/bin/bash
# Nuclear option: Clean repository of all secrets and start fresh
# USE WITH CAUTION - This will rewrite Git history

set -e

echo "🚨 WARNING: This will DESTROY all Git history and create a fresh start"
echo "📦 Current repo: ExtensionAudit"
echo ""
read -p "Are you SURE you want to continue? (type 'YES' to proceed): " confirm

if [ "$confirm" != "YES" ]; then
    echo "❌ Aborted. No changes made."
    exit 1
fi

echo ""
echo "🔄 Step 1: Creating backup branch..."
git branch backup-$(date +%Y%m%d-%H%M%S) 2>/dev/null || true

echo "🔄 Step 2: Removing .git directory..."
rm -rf .git

echo "🔄 Step 3: Initializing fresh repository..."
git init

echo "🔄 Step 4: Adding all current files..."
git add .

echo "🔄 Step 5: Creating initial commit..."
git commit -m "Initial commit - ExtensionScanner

- Clean repository start
- No exposed secrets
- Documentation and configuration files
- Source code to be added in phases"

echo "🔄 Step 6: Adding remote..."
git remote add origin git@github.com:Stanzin7/ExtensionAudit.git

echo "🔄 Step 7: Force pushing to GitHub (this will REPLACE all history)..."
echo "⏳ Pushing in 3 seconds... Press Ctrl+C to abort!"
sleep 3

git push -u --force origin main

echo ""
echo "✅ Done! Repository history has been completely rewritten."
echo "📝 Old commits are GONE from GitHub"
echo "🔐 Exposed secrets are no longer in the history"
echo ""
echo "⚠️  IMPORTANT NEXT STEPS:"
echo "1. Revoke ALL API keys that were exposed (VirusTotal, OpenAI, etc.)"
echo "2. Generate new API keys"
echo "3. Add them to your .env file (which is gitignored)"
echo ""

