class V2ray < Formula
  desc "Platform for building proxies to bypass network restrictions"
  homepage "https://v2fly.org/"
  url "https://github.com/v2fly/v2ray-core/archive/refs/tags/v5.49.0.tar.gz"
  sha256 "1a63c9179497db2d6bb7027eed5653d2b1dd3e9942b656146e87a7fd28f1d22b"
  license all_of: ["MIT", "CC-BY-SA-4.0"]
  head "https://github.com/v2fly/v2ray-core.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "fc966de896b1bae6e6bc072f17d57dcecda6f53cfec9e4c19fe7b7fe7aa2978c"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fc966de896b1bae6e6bc072f17d57dcecda6f53cfec9e4c19fe7b7fe7aa2978c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "fc966de896b1bae6e6bc072f17d57dcecda6f53cfec9e4c19fe7b7fe7aa2978c"
    sha256 cellar: :any_skip_relocation, sonoma:        "e30e9d2eb78048e8d016cbc681455ed8087d75e2f89978931eda43bf2badc450"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "74885192d94fc66a8f16afd56323323245bf31f39755d6f6539aa338a45ea8df"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bebf9bd3b2eb2e561ecd3858dcd510fc0d8a63ccf013cb261cf34ef9d2b288c1"
  end

  depends_on "go" => :build

  resource "geoip" do
    url "https://github.com/v2fly/geoip/releases/download/202605120112/geoip.dat"
    sha256 "e9002979e0df72bce1c8751ff70725386594c551db684b7a232935b8b2bb8aa2"
  end

  resource "geoip-only-cn-private" do
    url "https://github.com/v2fly/geoip/releases/download/202605120112/geoip-only-cn-private.dat"
    sha256 "b11bf44231eefce4a03f576c6243ed3d589f9ef4d88bf5286ba74698ff6d181b"
  end

  resource "geosite" do
    url "https://github.com/v2fly/domain-list-community/releases/download/20260516132422/dlc.dat"
    sha256 "c4992857ce23464697b498cee60c0d392ce69ba1b48df3e4cc99e4011b86345c"
  end

  def install
    ldflags = "-s -w -buildid="
    system "go", "build", *std_go_args(ldflags:, output: libexec/"v2ray"), "./main"

    (bin/"v2ray").write_env_script libexec/"v2ray",
      V2RAY_LOCATION_ASSET: "${V2RAY_LOCATION_ASSET:-#{pkgshare}}"

    pkgetc.install "release/config/config.json"

    resource("geoip").stage do
      pkgshare.install "geoip.dat"
    end

    resource("geoip-only-cn-private").stage do
      pkgshare.install "geoip-only-cn-private.dat"
    end

    resource("geosite").stage do
      pkgshare.install "dlc.dat" => "geosite.dat"
    end
  end

  service do
    run [opt_bin/"v2ray", "run", "-config", etc/"v2ray/config.json"]
    keep_alive true
  end

  test do
    (testpath/"config.json").write <<~JSON
      {
        "log": {
          "access": "#{testpath}/log"
        },
        "outbounds": [
          {
            "protocol": "freedom",
            "tag": "direct"
          }
        ],
        "routing": {
          "rules": [
            {
              "ip": [
                "geoip:private"
              ],
              "outboundTag": "direct",
              "type": "field"
            },
            {
              "domains": [
                "geosite:private"
              ],
              "outboundTag": "direct",
              "type": "field"
            }
          ]
        }
      }
    JSON
    output = shell_output "#{bin}/v2ray test -c #{testpath}/config.json"

    assert_match "Configuration OK", output
    assert_path_exists testpath/"log"
  end
end
