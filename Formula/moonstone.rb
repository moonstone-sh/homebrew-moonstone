class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.46"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.46/moon-v0.3.46-aarch64-macos.tar.gz"
    sha256 "936a029c612dae53c63134340e503f9adae69ee26568fca8ce98e878039f5e58"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.46/moon-v0.3.46-x86_64-macos.tar.gz"
    sha256 "e0d8df6042933b4ad8e3bfc659d8607c4f1a42ba53056e729828f0c7dabfb34a"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.46/moon-v0.3.46-aarch64-linux-gnu.tar.gz"
    sha256 "e1cdac843e05b1e41aa4eee4db369c38abb2527d9597bf51f62d9c4252ec1937"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.46/moon-v0.3.46-x86_64-linux-gnu.tar.gz"
    sha256 "8134aaabe994a1bb628e3875f1fe6606eeec97b062fef751541cfbd29fbc5d0c"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.46/moon-v0.3.46-riscv64-linux-gnu.tar.gz"
    sha256 "dfe834913242bd32257ff417f056c0df5cb6833031a0b0c5eaae2532f4dcebc2"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.46/moon-v0.3.46-aarch64-freebsd.tar.gz"
      sha256 "e6c2df95f1b1c919fa81ddc5db061cb82324ff8135e012b03f0269c41a7e20b4"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.46/moon-v0.3.46-x86_64-freebsd.tar.gz"
      sha256 "0ef778c2899013cdbb1dedf12d5cbec0102f7e9ccbb0fb1a1cf3d92ecbf4c377"
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
