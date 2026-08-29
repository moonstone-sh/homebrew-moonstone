class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.4.6"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.6/moon-v0.4.6-aarch64-macos.tar.gz"
    sha256 "8d260f4dc3a29733cee47038ed92e4285a6d98c99f467da38b314f81c1d2ded5"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.6/moon-v0.4.6-x86_64-macos.tar.gz"
    sha256 "2c7441849889a9534d9496756314045671556385aa4073d977f7f6791a4c0e18"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.6/moon-v0.4.6-aarch64-linux-gnu.tar.gz"
    sha256 "01833d1cd1c67792f5d938e4972d62faeb15960358027d08b7def2f1796ff7e3"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.6/moon-v0.4.6-x86_64-linux-gnu.tar.gz"
    sha256 "72296274c37dde5b74a9ed295f924bfac0fc185177e89b884d0ce5cc24b7f703"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.6/moon-v0.4.6-riscv64-linux-gnu.tar.gz"
    sha256 "4470d4b78d15dbc0aea2445f53d6a34af6deb4a214d120863f0c2c8ff6a061b7"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.6/moon-v0.4.6-aarch64-freebsd.tar.gz"
      sha256 "3b87b3343f3e440a05a138a89a0c70a9bdcc5986250eea1f221e7d1b4e5fb71d"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.6/moon-v0.4.6-x86_64-freebsd.tar.gz"
      sha256 "60fa4e8012ba687b168965e6d2657cccf5f43b214f7e11d87f62f8ba240f544c"
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
