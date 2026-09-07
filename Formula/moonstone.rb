class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.4.10"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.10/moon-v0.4.10-aarch64-macos.tar.gz"
    sha256 "c5f2fc61f7b05ab2761472ac4bb48f08a7060b52b8ca6eb0ef3f7ce0426ca625"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.10/moon-v0.4.10-x86_64-macos.tar.gz"
    sha256 "0dfb09ccb1a9105968bd8d2eb5b061993ee8032f4299905bfe214851e2bd9446"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.10/moon-v0.4.10-aarch64-linux-gnu.tar.gz"
    sha256 "7ae6d09fb0086635c8dfdf46405b543250c2617645d22aa85e5e4979c9580c2f"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.10/moon-v0.4.10-x86_64-linux-gnu.tar.gz"
    sha256 "1b64d700f4b783a1e7d84800f28fd80cd7f9b2163f8710d32a5f5b752dd4ace3"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.10/moon-v0.4.10-riscv64-linux-gnu.tar.gz"
    sha256 "58384f01076e7c4b94dac6bc541bda993cc2c99f1730a3a92d666a5778c0cdfa"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.10/moon-v0.4.10-aarch64-freebsd.tar.gz"
      sha256 "be984a56e3323cfa78fbb1830b5f705ef6ba6a3d86723db9278d026cb407c747"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.10/moon-v0.4.10-x86_64-freebsd.tar.gz"
      sha256 "501ebf6272a0c075d61a47f083fb6eca81deaf518c6e2fad1dd67640c576b714"
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
