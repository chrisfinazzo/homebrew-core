class CargoShear < Formula
  desc "Detect and remove unused dependencies from `Cargo.toml` in Rust projects"
  homepage "https://github.com/Boshen/cargo-shear"
  url "https://github.com/Boshen/cargo-shear/archive/refs/tags/v1.12.2.tar.gz"
  sha256 "9997f482d936f12a1edb09aa682e3b6ec1d4ca42c1735530a74451eaf05d821f"
  license "MIT"
  head "https://github.com/Boshen/cargo-shear.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "544c4af9b777f95a016e3d83ead598cdbcc8ac7ee43634d23b91422fdc00f438"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6bc97fb370c768c9332147e7a9520370a3f99e9c81416c32fd7f0eaab6d2bb3d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "86b31937188cb3a7461f7ca9c47a47ef48a9576bc4b78a1c7338e1de113adb39"
    sha256 cellar: :any_skip_relocation, sonoma:        "a92e47e42f50c4ecba2ea13799ac15d14d82f5da17abac5a0fb183cbbe7edd9a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "dd5c7d647da5f2490e04f6e631da1a50d5a5f92b0dab999d8abac2fe7916d311"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f73aeec871bab3e829dfae76fd10be5f1e5dc8405c34401d7a29dd57112cda28"
  end

  depends_on "rust" => :build
  depends_on "rustup" => :test

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # Show that we can use a different toolchain than the one provided by the `rust` formula.
    # https://github.com/Homebrew/homebrew-core/pull/134074#pullrequestreview-1484979359
    ENV.prepend_path "PATH", Formula["rustup"].bin
    system "rustup", "set", "profile", "minimal"
    system "rustup", "default", "beta"

    crate = testpath/"demo-crate"
    mkdir crate do
      (crate/"Cargo.toml").write <<~TOML
        [package]
        name = "demo-crate"
        version = "0.1.0"

        [lib]
        path = "lib.rs"

        [dependencies]
        libc = "0.1"
        bear = "0.2"
      TOML

      (crate/"lib.rs").write "use libc;"

      # bear is unused
      assert_match "unused dependency `bear`", shell_output("cargo shear", 1)
    end
  end
end
