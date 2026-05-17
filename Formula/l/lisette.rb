class Lisette < Formula
  desc "Language inspired by Rust that compiles to Go"
  homepage "https://lisette.run"
  url "https://github.com/ivov/lisette/archive/refs/tags/lisette-v0.2.6.tar.gz"
  sha256 "97740c364adfe0603b33aff97b37dc9e046de640bb0565f02e5de21cedeb7105"
  license "MIT"
  head "https://github.com/ivov/lisette.git", branch: "main"

  livecheck do
    url :stable
    regex(/^lisette[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "fc1d152e8754120175cbf7369c568dfb50244e6acc6ddac715e692fd60581308"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "623f0d86983b031944c9edf015f35d24d224f0789d29ca44f944ca1038083c41"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6e1a5308fb4b02db2a45a531081446a4ba23053f1817c4fb840ad70e13790360"
    sha256 cellar: :any_skip_relocation, sonoma:        "c93a41df58b5d9f554c9577861ee688849e87f869590bf6e82f3d292e29edb79"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "92c224abf58536b29e5b9820c151a722cc58bb8f55c72f60a8adafaa569c0e8a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "454623168277af0a4deacf8de2c2101059d7e57ecf0173b0e9c38a768d2fa117"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/cli")

    generate_completions_from_executable(bin/"lis", "complete", shells: [:bash, :zsh, :fish])
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lis version")

    (testpath/"hello.lis").write <<~LIS
      import "go:fmt"

      fn main() {
        fmt.Println("hello")
      }
    LIS
    system bin/"lis", "check", testpath/"hello.lis"
  end
end
