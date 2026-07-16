class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.15"
  
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.15/moon-aarch64-macos.tar.gz"
    sha256 ""
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.15/moon-x86_64-macos.tar.gz"
    sha256 ""
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.15/moon-aarch64-linux.tar.gz"
    sha256 ""
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.15/moon-x86_64-linux.tar.gz"
    sha256 ""
  end

  def install
    bin.install "moon"
  end

  test do
    system "#{bin}/moon", "version"
  end
end
