class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.5.5"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.5/moon-v0.5.5-aarch64-macos.tar.gz"
    sha256 "25ec3bc17ea9262b55be0d990d8c13fe6ea37d561f2164f41221880d0178185e"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.5/moon-v0.5.5-x86_64-macos.tar.gz"
    sha256 "78a5b15e246d5cf660c9327a8ee7205563d876c31fea16e578a2e28cf1cf17d0"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.5/moon-v0.5.5-aarch64-linux-gnu.tar.gz"
    sha256 "4ca2b960f063fb863d28245a5c37c16634df380287fe804c31d88b6e0c014aa8"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.5/moon-v0.5.5-x86_64-linux-gnu.tar.gz"
    sha256 "6aef28b0da9b87819272889678974e9980a9b5a0b2d7df7e2112b8cc7408f7fd"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.5/moon-v0.5.5-riscv64-linux-gnu.tar.gz"
    sha256 "195fc0c92d9ce95b1c3e5af4e11d5f73e252c6fe68c1828a1616b89160528a59"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.5/moon-v0.5.5-aarch64-freebsd.tar.gz"
      sha256 "9e843811bec2e02d36d3ae4ec56255f4611e98a0ff3142ccfd4e5e1b75e7cc88"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.5/moon-v0.5.5-x86_64-freebsd.tar.gz"
      sha256 "b8eed72e995c6beb7b492e8c0f3974c1d6e447f4c1e3ac9bb474e344aab79e5b"
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
