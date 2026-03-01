class ClaudeSquad < Formula
  desc "Manage multiple AI agents like Claude Code, Aider and Codex in your terminal"
  homepage "https://smtg-ai.github.io/claude-squad/"
  url "https://github.com/smtg-ai/claude-squad/archive/refs/tags/v1.0.15.tar.gz"
  sha256 "ca282b017fbf989875f54b1b8f0e766a8fbaf1eb2e7584cad818f57109e76634"
  license "AGPL-3.0-only"
  head "https://github.com/smtg-ai/claude-squad.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "6f8dea5a8a5d1e8fa2f5a2bafcfb27658ec0b187d18b883944df58c7196616cc"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6f8dea5a8a5d1e8fa2f5a2bafcfb27658ec0b187d18b883944df58c7196616cc"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6f8dea5a8a5d1e8fa2f5a2bafcfb27658ec0b187d18b883944df58c7196616cc"
    sha256 cellar: :any_skip_relocation, sonoma:        "99cea34f7480a8d988dbb87a99a33329ecbe9d835a14a13137452811cbdcde11"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5bae22a832ac00ac9c616542373480466beb3e2865e20f38e607667d5ceb2997"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ae3ce6ced6f4f08bd0a686947683683468c7e388c6ae19fcb0d4ba7e5628794d"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
    generate_completions_from_executable(bin/"claude-squad", shell_parameter_format: :cobra)
  end

  test do
    output = shell_output(bin/"claude-squad")
    assert_includes output, "claude-squad must be run from within a git repository"
  end
end
