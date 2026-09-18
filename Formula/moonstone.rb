class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.4.17"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.17/moon-v0.4.17-aarch64-macos.tar.gz"
    sha256 "e28ee991f190634d95c53195ca0eff5c18baec5b158537821c0aa3c5a1e54dcc"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.17/moon-v0.4.17-x86_64-macos.tar.gz"
    sha256 "db977e6f4a422c307df0cd1ee0832f3599e2aff63a6c1f8e025bd450648d1043"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.17/moon-v0.4.17-aarch64-linux-gnu.tar.gz"
    sha256 "afd56b9ecab35031b35111b3062711be88bf3db945cc9131d76e712abbda8161"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.17/moon-v0.4.17-x86_64-linux-gnu.tar.gz"
    sha256 "8f6509afb1a6857f3adcffcce1cb67b2ff07babb4b229ab7d34824f98a17a80c"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.17/moon-v0.4.17-riscv64-linux-gnu.tar.gz"
    sha256 "2e152966a5f4ef72005e564c17558f088c2df08922827af691c3062214e45e08"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.17/moon-v0.4.17-aarch64-freebsd.tar.gz"
      sha256 "39007810f4df6a6f4fde4c6f54239d3b3babff7d103da33b2a69790f0bfe14c6"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.17/moon-v0.4.17-x86_64-freebsd.tar.gz"
      sha256 "f5a5f1f9c2ef5ecc2c3982d9874de79adb49f7cee8739a19c65de2d389c4d313"
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
