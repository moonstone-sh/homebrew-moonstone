class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.4.18"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.18/moon-v0.4.18-aarch64-macos.tar.gz"
    sha256 "d3152c81babe4b8e66c01833eace45a3915e5ed25fe9b9a6b3fc7f381f028a41"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.18/moon-v0.4.18-x86_64-macos.tar.gz"
    sha256 "1700c6f37ab0933cb1b5e29ce719cffdfcdfacc459af9aaa96384084a67a0244"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.18/moon-v0.4.18-aarch64-linux-gnu.tar.gz"
    sha256 "7d842c45c2b0ec28647dccee489d941e2f7d06ff08d865e8343e6b42e10b010d"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.18/moon-v0.4.18-x86_64-linux-gnu.tar.gz"
    sha256 "8190012a0dddd1359a1f464f69385c9e584171703c53cb44042d109ff086f133"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.18/moon-v0.4.18-riscv64-linux-gnu.tar.gz"
    sha256 "147b887a5599391f1b35755dd49e2a19ea06502397200488405501ca952b4e12"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.18/moon-v0.4.18-aarch64-freebsd.tar.gz"
      sha256 "09ea7ee5b779a865d775030ceb1fe2d3709eb712652023091f144caf247df5ee"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.18/moon-v0.4.18-x86_64-freebsd.tar.gz"
      sha256 "9f3b8620192559a2ab799cef1c967333aad4faafcd10c51e1b317eba33f6ed06"
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
