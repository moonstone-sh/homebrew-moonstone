class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.38"
  
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.38/moon-aarch64-macos.tar.gz"
    sha256 "41b688d2b2c9ad91b3d3d14b9b0b7234816b6c5df59879ece2b48f178a306ba9"
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.38/moon-x86_64-macos.tar.gz"
    sha256 "07f686cf678cae83047ab2fd51ea784d07513ca11abdc30689956fb3c36e9c33"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.38/moon-aarch64-linux.tar.gz"
    sha256 "9329e3597d27152bf500bdcf0bf5ff3e3e05419d4b27d66dbd545b6ce317e42d"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.38/moon-x86_64-linux.tar.gz"
    sha256 "aa09e38ef61c616d34094d838b64a0f1950f6b2920d76c6c2623b12d7d76b005"
  end

  if OS.linux? && Hardware::CPU.riscv64?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.38/moon-riscv64-linux.tar.gz"
    sha256 "a6c5ac334bf2542efc05f8336449be9452d716c912d7a09f058188f5337156ff"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.38/moon-aarch64-freebsd.tar.gz"
      sha256 "92322509180c5773197f049053698211e14b2c872d0b78f0be4696736bf4d042"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.38/moon-x86_64-freebsd.tar.gz"
      sha256 "649e1fb3582decfd23ae8b9f510d5ae1330b318081c97c179ff752299865498c"
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
