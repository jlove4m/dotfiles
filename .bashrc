# Source .bash_profile if this is not a login shell
# (in which case it *should* already be sourced)
[[ $- != *l* ]] && . .bash_profile

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
