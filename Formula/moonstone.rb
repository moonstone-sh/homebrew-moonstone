class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.5.3"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.3/moon-v0.5.3-aarch64-macos.tar.gz"
    sha256 "bbe85afa10dab3f03a962408ee1282b073ebe4fd44d111f7b5cc10d12247beb7"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.3/moon-v0.5.3-x86_64-macos.tar.gz"
    sha256 "caa9d0575543a1ea45d286fba802380ac8e063c6d5c58af0064e816fe1fc2853"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.3/moon-v0.5.3-aarch64-linux-gnu.tar.gz"
    sha256 "cfb8ec33ba0da6b6dbdc64674fdd9b183e358a6f5d10849cc4ec8c62be315d64"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.3/moon-v0.5.3-x86_64-linux-gnu.tar.gz"
    sha256 "44e7bb5aaf31b0a02c29d961d9c4fb788c5cd3c3c76598e55b852030001d0da6"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.3/moon-v0.5.3-riscv64-linux-gnu.tar.gz"
    sha256 "7528a732f94a32d59e7974a10d5d92bc6647251e06d5e43db4a0f1c36091a5f8"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.3/moon-v0.5.3-aarch64-freebsd.tar.gz"
      sha256 "55312f29b59ed6b9f237e3ae559902bb9f6631ef73e14381465f331058e43442"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.3/moon-v0.5.3-x86_64-freebsd.tar.gz"
      sha256 "7165194eda353fcbeb6c94b68e7123081187222eb20b356c0962ecfd4007defc"
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
