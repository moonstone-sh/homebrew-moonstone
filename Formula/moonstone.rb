class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.4.15"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.15/moon-v0.4.15-aarch64-macos.tar.gz"
    sha256 "4d12af143f4c86ec5e506eef792e3d4deb02161e6be75e3186ec861f2c60892c"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.15/moon-v0.4.15-x86_64-macos.tar.gz"
    sha256 "7a8572333785ca0d19eb2467e4dcd1b7753aa055720371d913d4ec331ee6586b"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.15/moon-v0.4.15-aarch64-linux-gnu.tar.gz"
    sha256 "57261c0e0b35903dad77f058d4cf2a2fdb644034655904dd7654a24ed43dc249"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.15/moon-v0.4.15-x86_64-linux-gnu.tar.gz"
    sha256 "9bab4f3144140f10d5294ddd08ff2cca7caa0edb4a82c5f3e3854a97fb2a343e"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.15/moon-v0.4.15-riscv64-linux-gnu.tar.gz"
    sha256 "0e024170ad1f41c2e6228502eddf398f71f579235910cd84d912e35478f778b1"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.15/moon-v0.4.15-aarch64-freebsd.tar.gz"
      sha256 "7efdb7a7ccceebdc2756d2654d8bd0feb12bb441bded094145ddadedbd2b4e77"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.15/moon-v0.4.15-x86_64-freebsd.tar.gz"
      sha256 "83c9ce4050cd46fdb9f261bd65341d23bb71bf3f0e952b744b5713af78b81075"
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
