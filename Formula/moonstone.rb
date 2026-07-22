class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.29"
  
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.29/moon-aarch64-macos.tar.gz"
    sha256 "b64a6267f6f0f241a99b990058e82900e9ed1e0eedb284534c33e7bab1e6969e"
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.29/moon-x86_64-macos.tar.gz"
    sha256 "46258bc201280fb0c93d69bb7e43efbc13d288eeef5eb5fd1a71c6e2f9b134ac"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.29/moon-aarch64-linux.tar.gz"
    sha256 "8019bdc2c49c83ba0d8ce6cc3be2a65ddcc173c524ce27cd6b2fbfcc966380c2"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.29/moon-x86_64-linux.tar.gz"
    sha256 "888ab8418f61dfded0dead8c9e7fb2a949abed41ba16f5d11d5d7153c8c5d8f3"
  end

  if OS.linux? && Hardware::CPU.riscv64?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.29/moon-riscv64-linux.tar.gz"
    sha256 "ea7d0f4f5026b6d895a8903e6f3ed5fe396eeb1077501619b69618eba0617fc5"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.29/moon-aarch64-freebsd.tar.gz"
      sha256 "f9001e2b5cfc956d233e19e80310b38f7b12af512e5a954831332eb3c88a9961"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.29/moon-x86_64-freebsd.tar.gz"
      sha256 "1ee08e17d8b6b055855fb71b13a2d890daaddd6aec0d56f420f9e517733917f1"
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
