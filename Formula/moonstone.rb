class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.4.7"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.7/moon-v0.4.7-aarch64-macos.tar.gz"
    sha256 "e69ddcda56bf558a533834c6edc0571aab9cfbb40a2dd5dcd5ef189fbfea45d6"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.7/moon-v0.4.7-x86_64-macos.tar.gz"
    sha256 "f8ffad55f7f7f8451951fae54cd9c9f74fd4bd765002794958fe7b3fcb9155e4"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.7/moon-v0.4.7-aarch64-linux-gnu.tar.gz"
    sha256 "fca7a2b2176798456b022e984dd9c476b4171ecf4076c58a6f865a3e9983e15e"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.7/moon-v0.4.7-x86_64-linux-gnu.tar.gz"
    sha256 "cb7a21dd21336bfb9966021f6d4426200a785e7d3e2cfb7b8eddd8262d3419af"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.7/moon-v0.4.7-riscv64-linux-gnu.tar.gz"
    sha256 "ba19e7cc1681e6b272c0c4c18ac6b6463909aa679bfda28e75fde00b14260574"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.7/moon-v0.4.7-aarch64-freebsd.tar.gz"
      sha256 "24e80b56e97067f806a8926e644b8b3fb3073e2d34c82e4abc42b23e80ed2af6"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.7/moon-v0.4.7-x86_64-freebsd.tar.gz"
      sha256 "8c82600beb750b070071a78f34e2fca6a0d2b15898e26e9f7a0af031b7d576d1"
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
