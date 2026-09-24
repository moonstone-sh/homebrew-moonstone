class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.5.4"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.4/moon-v0.5.4-aarch64-macos.tar.gz"
    sha256 "67371921eea16744a8f7d8e99d919ad7877e6e4150c5d7244e810fc6a76b75c4"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.4/moon-v0.5.4-x86_64-macos.tar.gz"
    sha256 "4de9d5f891c9fed4e56e9858f505f758628f81f21da5625058412e050bc5c66c"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.4/moon-v0.5.4-aarch64-linux-gnu.tar.gz"
    sha256 "92ad578821c4d735af79df171f950844cb73ed426246c88d4d6aa78ef376e6f8"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.4/moon-v0.5.4-x86_64-linux-gnu.tar.gz"
    sha256 "23fe2db0e8dacba2da5ce9e54fd9a2bd35f372f79e8628b3f8bcb1120c88a188"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.4/moon-v0.5.4-riscv64-linux-gnu.tar.gz"
    sha256 "f7049e24805c5aaa81c41de7d5bb51c4f447d81f99b39ede4c6e693dcbc17860"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.4/moon-v0.5.4-aarch64-freebsd.tar.gz"
      sha256 "eab629760ffc92ea60676c334a0bd44488fd084d503aebfc5f946321e4f9e72a"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.4/moon-v0.5.4-x86_64-freebsd.tar.gz"
      sha256 "a4b300ddc0a76fc5db03442c11491c6ada6944a676cbe8d2b9c0a8c0c439cd6e"
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
