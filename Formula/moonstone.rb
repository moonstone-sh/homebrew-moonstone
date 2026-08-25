class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.4.2"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.2/moon-v0.4.2-aarch64-macos.tar.gz"
    sha256 "d5e98061952173846e3e1e763ee77ec88c5b8ae168947f904f12512c0e68639d"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.2/moon-v0.4.2-x86_64-macos.tar.gz"
    sha256 "eb9faa03afac7f6c02ad186bc36dda44a9ced9c28dc6237d2c54c8e50541ad72"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.2/moon-v0.4.2-aarch64-linux-gnu.tar.gz"
    sha256 "0518111a62f7ac59c9b97d84655e6ccbda126a25dd7ddcf1932f5fd6364a495f"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.2/moon-v0.4.2-x86_64-linux-gnu.tar.gz"
    sha256 "e652b3190b6ea463f15f70be41cff80e90f8ca16da7a087b8ac3e8fb126a84b2"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.2/moon-v0.4.2-riscv64-linux-gnu.tar.gz"
    sha256 "10696a82732a120b0cdedc2d2f2222c15625670493aa2581def1186421c90249"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.2/moon-v0.4.2-aarch64-freebsd.tar.gz"
      sha256 "b751764d3e246e44610d2aa9df0999f4c04232fabaa048b7d7534d554aa3defd"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.2/moon-v0.4.2-x86_64-freebsd.tar.gz"
      sha256 "a1611cdaaca95026c1e7a1cfb4a744730c02a9adbbdb01b032dd08e40e2e0d07"
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
