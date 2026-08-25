class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.4.3"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.3/moon-v0.4.3-aarch64-macos.tar.gz"
    sha256 "4357ab809813b0ddb26ed33cc02c39daa02080bbcb7c717bf2bc9eb627f5dbe4"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.3/moon-v0.4.3-x86_64-macos.tar.gz"
    sha256 "d885470b4a471e80e85b27166e9d61045e3153e3f5061a0536f19f9e4a5ad3b1"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.3/moon-v0.4.3-aarch64-linux-gnu.tar.gz"
    sha256 "8e8418d3d84314e3225ee56b31cc777887b5938af510071ce2d018b664f5910b"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.3/moon-v0.4.3-x86_64-linux-gnu.tar.gz"
    sha256 "d541b899d8b34aa8cb63f813a5e3e59a5753cdf1426e77f61a23c11418009d4f"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.3/moon-v0.4.3-riscv64-linux-gnu.tar.gz"
    sha256 "3886af94f5f323c86708ee074bfa12a8aa491fbee0eb1de88c62eb3f0b4f3988"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.3/moon-v0.4.3-aarch64-freebsd.tar.gz"
      sha256 "6f83791cad896c01652c8e314472bb2982bf61f3068649b63bd39bad88f6c029"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.3/moon-v0.4.3-x86_64-freebsd.tar.gz"
      sha256 "31b229fef1cb97fb8754fdbd2aef699cb17ced50b073eacbdf5a3a7839a156c0"
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
