class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.5.8"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.8/moon-v0.5.8-aarch64-macos.tar.gz"
    sha256 "e5f3c386bf4cb4585aa0d8c8fa022f7b88b772bf6cb30de1e79692799bfaa403"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.8/moon-v0.5.8-x86_64-macos.tar.gz"
    sha256 "0f9e9507decac9e20f60f13be86c5a39a0cde07e5cad2742077c017d61e632a6"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.8/moon-v0.5.8-aarch64-linux-gnu.tar.gz"
    sha256 "eeb2087a5574577ce774bad5e2b42f429eda7447ce499ad7826950eea81d95f0"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.8/moon-v0.5.8-x86_64-linux-gnu.tar.gz"
    sha256 "ac12f778e47b781cffb69ad977580a3d37d0f9c8250cec533819ca277ec969eb"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.8/moon-v0.5.8-riscv64-linux-gnu.tar.gz"
    sha256 "725f7db74c80f5f146cb428531fcb656a3cb58a4e1ad084f3acb0c03c5719529"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.8/moon-v0.5.8-aarch64-freebsd.tar.gz"
      sha256 "291eccb69c1958741ec4e092bb20b13f50df6f716de88341aec3166a9fb4e078"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.8/moon-v0.5.8-x86_64-freebsd.tar.gz"
      sha256 "9ea8197ca3f673088d2825fbb86c7ce643c19c677d7eb5f76cf9c88763641d67"
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
