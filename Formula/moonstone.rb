class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.4.5"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.5/moon-v0.4.5-aarch64-macos.tar.gz"
    sha256 "2e7889ecc3a83490e8a857e71427900a7441bde71a98b9423e7c6d1c7eeff5a3"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.5/moon-v0.4.5-x86_64-macos.tar.gz"
    sha256 "70bdfbd25862791acac58e341aaad31efb7fb133a24cf1736c989cc0d2390b8a"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.5/moon-v0.4.5-aarch64-linux-gnu.tar.gz"
    sha256 "ce5b711fe37f0b5ed140f8f210aa4d24313c2d3b9618515196fbbab8fdefa1a1"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.5/moon-v0.4.5-x86_64-linux-gnu.tar.gz"
    sha256 "94740713e2de8633b2398774120ca82ffebf9692ea2ea9100081a1f29ffafdf1"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.5/moon-v0.4.5-riscv64-linux-gnu.tar.gz"
    sha256 "b557e44fd0a6c40ace70df0e579d8b1e010c21b7bb684cbee16788e7c346c143"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.5/moon-v0.4.5-aarch64-freebsd.tar.gz"
      sha256 "704f5067ed79612ec75920c69eb7a5b80197dcf7a3d9a9cf1b6e904fa1295ecb"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.5/moon-v0.4.5-x86_64-freebsd.tar.gz"
      sha256 "a64d02c93b66a259e55f39231346ba23bd3e3732c2a38c01c24c6aa2ebb0518d"
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
