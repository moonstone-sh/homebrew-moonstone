class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.37"
  
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.37/moon-aarch64-macos.tar.gz"
    sha256 "6869dea6c97b919cce1885590f56ab9a4092e883f68260619b31163b5d832c2e"
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.37/moon-x86_64-macos.tar.gz"
    sha256 "775835b40f5422f635c057617cbba51d085280d33bb3b1a496e7804ae104db5d"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.37/moon-aarch64-linux.tar.gz"
    sha256 "c51e7a19804eed0be640aed6806745b006c8d9730c35743ba3af0ac139372f61"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.37/moon-x86_64-linux.tar.gz"
    sha256 "c3866dd5f859a6142cbbb96536163aef5a25be3bacf73cde2007692aa8ee403a"
  end

  if OS.linux? && Hardware::CPU.riscv64?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.37/moon-riscv64-linux.tar.gz"
    sha256 "ea0150fe15461bf1a6be796868936298d1ee277054ac37eaf2d540b75c720703"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.37/moon-aarch64-freebsd.tar.gz"
      sha256 "db668d687ac12ddf9997e4e2b3ae26c8a9dfd862dd29f7ac2514e69974f48543"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.37/moon-x86_64-freebsd.tar.gz"
      sha256 "031c458f15f77a0070d0aad19b3d380b1cdbe7a5f2814735ec4b86cb37d2506a"
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
