# homebrew-claude-code

Homebrew tap do Claude Code com download via Google Cloud Storage.

Criado para ambientes onde `*.claude.ai` está bloqueado. Usa o bucket GCS oficial da Anthropic
(`storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819`) que distribui
os mesmos binários com os mesmos checksums SHA256.

## Instalação

```bash
brew tap paulohenriquesousadasilva/claude-code
brew install --cask claude-code
```

## Atualização manual do cask

```bash
cd ~/Projects/homebrew-claude-code
bash update_cask.sh
git add Casks/claude-code.rb
git commit -m "chore: bump claude-code to $(grep 'version "' Casks/claude-code.rb | head -1 | sed 's/.*version "\(.*\)".*/\1/')"
git push
```

## Origem dos binários

Os binários são distribuídos pela própria Anthropic via GCS:

```
https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases/{version}/{platform}/claude
```
