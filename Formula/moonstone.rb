class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.20"
  
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.20/moon-aarch64-macos.tar.gz"
    sha256 "3a697c92f8b67639193bb034650c882bb96ad8b5b9bf1f382d78be5bc1ad5b10"
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.20/moon-x86_64-macos.tar.gz"
    sha256 "c654df9b84f822b1d59bff1a3c15fef1be321d66d7409fa29ab3c63af2cfd91d"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.20/moon-aarch64-linux.tar.gz"
    sha256 "7410c8382ded7eac5d7eff0f6a41b218bcf1136722cfe7fbcda4e64eb5a23202"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.20/moon-x86_64-linux.tar.gz"
    sha256 "ce7ecd81b711a5501dba73d14b989c2d89fe95d7aa64c50f17b60cc9330a8c39"
  end

  if OS.linux? && Hardware::CPU.riscv64?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.20/moon-riscv64-linux.tar.gz"
    sha256 "847ae217e98cdc9e426b5706f330f7b26d28627a830572110e0cb2b82022d228"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.20/moon-aarch64-freebsd.tar.gz"
      sha256 "435b655f8de97db3fedbea6e4e3968846e95d7dd471f1b32de8dcc4d8cf19b54"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.20/moon-x86_64-freebsd.tar.gz"
      sha256 "f37712f2ed6c70ec69565ba32c50200991fa61c238ea9a42fd8d1a0cfb98c65e"
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
