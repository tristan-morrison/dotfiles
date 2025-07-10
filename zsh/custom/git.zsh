alias gc-temp="git commit -m 'TEMPORARY' --no-verify"
alias gst="git status -uno" # ignore untracked files
alias gr-1="git reset HEAD~1"
alias gfop="git fetch origin -p"
alias gff="git merge --ff-only"
alias gc-ane="git commit --amend --no-edit"

# Push the current branch, setting the upstream branch to origin/<branch_name>.
# Useful for new branches that do not yet exist on the remote.
function gp-new() {
    BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
    git push origin -u $BRANCH_NAME
}