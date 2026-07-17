class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.19"
  
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.19/moon-aarch64-macos.tar.gz"
    sha256 "2384a4f6e0c1bed09e4e60edb8f402f1945921d01bbb2ed91e78595a416da537"
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.19/moon-x86_64-macos.tar.gz"
    sha256 "66f47c4239b92c3873796ac6c30c397ebec19df483b1b8f351ac39f1d83e280d"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.19/moon-aarch64-linux.tar.gz"
    sha256 "95764dd8548fd674cd9d0e3db54102feaf7c81f95f6ae799c1360be1ad4f6dcf"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.19/moon-x86_64-linux.tar.gz"
    sha256 "7096518a2b457d4b8a2492a08505d691f749a43642ecda8421543ece04ab9461"
  end

  if OS.linux? && Hardware::CPU.riscv64?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.19/moon-riscv64-linux.tar.gz"
    sha256 "668e9659bab37ba0fdf71a6ae520cffb60672b7833ca84c6cf0e3aed4371ae6b"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.19/moon-aarch64-freebsd.tar.gz"
      sha256 "d0cc03ca924bc34a11a6db52d37a8af5ea4f0aab93f2a727321b58bafd8af1c7"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.19/moon-x86_64-freebsd.tar.gz"
      sha256 "9e27c914bec08e63f4ea3df7e86f63a201506553b6692b94617731bcf2c794c3"
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
