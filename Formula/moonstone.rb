class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.50"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.50/moon-v0.3.50-aarch64-macos.tar.gz"
    sha256 "ef091f8aeb9cc40071606407a095682232eb3fe6c9cc651b97b565f3400c6606"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.50/moon-v0.3.50-x86_64-macos.tar.gz"
    sha256 "9ca82b6cb10f4df37b9a52ea45ae4963d4c80257860e1feec0386ff4f2caf55a"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.50/moon-v0.3.50-aarch64-linux-gnu.tar.gz"
    sha256 "779bdbaabc9eed20a288c9837e6a9d921c8c618e3f68065ad317905bb169113f"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.50/moon-v0.3.50-x86_64-linux-gnu.tar.gz"
    sha256 "4a67dd48c8eb1159421ad7d16f4858728b98e68f48afed1ffa466063e2b9994a"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.50/moon-v0.3.50-riscv64-linux-gnu.tar.gz"
    sha256 "372c09d3130fe55762fa90361635674fd2a85f5044b4cb7f9055fd9e7cc8f6bf"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.50/moon-v0.3.50-aarch64-freebsd.tar.gz"
      sha256 "e3eb4f5c3b1fecaea62c9a1e555fbb42ed292b16e1eb29eee36f46bc8c53a43e"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.50/moon-v0.3.50-x86_64-freebsd.tar.gz"
      sha256 "9634ec0cdfa63d5c1e0f683f829d7c0a3a707e671e806a37a7fcdf7fad3cf84d"
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
