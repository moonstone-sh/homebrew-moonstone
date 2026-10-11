class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.5.11"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.11/moon-v0.5.11-aarch64-macos.tar.gz"
    sha256 "c1a12fb6ae56dcf4d3238b6e613d457e813355ac7af1b8325f9d76a9126dbfd7"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.11/moon-v0.5.11-x86_64-macos.tar.gz"
    sha256 "7aade1c0af823b57e8081aa38178c91375a7a9732e14aa88443204f3ccbcbb25"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.11/moon-v0.5.11-aarch64-linux-gnu.tar.gz"
    sha256 "91ba9d312f8d12ccb996f22ba7b1c9dd60976cc05d7edcf6330fb555cd908a66"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.11/moon-v0.5.11-x86_64-linux-gnu.tar.gz"
    sha256 "176c0fc5aee3ca172c60fcd64ccff1dccac6ac85b6661e3b97136008005b926b"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.11/moon-v0.5.11-riscv64-linux-gnu.tar.gz"
    sha256 "32ebb8944c34c77b8acf50e0673b79233fb7ad1d510833f7f6109a407ddb652d"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.11/moon-v0.5.11-aarch64-freebsd.tar.gz"
      sha256 "da1f2232c859dca817c1467d5cdc7bd882888e2cd9e89eeb498d02f43312b237"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.11/moon-v0.5.11-x86_64-freebsd.tar.gz"
      sha256 "c2fba3ca99836e92366bc267eed3a92fe2524ed295c62ca503fb5f71bd3facd2"
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
