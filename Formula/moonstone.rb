class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.45"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.45/moon-v0.3.45-aarch64-macos.tar.gz"
    sha256 "a5a6dc85205483da087ae814a353b8b84ae8f8e3db9d2c201fe53cee45ecd27b"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.45/moon-v0.3.45-x86_64-macos.tar.gz"
    sha256 "e25943b14c159fb6723870644dad294c4f39ea861adbdf23a0ed22bf5185c8e8"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.45/moon-v0.3.45-aarch64-linux-gnu.tar.gz"
    sha256 "6e340f4c3807254e56073d6f2b42e07619f3cd2cc6121de0d7164043f5b99643"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.45/moon-v0.3.45-x86_64-linux-gnu.tar.gz"
    sha256 "cc9323085366337bc2086ab3269daae8e3b1dec29fa86c5b09cb606d72fb7e2f"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.45/moon-v0.3.45-riscv64-linux-gnu.tar.gz"
    sha256 "afaa84144e6c9870e22e58b254618a02a8c4725a5c6fbb09b452fd60714d4993"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.45/moon-v0.3.45-aarch64-freebsd.tar.gz"
      sha256 "7a8821bafebcea3746880c0e780247ec83f2a18ced65284513ef6f74fa8383e8"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.45/moon-v0.3.45-x86_64-freebsd.tar.gz"
      sha256 "3f1ccfbd69d3c5c0970413c53040a56b0f71982a4614fec093846c6e12bddda2"
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
