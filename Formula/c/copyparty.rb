class Copyparty < Formula
  include Language::Python::Virtualenv

  desc "Portable file server"
  homepage "https://github.com/9001/copyparty"
  url "https://files.pythonhosted.org/packages/74/f0/b0ab9da9c673451cf106acce025c3db06e38dc53b497c027e74fe1cdee34/copyparty-1.18.8.tar.gz"
  sha256 "7cb3cbb988095cc606637fe3d4924c328fde54e962fc760de771395a321f2245"
  license "MIT"

  bottle do
    sha256 cellar: :any,                 arm64_sequoia: "4d3db0fcacd3169e6419a8d15746aa37f82ed65ef78e75c8639a3e54d8bc4776"
    sha256 cellar: :any,                 arm64_sonoma:  "5fbf26352c53d9015e838208a71c0157b6bfd2f6dec47550c997740d4d53bea4"
    sha256 cellar: :any,                 arm64_ventura: "e68a1761a119563622e3595bb115dca409e85ff87d454d7b35f3968348670c4c"
    sha256 cellar: :any,                 sonoma:        "aee48a89c828a3876d50b3d58efbdde745898778cf8aca573a7af3fd7e5eda3f"
    sha256 cellar: :any,                 ventura:       "71a63dd6fa14e1af57af4604288103b9c0a66974d0deec2ea62c324926c31690"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5ace953edb3f0ad6fd58b3489840481b033cb6e725f46fa2881502381c86bbd5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "708ce02956d6d5ffc4f824c425d11bf5b6481cd2886469d754187794d377792f"
  end

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build
  depends_on "cryptography"
  depends_on "python@3.13"
  depends_on "vips"
  depends_on "zeromq"

  resource "argon2-cffi" do
    url "https://files.pythonhosted.org/packages/0e/89/ce5af8a7d472a67cc819d5d998aa8c82c5d860608c4db9f46f1162d7dab9/argon2_cffi-25.1.0.tar.gz"
    sha256 "694ae5cc8a42f4c4e2bf2ca0e64e51e23a040c6a517a85074683d3959e1346c1"
  end

  resource "argon2-cffi-bindings" do
    url "https://files.pythonhosted.org/packages/5c/2d/db8af0df73c1cf454f71b2bbe5e356b8c1f8041c979f505b3d3186e520a9/argon2_cffi_bindings-25.1.0.tar.gz"
    sha256 "b957f3e6ea4d55d820e40ff76f450952807013d361a65d7f28acc0acbf29229d"
  end

  resource "jinja2" do
    url "https://files.pythonhosted.org/packages/df/bf/f7da0350254c0ed7c72f3e33cef02e048281fec7ecec5f032d4aac52226b/jinja2-3.1.6.tar.gz"
    sha256 "0137fb05990d35f1275a587e9aee6d56da821fc83491a0fb838183be43f66d6d"
  end

  resource "markupsafe" do
    url "https://files.pythonhosted.org/packages/b2/97/5d42485e71dfc078108a86d6de8fa46db44a1a9295e89c5d6d4a06e23a62/markupsafe-3.0.2.tar.gz"
    sha256 "ee55d3edf80167e48ea11a923c7386f4669df67d7994554387f84e7d8b0a2bf0"
  end

  resource "mutagen" do
    url "https://files.pythonhosted.org/packages/81/e6/64bc71b74eef4b68e61eb921dcf72dabd9e4ec4af1e11891bbd312ccbb77/mutagen-1.47.0.tar.gz"
    sha256 "719fadef0a978c31b4cf3c956261b3c58b6948b32023078a2117b1de09f0fc99"
  end

  resource "partftpy" do
    url "https://files.pythonhosted.org/packages/8c/96/642bb3ddcb07a2c6764eb29aa562d1cf56877ad6c330c3c8921a5f05606d/partftpy-0.4.0.tar.gz"
    sha256 "e50db3cae27cf763c66666fe61783464f5bf0caf110cbd6e1348f91cf77859ed"
  end

  resource "pyasynchat" do
    url "https://files.pythonhosted.org/packages/8a/fd/aacc6309abcc5a388c66915829cd8175daccac583828fde40a1eea5768e4/pyasynchat-1.0.4.tar.gz"
    sha256 "3f5333df649e46c56d48c57e6a4b7163fd07f626bfd884e22ef373ab3c3a4670"
  end

  resource "pyasyncore" do
    url "https://files.pythonhosted.org/packages/25/6e/956e2bc9b47e3310cd524036f506b779a77788c2a1eb732e544240ad346f/pyasyncore-1.0.4.tar.gz"
    sha256 "2c7a8b9b750ba6260f1e5a061456d61320a80579c6a43d42183417da89c7d5d6"
  end

  resource "pyftpdlib" do
    url "https://files.pythonhosted.org/packages/b4/0c/32bf0a7c88efe147bc3bc6586216d92269d196c59f149b05efa973834946/pyftpdlib-2.0.1.tar.gz"
    sha256 "ef0d172a82bfae10e2dec222e87533514609d41bf4b0fd0f07e29d4380fb96bf"
  end

  resource "pyopenssl" do
    url "https://files.pythonhosted.org/packages/04/8c/cd89ad05804f8e3c17dea8f178c3f40eeab5694c30e0c9f5bcd49f576fc3/pyopenssl-25.1.0.tar.gz"
    sha256 "8d031884482e0c67ee92bf9a4d8cceb08d92aba7136432ffb0703c5280fc205b"
  end

  resource "pyvips" do
    url "https://files.pythonhosted.org/packages/4c/a2/d8ecd2f7ffa084870ba071a584aac44800a89f3c77b305999be7dc8b7bb3/pyvips-3.0.0.tar.gz"
    sha256 "79459975e4a16089b0eaafed26eb1400ae66ebc16d3ff3a7d2241abcf19dc9e8"
  end

  resource "pyzmq" do
    url "https://files.pythonhosted.org/packages/f1/06/50a4e9648b3e8b992bef8eb632e457307553a89d294103213cfd47b3da69/pyzmq-27.0.0.tar.gz"
    sha256 "b1f08eeb9ce1510e6939b6e5dcd46a17765e2333daae78ecf4606808442e52cf"
  end

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      If you need to generate thumbnails for video/audio files:
        brew install ffmpeg
      If you need to automatically create a CA and server-cert on startup:
        brew install cfssl
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/copyparty --version")

    require "pty"

    port = free_port
    PTY.spawn(bin/"copyparty", "-q", "-p", port.to_s, "-lo", testpath/"log.txt") do |_r, w, pid|
      sleep 3
      w.close
    ensure
      Process.kill "TERM", pid
      Process.wait pid
    end

    assert_path_exists testpath/"log.txt"
    output = File.read(testpath/"log.txt")
    assert_match "listening @ [::]:#{port}", output
  end
end
