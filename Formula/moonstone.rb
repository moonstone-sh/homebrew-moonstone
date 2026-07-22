class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.30"
  
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.30/moon-aarch64-macos.tar.gz"
    sha256 "fdc2e2e6108cb9eaf0a0c457591233773605fc0cd54806f3b8466987c8e82f18"
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.30/moon-x86_64-macos.tar.gz"
    sha256 "7d8e0644cf175c8e56962dc947295dc00aa0d20dedf55e3bbb8c7b62fd1acf21"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.30/moon-aarch64-linux.tar.gz"
    sha256 "91452960fbf498b6627b21590af2581c4f98e22e424a438502cf45b2b3608866"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.30/moon-x86_64-linux.tar.gz"
    sha256 "03d17d18f374bee4e3cebd8d2781de4fade87a04aaecaf563356c176685f4dec"
  end

  if OS.linux? && Hardware::CPU.riscv64?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.30/moon-riscv64-linux.tar.gz"
    sha256 "bc65e3d58e78b554e16c235170b21b275bb6cefb121040a858cb68e918e11a8e"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.30/moon-aarch64-freebsd.tar.gz"
      sha256 "d802cd920330cbba641af521c658061dc264626778f0709d86a5e778de8cd0d2"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.30/moon-x86_64-freebsd.tar.gz"
      sha256 "f4d80bb8a8979ec87ad52f43efc99d49453075e5e6eb791aefe97087bed6bdc8"
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
