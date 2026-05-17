class LlamaCpp < Formula
  desc "LLM inference in C/C++"
  homepage "https://github.com/ggml-org/llama.cpp"
  # CMake uses Git to generate version information.
  url "https://github.com/ggml-org/llama.cpp.git",
      tag:      "b9190",
      revision: "b64739ea393b3c9d07cc9907e0a611f707838051"
  license "MIT"
  compatibility_version 1
  head "https://github.com/ggml-org/llama.cpp.git", branch: "master"

  # llama.cpp publishes new tags too often
  # Having multiple updates in one day is not very convenient
  # Update formula only after 10 new tags (1 update per ≈2 days)
  #
  # `throttle 10` doesn't work
  livecheck do
    url :stable
    regex(/^v?b(\d+(?:\.\d+)*0)$/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_tahoe:   "b09653b1ddfe3314ac727fe2bcab31b148fc99c94c699c9e7549f1532f007ba3"
    sha256 cellar: :any,                 arm64_sequoia: "bd5052792665b5a244deaaf12454080ff6c15dd2c9fadfa84ee8e4a4338b90f9"
    sha256 cellar: :any,                 arm64_sonoma:  "6b4070db69aa1c10afb1074f7f38767cf0b5253a0c8c718fad4e2bacd0f1fb80"
    sha256 cellar: :any,                 sonoma:        "9cc3c367dbdd5344e36c23825a4a4d35bb76e895f4466c8dc7b7d6fd5a400c4e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2489564594cd3b479943d7f3c5b10ffe6f1d4361f0e8ea3af680d471efc88627"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dbc7d331f620d742d3715d4bfa3560a27d078812dd442824c18e0a43fa570760"
  end

  depends_on "cmake" => [:build, :test]
  depends_on "ggml" # NOTE: reject all PRs that try to bundle ggml
  depends_on "openssl@3"

  def install
    args = %W[
      -DBUILD_SHARED_LIBS=ON
      -DCMAKE_INSTALL_RPATH=#{rpath}
      -DLLAMA_ALL_WARNINGS=OFF
      -DLLAMA_BUILD_TESTS=OFF
      -DLLAMA_OPENSSL=ON
      -DLLAMA_USE_SYSTEM_GGML=ON
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    pkgshare.install "tests/test-sampling.cpp"
  end

  test do
    (testpath/"CMakeLists.txt").write <<~CMAKE
      cmake_minimum_required(VERSION 4.0)
      project(test LANGUAGES CXX)
      set(CMAKE_CXX_STANDARD 17)
      find_package(llama REQUIRED)
      add_executable(test-sampling #{pkgshare}/test-sampling.cpp)
      target_link_libraries(test-sampling PRIVATE llama)
    CMAKE

    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "./build/test-sampling"

    # The test below is flaky on slower hardware.
    return if OS.mac? && Hardware::CPU.intel? && MacOS.version <= :monterey

    system bin/"llama-completion", "--hf-repo", "ggml-org/tiny-llamas",
                                   "-m", "stories260K.gguf",
                                   "-n", "400", "-p", "I", "-ngl", "0"
  end
end
