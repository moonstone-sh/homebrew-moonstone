class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.5.10"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.10/moon-v0.5.10-aarch64-macos.tar.gz"
    sha256 "3d8ffd9d407164268d834519cdb6feb20e14551f49713d14e03d1f03144283f1"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.10/moon-v0.5.10-x86_64-macos.tar.gz"
    sha256 "4b5d0636ff5f6bd04238d04335a01fd7c1f2a5e9425995c0b0aba2a817891553"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.10/moon-v0.5.10-aarch64-linux-gnu.tar.gz"
    sha256 "973b01adb29220230ae1b33c8a9de3ef6ce304b3dd93feea399312c36670d53b"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.10/moon-v0.5.10-x86_64-linux-gnu.tar.gz"
    sha256 "8d5d94e515f7b76663eafcbefe26bf5087745258b6d4fb79026f0bf4879b0cbf"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.10/moon-v0.5.10-riscv64-linux-gnu.tar.gz"
    sha256 "19634d9c8858f6b65e348734f070aab69d9b07c632c746af02a0f3fe3524725c"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.10/moon-v0.5.10-aarch64-freebsd.tar.gz"
      sha256 "6783bdd5a43978a561f26e7cff115d0d1557a5c937896bd1c9b5ac15ff738f8a"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.10/moon-v0.5.10-x86_64-freebsd.tar.gz"
      sha256 "e5b969ead453532fd49cda83bdec2624cc38bc30c9587c167cb867a92949e6e8"
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
