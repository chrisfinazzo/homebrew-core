class Cdecl < Formula
  desc "Turn English phrases to C or C++ declarations"
  homepage "https://github.com/paul-j-lucas/cdecl"
  url "https://github.com/paul-j-lucas/cdecl/releases/download/cdecl-18.7.1/cdecl-18.7.1.tar.gz"
  sha256 "64e7791facb67a8896e1a32b3e604ad64e56d0213dc88499159faaa7147116c0"
  license all_of: [
    "GPL-3.0-or-later",
    "LGPL-2.1-or-later", # gnulib
    :public_domain, # original cdecl
  ]

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "0122cc38b2d051e903cefa313e30647caa1fef58050843f617a835aee55edc01"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c8672025a42289d325138b5375f34b9a8c337b5565271cbba4909eeb932053c5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "fd355b54bd1aa3ceefa5d718865681873cd287d36436735be9fcd20d53c7f8e3"
    sha256 cellar: :any_skip_relocation, sonoma:        "bf35d030ac92cc004450847507de84eba43beeb0179fc5996bfcc47483e8a86e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "654e66e321f72f5d6c1e48b271510c6dceb8d5e075a43528ae9b27d93d4cef6e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "afc6ba13900e04d486e1fef968bf865407b05c6c7e0318ee49f09448c7878336"
  end

  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build
  uses_from_macos "ncurses"

  on_linux do
    depends_on "readline"
  end

  def install
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    assert_equal "declare a as pointer to integer",
                 shell_output("#{bin}/cdecl explain int *a").strip
  end
end
