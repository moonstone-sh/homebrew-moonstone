class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.5.9"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.9/moon-v0.5.9-aarch64-macos.tar.gz"
    sha256 "aea19aa76b91e46b067e1a8a9e9d744ec599b7694981406cca52cc77e01750c6"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.9/moon-v0.5.9-x86_64-macos.tar.gz"
    sha256 "37572a0856f678dc99b6a2ab4d7e2477c7aeb2fc507557ae03ea3f3ae90c7f10"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.9/moon-v0.5.9-aarch64-linux-gnu.tar.gz"
    sha256 "1956d1246e8cc176df3c410b7d1ca17bfe30c4824946c457592c95d611f0992c"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.9/moon-v0.5.9-x86_64-linux-gnu.tar.gz"
    sha256 "d8aee8c8c7eba906260424e621e833c28f46b561e68be25cd329a4b346f9ee87"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.9/moon-v0.5.9-riscv64-linux-gnu.tar.gz"
    sha256 "a375d346e7da29c8b17286902725d0f826c288818ad1c97a5d6d49b582d95780"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.9/moon-v0.5.9-aarch64-freebsd.tar.gz"
      sha256 "822cd5286e0340fbcc375ab107d76f05992a7a6d5f7bdb030dbae43f09005b5e"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.9/moon-v0.5.9-x86_64-freebsd.tar.gz"
      sha256 "5df1e278573fbae83c60d852c9c385f0a07dc9e1cfd50a606a3e504aac497a60"
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
