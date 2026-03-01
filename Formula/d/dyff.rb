class Dyff < Formula
  desc "Diff tool for YAML files, and sometimes JSON"
  homepage "https://github.com/homeport/dyff"
  url "https://github.com/homeport/dyff/archive/refs/tags/v1.11.1.tar.gz"
  sha256 "88080eb1e15880ec7425d7425f6a459f93a9bcc1c4c8e38c2190dbf120fa4099"
  license "MIT"
  head "https://github.com/homeport/dyff.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "08f8d87e5c5628258d5f6fb14fd727f8ade6c0cea3edc6c0d9a51bd488629f0c"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "08f8d87e5c5628258d5f6fb14fd727f8ade6c0cea3edc6c0d9a51bd488629f0c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "08f8d87e5c5628258d5f6fb14fd727f8ade6c0cea3edc6c0d9a51bd488629f0c"
    sha256 cellar: :any_skip_relocation, sonoma:        "f3055c7bddcbd67f9eea710e6aa507212937702eef6c5af9b1462261e698238f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cf9f1316f857ca81c0bcbe1a2fd8051b267c4608762e694c3940aeaee11fbffe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "565377cdf1c87b86b7b74b5db2c874ada9ccd5af108ea5adc55a68a0cb50dabc"
  end

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/homeport/dyff/internal/cmd.version=#{version}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/dyff"

    generate_completions_from_executable(bin/"dyff", shell_parameter_format: :cobra)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dyff version")

    (testpath/"file1.yaml").write <<~YAML
      name: Alice
      age: 30
    YAML

    (testpath/"file2.yaml").write <<~YAML
      name: Alice
      age: 31
    YAML

    output = shell_output("#{bin}/dyff between file1.yaml file2.yaml")
    assert_match <<~EOS, output
      age
        ± value change
          - 30
          + 31
    EOS
  end
end
