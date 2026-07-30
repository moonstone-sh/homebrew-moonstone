class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.51"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.51/moon-v0.3.51-aarch64-macos.tar.gz"
    sha256 "a930739263f8329de7740d7b201bfd807257786b48c77a7130847faf80b103dc"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.51/moon-v0.3.51-x86_64-macos.tar.gz"
    sha256 "7b31adc844b120946c62478311ffd5af3ef08feec734b6244dea2fff4ddb61b0"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.51/moon-v0.3.51-aarch64-linux-gnu.tar.gz"
    sha256 "2343450cb9dee77bb377f9743fa125dc997ebf454d7a4de04b20e1d20b0c932b"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.51/moon-v0.3.51-x86_64-linux-gnu.tar.gz"
    sha256 "2ff963da7d2ff1633a14bfbba0dac65c020df86dda348b21729492abefafaadc"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.51/moon-v0.3.51-riscv64-linux-gnu.tar.gz"
    sha256 "13a3cc270a23fbf1d7a1c8080802b6dbb82df44a0b7505a85066d8ce3111d5f1"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.51/moon-v0.3.51-aarch64-freebsd.tar.gz"
      sha256 "d88c0e53db875dbd3c4612c3fbd0de247db9fe6f3f81faac7d5eaed316a088a9"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.51/moon-v0.3.51-x86_64-freebsd.tar.gz"
      sha256 "1dbc376185a19736aa0c76a204cc0ebca44d829cb3dfafbf60c4e1b93590fd30"
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
