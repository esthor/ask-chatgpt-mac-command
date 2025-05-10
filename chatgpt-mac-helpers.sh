# ──────────────────────────────────────────────────────────────────────────────
# expose a single function for all your zshrc scripts to call
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
