class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.24"
  
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.24/moon-aarch64-macos.tar.gz"
    sha256 "1f9c72e5e44d613e2f603fe0ccc9dd23372eaf721a9e2e3a553f0a6f079ac30b"
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.24/moon-x86_64-macos.tar.gz"
    sha256 "614d96b827aeb90a84aca7aafaafdee38ab9edb40c219f4e2cf6e5437d40fbb6"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.24/moon-aarch64-linux.tar.gz"
    sha256 "314ac3463771ad9603c440ae36b7a4e2e5e3591a32ed4efc1bb7c9b5e35e8f2a"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.24/moon-x86_64-linux.tar.gz"
    sha256 "505ad774b7f9ca028e47d7060a354a802f7736446fa7b13ab52538c7fa55faaf"
  end

  if OS.linux? && Hardware::CPU.riscv64?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.24/moon-riscv64-linux.tar.gz"
    sha256 "3f0219830adf48fe527f265001638c520ce5938887b198c709000615693b7d4e"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.24/moon-aarch64-freebsd.tar.gz"
      sha256 "698f2e913f87a16c0085fea575f2e93f81c6052cf6a92a80a757e90102f4b00f"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.24/moon-x86_64-freebsd.tar.gz"
      sha256 "1eabcb3e1521f8f4702c3008723cc6b95708bfabcaa3b305668405cc63ef6c96"
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
