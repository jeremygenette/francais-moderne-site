# Password-protected course site — starter template

## What's in here
```
.
├── index.html                     ← password gate (from chrissy-dev/protected-github-pages, MIT licensed) — don't edit
├── PASSWORD_HASH_GOES_HERE/       ← placeholder folder; setup.sh renames this to your password's hash
├── setup.sh                       ← run ONCE to connect this folder to GitHub
├── publish_week.R                 ← run EVERY WEEK after pasting in new content
└── README.md                      ← this file
```

## One-time setup

1. On github.com, create a new **empty** repository (no README/license/gitignore), e.g. `francais-moderne-site`.
2. In that repo: **Settings → Pages → Source: "Deploy from a branch" → Branch: `main` → `/(root)` → Save.**
3. Make sure you already have a GitHub Personal Access Token set up for `git`/`gert` to use (via `gitcreds::gitcreds_set()` in R, or `usethis::create_github_token()` if you need to make a new one).
4. In a terminal, `cd` into this folder, then run:
   ```bash
   chmod +x setup.sh
   ./setup.sh "your-chosen-password" "https://github.com/YOUR_USERNAME/YOUR_REPO.git"
   ```
   This will:
   - compute the SHA-1 hash of your password
   - rename the placeholder folder to that hash (this is where your content goes)
   - initialize git, connect it to your GitHub repo, and push everything

5. Note the hash-named folder it prints out — **that's where you'll paste content every week.**
6. Visit `https://YOUR_USERNAME.github.io/YOUR_REPO/` (or your custom domain) and confirm the password screen appears and your chosen password gets you in.

## Every week

1. Paste that week's rendered files (HTML, slides, etc.) into the hash-named folder.
2. In R:
   ```r
   source("publish_week.R")
   publish_week(".")   # or the full path to this folder, if running from elsewhere
   ```
3. Wait a minute or two for GitHub Pages to rebuild, then check the live URL.

## Reminder on security

This password gate is a **speed bump, not a lock**: because the repo must be public on GitHub's free plan, anyone who browses the repo's file list on github.com can see the hash-named folder and open it directly, bypassing the password screen entirely. It's fine for keeping casual visitors out, but don't put anything in here you'd be upset about a student (or anyone else) accessing directly.
