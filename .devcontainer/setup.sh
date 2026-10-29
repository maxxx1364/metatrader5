#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
project_dir="$repo_root/connect-claude-to-metatrader-5"

# Allow the Codespace to be created before the application is imported.
if [[ ! -f "$project_dir/package.json" ]]; then
  if [[ -f "$repo_root/package.json" ]]; then
    project_dir="$repo_root"
  else
    printf '%s\n' \
      'Development environment is ready; application files have not been imported yet.' \
      'After adding the project, run: bash .devcontainer/setup.sh'
    exit 0
  fi
fi

cd "$project_dir"
printf 'Installing dependencies in %s\n' "$project_dir"
node --version
npm --version

if [[ -f package-lock.json ]]; then
  npm ci
else
  npm install
fi

printf '\n%s\n' \
  'Dependencies installed. Configure the required environment variables locally,' \
  'then start the development server with:'
printf '  cd %q\n' "$project_dir"
printf '%s\n' '  npm run dev -- --hostname 0.0.0.0 --port 3000'
