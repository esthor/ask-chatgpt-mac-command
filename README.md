# ask-chatgpt-mac-command
A simple workaround until OpenAI lands on an API for developers to pass messages to ChatGPT's macos App 🤷

## INSTRUCTIONS
1. Put the `chatgpt-mac-helpers.sh` file in your Home directory (`~/`) or wherever you keep custom shell scripts.
2. Make sure to `chmod +x ~/chatgpt-mac-helpers.sh` if you want to run it
3. Restart your shell (or open a new window, or run source command pointing at your shell rc file...you do you, fam.)
4. **Pro Tip**: typing `open_chatgpt_and_ask` is long, use an alias: Add this to you `.zshrc` file: `alias gpt='chatgpt_and_ask'
5. Optionally, for adding this functionality into custom shell scripts or CLIs, just `source chatgpt-mac-helpers.sh`


## REQUIREMENTS
macOS
ChatGPT mac app
zsh (other shells untested)

## Example Instructions
1. Put the `.unified-single-file-example.sh` file in your Home directory (`~/`) or wherever you keep custom shell scripts
2. Open your `~/.zshrc` or other shell config file, add the following: `source ~/.unified-single-file-example.sh`
3. Restart your shell (or open a new window, or run source command pointing at your shell rc file...you do you, fam.)
4. Test that it works by trying to pass a non-existent pnpm command through npm, like `npm yallthisisneeato` and see what ChatGPT says
