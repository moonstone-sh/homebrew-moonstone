class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.32"
  
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.32/moon-aarch64-macos.tar.gz"
    sha256 "cb76cf0060f1cf1f4b63d043efb17a0b57660410527116ff7755df49f1a4eebb"
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.32/moon-x86_64-macos.tar.gz"
    sha256 "f3ef44ed36f7618fab6c2ae85559042e7f92449c581b7f63043438b3cf185f9e"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.32/moon-aarch64-linux.tar.gz"
    sha256 "fdb7f646c586986fe100adaf5dd73ab7db43a856679435e3bf0e46b9699c0f7e"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.32/moon-x86_64-linux.tar.gz"
    sha256 "446d01b0b31efffcd5458552c1a54863e0820b81e478c02c622761940c36fca9"
  end

  if OS.linux? && Hardware::CPU.riscv64?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.32/moon-riscv64-linux.tar.gz"
    sha256 "1a01e83467f5c40f82890797f0c60a09396cdd67c3e939b24de6f055ad7721e5"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.32/moon-aarch64-freebsd.tar.gz"
      sha256 "1a770746765a8570089c74ed9e7de9b3c5255c8e942d1402d16577fd97a27541"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.32/moon-x86_64-freebsd.tar.gz"
      sha256 "5b5d92dbf573a6aeef61e72990d6b8a65948f38f345953e2ad2ddcdd14cd7269"
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
