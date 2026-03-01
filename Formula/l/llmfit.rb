class Llmfit < Formula
  desc "Find what models run on your hardware"
  homepage "https://github.com/AlexsJones/llmfit"
  url "https://github.com/AlexsJones/llmfit/archive/refs/tags/v0.5.2.tar.gz"
  sha256 "699f67b158f6ca04388084d9d5259f81e295280278c91f1b2919bba06e8c9883"
  license "MIT"
  head "https://github.com/AlexsJones/llmfit.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "680c6f8791817f55c752f13d7b7e43d0f316e08d671f5c0cf555a1cd089fa0b3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "52a4cedf2a50a68195909c6d7758c5fc3cbd76405ecbf7a6a644e733c9758194"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "952fbe30ed53bfddca9df4e17d0aaadf5a158fe2f5e824fb3790e1ac3f6fb2b9"
    sha256 cellar: :any_skip_relocation, sonoma:        "74136dbab65420bcfa599335430596e83c1c823187e4ad435fc6f48cbe3a82a3"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3067a1b72c692cec4e317324c4499e7b187d797c49b2b04213d515077be624ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "72cdb9dac60658fd6ed864b11321ffd05dea23070e38000002ef5df500cf07d0"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "llmfit-tui")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/llmfit --version")
    assert_match "Multiple models found", shell_output("#{bin}/llmfit info llama")
  end
end
