class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.7.1"
  revision 0
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.7.1/moon-v0.7.1-aarch64-macos.tar.gz"
    sha256 "a46b7d207bdfe35f2f19d02b4c5c9b5ac3981e7a5f45920168f8d0ebf80348f7"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.7.1/moon-v0.7.1-x86_64-macos.tar.gz"
    sha256 "fa763dbfa27ee91095e6489b33ad6eaf9d9fda886f4d98404b8a6be87af73f01"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.7.1/moon-v0.7.1-aarch64-linux-gnu.tar.gz"
    sha256 "d3287856a9be6903116c3a4591973b7605d4adfd32a682b023c4645b1f2da04d"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.7.1/moon-v0.7.1-x86_64-linux-gnu.tar.gz"
    sha256 "c471dbb4cc2b3e457efceaa72c1b46075992a33cca104a7fed1c95a819113fb0"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.7.1/moon-v0.7.1-riscv64-linux-gnu.tar.gz"
    sha256 "699459e1ab8a43e510979d236c868d4f8d6b7a4c0fcf88fbf14044f05857cb7f"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.7.1/moon-v0.7.1-aarch64-freebsd.tar.gz"
      sha256 "e0d151fe41dad4a03a65c1fe99a1afc6fb7e8c583bb2e27e261e73494b7e8eba"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.7.1/moon-v0.7.1-x86_64-freebsd.tar.gz"
      sha256 "2b540bb303e0ceb91ebfc2b99be52ce8990461c7220e83043ddc3f5418f5bf5a"
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
