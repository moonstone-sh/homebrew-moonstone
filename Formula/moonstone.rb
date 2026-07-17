class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.17"
  
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.17/moon-aarch64-macos.tar.gz"
    sha256 "fb2937555ae128e91d8ade4f8286e2c80582145822809791c8a47cd1425300bb"
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.17/moon-x86_64-macos.tar.gz"
    sha256 "9400dfce7fb59e130369e7d2c99df0d1226ffe5a01d23efea4f5c5554e784ea8"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.17/moon-aarch64-linux.tar.gz"
    sha256 "2104fff33712ed649a53c0ee6c7e28ca3aaae1da61832957a2e817eab97d93c3"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.17/moon-x86_64-linux.tar.gz"
    sha256 "5635e130d38b9a7b68c69777134dc701ede6d89c44801f725f6324c291ec5dd1"
  end

  if OS.linux? && Hardware::CPU.riscv64?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.17/moon-riscv64-linux.tar.gz"
    sha256 "8ba67774b86692f231b0340349556ace6805dbe294d2cd61ef256de276c40e12"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.17/moon-aarch64-freebsd.tar.gz"
      sha256 "9e11d87f09056f052926cf91c0cd71c179a5cae277133edf9c6ea28d5375ec02"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.17/moon-x86_64-freebsd.tar.gz"
      sha256 "747b1b7153c4dcdbfb210d69d00602b67f24425d677f497de46f0e8d5feaf320"
    end
  end

  def install
    bin.install "moon"
  end

  test do
    system "#{bin}/moon", "version"
  end
end
