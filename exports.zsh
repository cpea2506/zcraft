eval "$(/opt/homebrew/bin/brew shellenv)"
. "$HOME/.cargo/env"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$(yarn global bin):$PATH"
export PATH="$HOME/.local/bin/heroku/bin/:$PATH"

