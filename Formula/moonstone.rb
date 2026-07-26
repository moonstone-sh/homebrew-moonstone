class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.47"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.47/moon-v0.3.47-aarch64-macos.tar.gz"
    sha256 "45ba97e423a7d780d31ff13320047c06a4a51dd50dfec68fb4b690c6d5c44532"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.47/moon-v0.3.47-x86_64-macos.tar.gz"
    sha256 "aedd19bd236c831db0bc3a84f59932e254d5a74d3a4faa9e59bc12667f13f582"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.47/moon-v0.3.47-aarch64-linux-gnu.tar.gz"
    sha256 "c85bd161fa2479347a550be492380d7eeff9a04232da71d30fd317d0bebf8ef1"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.47/moon-v0.3.47-x86_64-linux-gnu.tar.gz"
    sha256 "d822a1564534a14f598c5ba9bb2484bacbc36be2a956ad2d263993de8e263f12"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.47/moon-v0.3.47-riscv64-linux-gnu.tar.gz"
    sha256 "1ae3e17a4df05887d53e9c63f210eff812f84904b746a39b7f6489bb305c58b8"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.47/moon-v0.3.47-aarch64-freebsd.tar.gz"
      sha256 "7887cd7a07c83e0e8ef1831945ed7ddc64813d26338773a043ca3b33f7a7f4e5"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.47/moon-v0.3.47-x86_64-freebsd.tar.gz"
      sha256 "a4ca79825d0088be2cd4db013bfcda8278900fe143474ed20e3097559ca05f6e"
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
