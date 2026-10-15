class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.6.0"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.6.0/moon-v0.6.0-aarch64-macos.tar.gz"
    sha256 "20864b0ef28cb17af0acf2fcfa4765ad68ed4ce07dea3c53258e32c3b5604387"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.6.0/moon-v0.6.0-x86_64-macos.tar.gz"
    sha256 "622e1b4274dffe66e8bacb8f08f91915620c007e99c23b5255e34781d143b9dc"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.6.0/moon-v0.6.0-aarch64-linux-gnu.tar.gz"
    sha256 "2bb2dcbf784b6f3bbf2d8f818bbc41d3aa4475b5eafe71365465ef434f0d38bf"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.6.0/moon-v0.6.0-x86_64-linux-gnu.tar.gz"
    sha256 "80939da89f2ff4b144c86a0044e9973358446ebb2b30cc2d18adbcc2d3f16d2d"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.6.0/moon-v0.6.0-riscv64-linux-gnu.tar.gz"
    sha256 "6c8602f07860321a2712dd77370740dc19d8c2baa51c17dbe3c61ba0d7810e33"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.6.0/moon-v0.6.0-aarch64-freebsd.tar.gz"
      sha256 "ba4aec1be2f5d61c91c16f8f0bdc960f17678393fd6e3c4b5de367887363e472"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.6.0/moon-v0.6.0-x86_64-freebsd.tar.gz"
      sha256 "1fefdeefdafddafd2f87a445084cbd2608827aca2e26077c38de6b35fcdc5fd1"
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
