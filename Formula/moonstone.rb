class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.4.11"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.11/moon-v0.4.11-aarch64-macos.tar.gz"
    sha256 "4cf6a6672132aa80559dc47b7b72a492b76539d4dddeb05f5612c6032f28c236"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.11/moon-v0.4.11-x86_64-macos.tar.gz"
    sha256 "e56168df42a3a751d588495641e344b128e35bf0af3f583f57fa49118ca3ee04"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.11/moon-v0.4.11-aarch64-linux-gnu.tar.gz"
    sha256 "49f69ea846451eaead9728313f9db640052bb8131e68d2cea9f551576c9d88a6"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.11/moon-v0.4.11-x86_64-linux-gnu.tar.gz"
    sha256 "ebc509058a89e644d759c56595f11b91e6bbf2f041f2bdf65ccb704d92a10848"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.11/moon-v0.4.11-riscv64-linux-gnu.tar.gz"
    sha256 "2078403cc18dacf8b18544ca746dcf3e18d3c4b39b0b489820863a9094c97b3a"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.11/moon-v0.4.11-aarch64-freebsd.tar.gz"
      sha256 "1a3613def787e779a2ad1751467508103c8c0630ba61e20f364c38af961afa56"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.11/moon-v0.4.11-x86_64-freebsd.tar.gz"
      sha256 "723b2f7150499b8db49779a0ab3173a3727474f8762f4923ef25771eabac5463"
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
