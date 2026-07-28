class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.49"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.49/moon-v0.3.49-aarch64-macos.tar.gz"
    sha256 "1c7cd5d207f6a87cdca8677a6045c68d1541b28a7fb844ef3d21e0c460f90c93"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.49/moon-v0.3.49-x86_64-macos.tar.gz"
    sha256 "954f915febc22c83a69069d106db5e8f942db85e7ded262552048eae6a067ac9"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.49/moon-v0.3.49-aarch64-linux-gnu.tar.gz"
    sha256 "df18b0717c0df166cd9d119564ce31d4fa4e7d2e709147f62d93b4ff688c91bf"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.49/moon-v0.3.49-x86_64-linux-gnu.tar.gz"
    sha256 "911c028f0c9003c582a280ca4cbf850db0d6c5da994631946411da9713868255"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.49/moon-v0.3.49-riscv64-linux-gnu.tar.gz"
    sha256 "1a7f3fc852cc6ce4597eb3e49acf5856a98ef68f9167159e0c41f410f544c9f1"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.49/moon-v0.3.49-aarch64-freebsd.tar.gz"
      sha256 "5db0f69d9ee60add9755d3d53eb8eb1e8100b9397fc18fb293f07de3b2cc8123"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.49/moon-v0.3.49-x86_64-freebsd.tar.gz"
      sha256 "6fed1b1920242a85d4be82358e03aa9256374a40c70cd6a202e15a033cef0715"
    end
  end

  def install
    bin.install "moon"
  end

  def post_install
    Utils.popen_read(
      "curl", "-fsS", "--connect-timeout", "2", "--max-time", "5",
      "-X", "POST", "-H", "Content-Type: application/json",
      "--data", '{"source":"homebrew"}',
      "https://moonstone.sh/api/metrics/installations",
    )
  end

  test do
    system "#{bin}/moon", "version"
  end
end
