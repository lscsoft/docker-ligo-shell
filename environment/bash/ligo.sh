if [[ $USER == "root" ]] ; then
  return
fi

export S6_SEGMENT_SERVER=https://segments-s6.ligo.org
export LIGO_DATAFIND_SERVER=datafind.ligo.org:443

#
# Only print messages when in a login shell
#
user_message()
{
  # fix to make more zsh friendly
  # if shopt -q login_shell ; then
  if [ -t 0 ]; then
    echo $1
  fi

  return 0
}

user_message "--------------------------------------------------------------------------------"
user_message "Welcome to the LIGO Computing Environment. For support, please raise issues at:"
user_message ""
user_message "https://github.com/lscsoft/docker-ligo-shell"
user_message "--------------------------------------------------------------------------------"
