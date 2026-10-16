class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.7.0"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.7.0/moon-v0.7.0-aarch64-macos.tar.gz"
    sha256 "e0f0278be9f69dd07b8314aba70f822bf691f2fd717de9b2b4ad240409a2307c"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.7.0/moon-v0.7.0-x86_64-macos.tar.gz"
    sha256 "7270b0e6c22dce4233045991ea4d6a6d276260be19947b2f8867fdfcf4406b7c"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.7.0/moon-v0.7.0-aarch64-linux-gnu.tar.gz"
    sha256 "36c225fdf074063133e11ad9079aab888e39cb94b2b4303c4a88c8605b731cb2"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.7.0/moon-v0.7.0-x86_64-linux-gnu.tar.gz"
    sha256 "db741ba9461a62005acb665b0e20daadf7d75f2ecb56d656d8483ee9987d66c8"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.7.0/moon-v0.7.0-riscv64-linux-gnu.tar.gz"
    sha256 "61edea72153a59daf8be28d10bcc2721336ef479e0f7957a03169dea0b29bad5"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.7.0/moon-v0.7.0-aarch64-freebsd.tar.gz"
      sha256 "e8c5ed0ef6b45f19d0f989f37c09c781014f9b6f62902b9e0f7b4e5fb475be77"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.7.0/moon-v0.7.0-x86_64-freebsd.tar.gz"
      sha256 "092619ad048c10b4743bd618346d8af5811abf14c687a04607fc14e61a137156"
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
