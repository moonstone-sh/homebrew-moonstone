class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.36"
  
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.36/moon-aarch64-macos.tar.gz"
    sha256 "288cc07b3545dca709666f34cd8f6b73649e394ef304252c759d1b68b6e13f29"
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.36/moon-x86_64-macos.tar.gz"
    sha256 "1e07afee9dc5a2865deef2a04bb284e01c7be40e25fd6a49bb2bdac81a24e6a9"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.36/moon-aarch64-linux.tar.gz"
    sha256 "9acaad092306b9a2d6b9f410389713d279eb1b2a95bffcbf765f36b7f4fe6eae"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.36/moon-x86_64-linux.tar.gz"
    sha256 "6eee3db100bd8804bb0b4155f8b5ee9704dfd194ba16f69c9e76a32a2c2b3e98"
  end

  if OS.linux? && Hardware::CPU.riscv64?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.36/moon-riscv64-linux.tar.gz"
    sha256 "4e739cae37b735f94828a362c6aaa80dc68bfbc4e8119abe42e2b13c41c1f990"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.36/moon-aarch64-freebsd.tar.gz"
      sha256 "4543e5666e44bbd253175ebf94462845918747df693ab717279c64e9d6ff931d"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.36/moon-x86_64-freebsd.tar.gz"
      sha256 "ac1e61484a3ffa2c04fddae303214ecddf01633f75c59e82067eeb0f68271fb4"
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
