class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.4.12"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.12/moon-v0.4.12-aarch64-macos.tar.gz"
    sha256 "8088f5c8b1593f164cf2cc98b9b35f98892546546142e486040e773d99375173"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.12/moon-v0.4.12-x86_64-macos.tar.gz"
    sha256 "c7c9b2f97a2d1eba299b7941ca9275e845094694be72cebc392c60380244de98"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.12/moon-v0.4.12-aarch64-linux-gnu.tar.gz"
    sha256 "2c79965cad10f268fbc8162ed42c58dad7a4c1785305855714fd09ad32493ce8"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.12/moon-v0.4.12-x86_64-linux-gnu.tar.gz"
    sha256 "212401d9aa9b3c2decf6e4af3723efe070140f0b79067f00631516c2ab41f41a"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.12/moon-v0.4.12-riscv64-linux-gnu.tar.gz"
    sha256 "9dc52c4682c925ccd85d9e0b435829e968ae3c4c96d0cbb6ed40d99d7835ed08"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.12/moon-v0.4.12-aarch64-freebsd.tar.gz"
      sha256 "277e5ccb5a98ad7a69916dc8a2eaaee5806163eab420140536ab558b06be66f6"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.12/moon-v0.4.12-x86_64-freebsd.tar.gz"
      sha256 "1190f595016f525779632a4be30a9a1281fd2bcae93929a310a03c89e644b269"
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
