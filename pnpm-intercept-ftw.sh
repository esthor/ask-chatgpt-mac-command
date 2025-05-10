# bring in the ChatGPT bits
source ~/chatgpt-mac-helpers.sh

intercept_command() {
  local original_cmd="$1"; shift
  local user_args=( "$@" )

  read -p "Are you sure you don't want to use pnpm? [Y/n] " ans
  if [[ "$ans" == "Y" ]]; then
    command "$original_cmd" "${user_args[@]}"
    return
  fi

  echo "Trying pnpm instead…"
  if command -v pnpm &>/dev/null; then
    pnpm "${user_args[@]}"
    if [[ $? -ne 0 ]]; then
      echo "pnpm failed—opening ChatGPT for help…"
      open_chatgpt_and_ask "How do we convert [$original_cmd ${user_args[*]}] to pnpm?"
    fi
  else
    echo "pnpm not found—opening ChatGPT for help…"
    open_chatgpt_and_ask "How do we convert [$original_cmd ${user_args[*]}] to pnpm?" 
  fi
}

# wire up your interceptors
yarn() { intercept_command yarn "$@"; }
npm()  { intercept_command npm  "$@"; }
