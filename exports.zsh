eval "$(/opt/homebrew/bin/brew shellenv)"
. "$HOME/.cargo/env"

[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

export PATH="$HOME/.local/bin/heroku/bin/:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$(yarn global bin):$PATH"
