library(gh)

delete_old_workflow_runs <- function(owner, repo, keep = 1) {
  # List workflow runs
  workflows <- gh::gh("GET /repos/{owner}/{repo}/actions/runs", owner = owner, repo = repo, per_page = 100)

  # Get the workflow runs to delete (all except the latest 'keep' runs)
  runs_to_delete <- workflows$workflow_runs[(keep + 1):length(workflows$workflow_runs)]

  # Delete each workflow run
  for (run in runs_to_delete) {
    gh::gh("DELETE /repos/{owner}/{repo}/actions/runs/{run_id}", owner = owner, repo = repo, run_id = run$id)
    message("Deleted workflow run: ", run$id)
  }
}

delete_old_workflow_runs("pachadotdev", "cpp11tesseract", keep = 0)