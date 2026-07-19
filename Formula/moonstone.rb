class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.20"
  
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.20/moon-aarch64-macos.tar.gz"
    sha256 "f3b0ba14e32cddf8ecbddfddf3fff8be773cfa23a81ce10d4530bff4a91d2f05"
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.20/moon-x86_64-macos.tar.gz"
    sha256 "586bb208ef10ff3d66b47bf499940033ddb43deda2e34cbbb7c1bad8beada113"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.20/moon-aarch64-linux.tar.gz"
    sha256 "2ebd21dbc68921b07da273e90d73ea1cf73f313d67fc66a3a6a2ee90147175d6"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.20/moon-x86_64-linux.tar.gz"
    sha256 "eb18fed67f5f41d51ce2bf4afe2be8a7bce33d38c786eb041447f6f4f032a5f8"
  end

  if OS.linux? && Hardware::CPU.riscv64?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.20/moon-riscv64-linux.tar.gz"
    sha256 "3a378ced864ac8c77e950ac14e2e11ecd9aaa1b272664a4afdf2cb7e5bc9ec57"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.20/moon-aarch64-freebsd.tar.gz"
      sha256 "2dae4bc8adc752d40e7bf9c965046120079cff0a0ce6d51f664520c60cecf892"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.20/moon-x86_64-freebsd.tar.gz"
      sha256 "a6efac832bcd0dbb421ecd0677d2fe9cf011c0348d93d9400252c62dfbdad76a"
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
