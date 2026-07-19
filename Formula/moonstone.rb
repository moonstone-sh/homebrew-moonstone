class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.20"
  
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.20/moon-aarch64-macos.tar.gz"
    sha256 "66fe05a1dad93dbef1441a525a081c6ae0f6fbfee79b6858e897caf7a221413b"
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.20/moon-x86_64-macos.tar.gz"
    sha256 "2285ba9570d3fbae90322e8071eb54b5f4fa2e4fca1cf4f061beab1649b33ac9"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.20/moon-aarch64-linux.tar.gz"
    sha256 "f40728e4b0eccf4a1abd9841cc987bdbfb6f110e8539756fe933fddabfea1e68"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.20/moon-x86_64-linux.tar.gz"
    sha256 "b10164ad4fc554e06fd7d27172712df5081f60c9da302053f632b6f89e0d0821"
  end

  if OS.linux? && Hardware::CPU.riscv64?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.20/moon-riscv64-linux.tar.gz"
    sha256 "27146e5f5ebbfeb2e7d5d09aa9cb845163190450e8c21bbeb4ed1c64dba1e37f"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.20/moon-aarch64-freebsd.tar.gz"
      sha256 "c9419bef006caea52e4ac4cc616ebc1b6d16a3e951825882e902d4925a5a433e"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.20/moon-x86_64-freebsd.tar.gz"
      sha256 "3ee59a43bfbee202605974f068820d948f8f078120cbb0dafc408dd8e54a9935"
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
