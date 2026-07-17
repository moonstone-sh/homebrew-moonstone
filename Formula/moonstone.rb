class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.18"
  
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.18/moon-aarch64-macos.tar.gz"
    sha256 "bffd28e811678cdef5062fe911da384163f301a5ce5f5d80d4c66fc3fdc4b087"
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.18/moon-x86_64-macos.tar.gz"
    sha256 "204818a5041d72b234e0f1d51c22349245790bacb5c005fe2697a141cf36e6bb"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.18/moon-aarch64-linux.tar.gz"
    sha256 "7d8dc86f355a68ab3154c4e1485f002dcf47a25e852621bb06e04d1abfe3a136"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.18/moon-x86_64-linux.tar.gz"
    sha256 "7af04eb7e6042c9b5f8fea6b7ee7cf4ef8b30e7a47d01cf144bdae2ec95b78a8"
  end

  if OS.linux? && Hardware::CPU.riscv64?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.18/moon-riscv64-linux.tar.gz"
    sha256 "cdf6cf89c0667e139ad53679af651e829499ab432b220c14d11a4a5bcef71acd"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.18/moon-aarch64-freebsd.tar.gz"
      sha256 "7237b63472c4e70eefb68cb7c1d731ae847b8b54493a64acdde216de2be888a2"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.18/moon-x86_64-freebsd.tar.gz"
      sha256 "ea17ec91889976b7d119cc50658eaa503a4de01ed0f51e39eff9a9283527638b"
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
