# sourcing this from bash profile will not work since
# sourcing files runs them in a different environment than
# the session you're in. So to use this, paste both
# the alias and the function into your bash_profile.

alias activate=activate_python_env

# check if there's a dir called env. If so
# activate venv. If not, check if there's
# a folder called venv. If so, activate venv.
# else print not found.
function activate_python_env {
  env="env"
  venv="venv"
  if [ -d "$env" ]; then
    source env/bin/activate
  elif [ -d "$venv" ]; then
    source venv/bin/activate
  else
    echo "no env or venv directory found"
  fi
}