class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.4.13"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.13/moon-v0.4.13-aarch64-macos.tar.gz"
    sha256 "d2b1f467c71403e4aebbaf169bb89f0bb29bc23777cc2f5de7ccf34b855f953b"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.13/moon-v0.4.13-x86_64-macos.tar.gz"
    sha256 "8868d7efdbafe46d57525c5c017997a9b1b184eb5b9396a63e7fd59d3e26001c"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.13/moon-v0.4.13-aarch64-linux-gnu.tar.gz"
    sha256 "1821695d750f3e9a1d974effc3a29e6163f68bde57f7afddd626392872adfa06"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.13/moon-v0.4.13-x86_64-linux-gnu.tar.gz"
    sha256 "291b49b758592200c49ddc2db5b9b070ca37a22b7ca2fc39cc962c388b4526a9"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.13/moon-v0.4.13-riscv64-linux-gnu.tar.gz"
    sha256 "1654521560da3020f2fedf9496662e834194b86f3bf7bbc40beff7c205f38011"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.13/moon-v0.4.13-aarch64-freebsd.tar.gz"
      sha256 "fb61c4c18608a205966f844b56c8767dee031f465d5a2a0a290dcfc9f101fade"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.13/moon-v0.4.13-x86_64-freebsd.tar.gz"
      sha256 "7a724a5a9a921fd392a5838febb1bd934dfb36909a9eaca5c7a19623340a634f"
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
