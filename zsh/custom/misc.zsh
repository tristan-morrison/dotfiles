# source ~/site/git/private-dotfiles/zsh/custom/env.sh

# launches emacsclient, creating a new instance of emacs daemon if none is running
function emc()
{
  # -c creates a new frame
  # -a= fires a new emacs server if none is running
  emacsclient -c -a= $*
}

# Colored man pages
# See https://unix.stackexchange.com/questions/119/colors-in-man-pages
export LESS_TERMCAP_mb=$'\e[1;34m'     # begin bold (blue fg)
export LESS_TERMCAP_md=$'\e[1;31m'     # begin blink (red fg)
export LESS_TERMCAP_so=$'\e[01;43;34m' # begin reverse video (yellow fg, blue bg)
export LESS_TERMCAP_us=$'\e[01;32m'    # begin underline (green fg)
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline

# Play a notification sound. Useful when chained at the end of another
# program
alias notify="afplay /System/Library/Sounds/Funk.aiff &>/dev/null &"

# Exit with the exit code of previous command
# Usage:
# You have a long running command already running
# You want to queue-up another one to run only if previous one succeeds
# While previous command is running, type "last && my new command"
# Use cases:
# - Run git push after git commit with pre commit hooks
# - Run notify if previous command succeeds. Can also use || to provide the
#   failure case
good() {
  return $?
}

# Force-quits the Global Protect desktop client; useful when client is
# disconnected and hangs waiting for credentials. At time of writing,
# a bug in the Global Protect client causes it to occasionally get
# stuck in a state in which it is waiting for user to provide
# credentials via the embedded browser, but never actually displays
# the embedded browser.
function kill-gp() {
    # the argument to kill is an inline script to get the PID of the
    # Global Protect client app
    # ps -ax : lists the process
    # ggrep -oP : scans the `ps` output for the line pertaining to
    #             the Global Protect app.
    #               * -o causes only the the matching part of the
    #                 matched line to be output
    #               * -P specifies Perl regex
    #               * The regex pattern arg matches the PID, and
    #                 uses a zero-length lookahead assertion to
    #                 match only the line for the GP app
    kill $(ps -ax | ggrep -oP "[0-9]+ (?=.*[\d+:\d+.\d+|] \/Applications\/GlobalProtect.app\/Contents\/MacOS\/GlobalProtect$)")
}