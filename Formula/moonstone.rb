class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.31"
  
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.31/moon-aarch64-macos.tar.gz"
    sha256 "4c27c8f26394d805ddc875871c940554afdb0cc2ad000887a654c17a3dc079f5"
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.31/moon-x86_64-macos.tar.gz"
    sha256 "f88e8575cbc192cdeac374484a82737f1cd0e2de158aa8ffe2a6310f5518d354"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.31/moon-aarch64-linux.tar.gz"
    sha256 "3e18a08089e3e009aba89117c6c1748276c9f11ea0e37ebbbbb9b8772fbb24cd"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.31/moon-x86_64-linux.tar.gz"
    sha256 "eefe4ba2c05265af5594b6607f79e16b2446196d9459150024b7a0d6235bb389"
  end

  if OS.linux? && Hardware::CPU.riscv64?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.31/moon-riscv64-linux.tar.gz"
    sha256 "e1fab288f348b2e96c865a5f8ccbd3dfc1869a792eb743dafdb6267efc4828a7"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.31/moon-aarch64-freebsd.tar.gz"
      sha256 "fdac309518051132e8f076086a7fdcba34dc8c8b1eb8a8dc307b59ca1cc6247f"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.31/moon-x86_64-freebsd.tar.gz"
      sha256 "987f187a5c0a9e297ca3d0c09c093d32da0cf5953359d9a1b15a04fa894055df"
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
