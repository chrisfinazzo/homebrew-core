class AdbEnhanced < Formula
  include Language::Python::Virtualenv

  desc "Swiss-army knife for Android testing and development"
  homepage "https://ashishb.net/tech/introducing-adb-enhanced-a-swiss-army-knife-for-android-development/"
  url "https://files.pythonhosted.org/packages/6e/97/03a20670350acfba7f8f65bba41123dbebca48a81600563181647c5bfdd0/adb_enhanced-2.9.0.tar.gz"
  sha256 "ea81e5ab640c1a129e4362156ef5ff5b37bb62c1145acd77e259f8c582ea262b"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1263d7bafc377a908cf3db5e8f66cbce9162a7b7c5828b66430d1448820c5552"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "56d8425f29c678d6a9e514886f9dcc54a924a9ef589fa9d3a3d6dc2c638793c5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c62b3fa8bfa4e99547f8ae205f6641e5e0a860a27ac21a3a368d919bebde178c"
    sha256 cellar: :any_skip_relocation, sonoma:        "8e8b2216dbe459c43fc5e995834fd75a0e2e67c9eabcd620454cda596aed9150"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "eb5554a9273161147c22318202c5bfc2fe751d8eccc2593e71d60a5b2c9be6d0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "22a6b1e9ab9a4c2401ffa5ed3b0bf0704c920932f5a2598734be8c3f5373d6ad"
  end

  depends_on "python@3.14"

  resource "docopt" do
    url "https://files.pythonhosted.org/packages/a2/55/8f8cab2afd404cf578136ef2cc5dfb50baa1761b68c9da1fb1e4eed343c9/docopt-0.6.2.tar.gz"
    sha256 "49b3a825280bd66b3aa83585ef59c4a8c82f2c8a522dbe754a8bc8d08c85c491"
  end

  resource "psutil" do
    url "https://files.pythonhosted.org/packages/aa/c6/d1ddf4abb55e93cebc4f2ed8b5d6dbad109ecb8d63748dd2b20ab5e57ebe/psutil-7.2.2.tar.gz"
    sha256 "0746f5f8d406af344fd547f1c8daa5f5c33dbc293bb8d6a16d80b4bb88f59372"
  end

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      At runtime, adb must be accessible from your PATH.

      You can install adb from Homebrew Cask:
        brew install --cask android-platform-tools
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/adbe --version")
    # ADB is not intentionally supplied
    # There are multiple ways to install it and we don't want dictate
    # one particular way to the end user
    assert_match(/(not found)|(No attached Android device found)/, shell_output("#{bin}/adbe devices", 1))
  end
end
