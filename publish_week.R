# publish_week.R
#
# Run this after manually pasting the week's files into the hash-named
# folder inside your site repo. Commits and pushes whatever changed.
#
# Usage:
#   source("publish_week.R")
#   publish_week("~/Documents/.../francais-moderne-site")

publish_week <- function(deploy_repo, branch = "main") {
  if (!requireNamespace("gert", quietly = TRUE)) {
    stop("Package 'gert' is required. Install it first: install.packages('gert')")
  }

  status <- gert::git_status(repo = deploy_repo)
  if (nrow(status) == 0) {
    message("Nothing changed — nothing to publish.")
    return(invisible(NULL))
  }

  print(status)  # so you can see what's about to be committed

  gert::git_add(".", repo = deploy_repo)
  gert::git_commit(
    paste0("Update site ", format(Sys.time(), "%Y-%m-%d %H:%M")),
    repo = deploy_repo
  )
  gert::git_push(remote = "origin", refspec = paste0("refs/heads/", branch), repo = deploy_repo)
  message("Pushed. Give it a minute or two for GitHub Pages to rebuild.")
}
