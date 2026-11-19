cask "claude-code" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "2.1.328"
  sha256 arm:          "e85547190ef8cd983033ba61b17194045a6fea00035da349efeabed86badacc9",
         x86_64:       "bf40a5555c01e6afe6c028fbe0782f93580f4f0835fd5d13022e039ec76507e1",
         arm64_linux:  "307f8bada27b37db7553fac75e86004e3dbff5a931ffc611b54fe710ce1eb521",
         x86_64_linux: "a982d38030b97e750848add2cbb2df6d9a70d5544a22ca9b216a349ba25865e8"

  url "https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases/#{version}/#{os}-#{arch}/claude"
  name "Claude Code"
  desc "Terminal-based AI coding assistant"
  homepage "https://claude.com/product/claude-code"

  livecheck do
    url "https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases/latest"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  binary "claude"

  zap trash: [
        "~/.cache/claude",
        "~/.claude.json*",
        "~/.config/claude",
        "~/.local/bin/claude",
        "~/.local/share/claude",
        "~/.local/state/claude",
        "~/Library/Caches/claude-cli-nodejs",
      ],
      rmdir: "~/.claude"
end
