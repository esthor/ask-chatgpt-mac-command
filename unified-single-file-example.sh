# INSTRUCTIONS
# Put this file in your Home directory (~/) or wherever you keep custom shell scripts
# in your .zshrc or other shell config file, add the following: source ~/.unified-single-file-example.sh
# Restart your shell (or open a new window, or source command)
# Test that it works by trying to pass a non-existent pnpm command through npm, like `npm yallthisisneeato` and see what ChatGPT says

# REQUIREMENTS
# macOS, ChatGPT mac app, and zsh (other shells untested)

# A function to open ChatGPT, start a new chat, type a message, and press enter.
open_chatgpt_and_ask() {
  local message="$1"
  open -a "ChatGPT"
  osascript <<EOF
    tell application "System Events"
      keystroke "n" using command down
      delay 0.5
      keystroke "$message"
      delay 0.5
      key code 36
    end tell
EOF
}

# Example Usage
# I pretty much always want to use pnpm, but sometimes I forget and it's annoying as heck to then wait and then clean up files...so I want to just catch them. Easy. pnpm has pretty much a 1:1 mapping of commands, and 99% of the time I'm using those. But sometimes maybe not.

# A helper to intercept a given command, with a fallback to pnpm or ChatGPT only if pnpm fails/is missing.
intercept_command() {
  local original_cmd="$1"    # e.g. "yarn" or "npm"
  shift
  local user_args=("$@")

  read -p "Are you sure you don't want to use pnpm? [Y/n] " answer
  if [[ "$answer" == "Y" ]]; then
    # User said yes, so run the original command
    command "$original_cmd" "${user_args[@]}"
  else
    # User said no, so try running pnpm
    echo "Trying pnpm instead..."
    if command -v pnpm &> /dev/null; then
      pnpm "${user_args[@]}"
      # If pnpm fails (non-zero exit), then open ChatGPT
      if [ $? -ne 0 ]; then
        echo "pnpm command failed. Opening ChatGPT..."
        open_chatgpt_and_ask "How do we convert the command [$original_cmd ${user_args[*]}] to pnpm?"
      fi
    else
      # If pnpm isn't installed, we fall back to ChatGPT
      echo "pnpm not found. Falling back to ChatGPT..."
      open_chatgpt_and_ask "How do we convert the command [$original_cmd ${user_args[*]}] to pnpm?"
    fi
  fi
}

# Yarn interceptor
yarn() {
  intercept_command yarn "$@"
}

# NPM interceptor
npm() {
  intercept_command npm "$@"
}
