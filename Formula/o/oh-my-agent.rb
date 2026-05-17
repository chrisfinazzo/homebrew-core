class OhMyAgent < Formula
  desc "Portable multi-agent harness for .agents-based skills and workflows"
  homepage "https://github.com/first-fluke/oh-my-agent"
  url "https://registry.npmjs.org/oh-my-agent/-/oh-my-agent-7.14.1.tgz"
  sha256 "fc8b6971035206ec43b8696e94402c2fb37071f8f2a1ad9ba17931d0a3f10877"
  license "MIT"

  bottle do
    sha256 cellar: :any,                 arm64_tahoe:   "ed3ada19ef620585e7dd6189bc59c187c10870822c3a83135eb00bdf95b68ecc"
    sha256 cellar: :any,                 arm64_sequoia: "bdf8030938c218579e41f44fb99b8caba924acd84f1b1b242b10c2ef87008dd7"
    sha256 cellar: :any,                 arm64_sonoma:  "bdf8030938c218579e41f44fb99b8caba924acd84f1b1b242b10c2ef87008dd7"
    sha256 cellar: :any,                 sonoma:        "552bc6f4a084f45e01b52253dffce8b80dafcde970a5309923cd6431cc6b74ca"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "85f6d795f5cbf78c33e7130dbf1a0da237205e04fca594b01d7ddf5168c2405b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d48af5c5e2010e9e773fa343ff27ad5f7b2a30fb5d9a8d4d3d7d4d10fd8c4f9c"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args

    node_modules = libexec/"lib/node_modules/oh-my-agent/node_modules"
    # Remove incompatible pre-built `bare-fs`/`bare-os`/`bare-url` binaries
    os = OS.kernel_name.downcase
    arch = Hardware::CPU.intel? ? "x64" : Hardware::CPU.arch.to_s
    node_modules.glob("{bare-fs,bare-os,bare-url}/prebuilds/*")
                .each { |dir| rm_r(dir) if dir.basename.to_s != "#{os}-#{arch}" }

    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/oh-my-agent --version")

    output = JSON.parse(shell_output("#{bin}/oh-my-agent memory:init --json"))
    assert_empty output["updated"]
    assert_path_exists testpath/".serena/memories/orchestrator-session.md"
    assert_path_exists testpath/".serena/memories/task-board.md"
  end
end
