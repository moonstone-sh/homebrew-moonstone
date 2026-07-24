class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.41"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.41/moon-v0.3.41-aarch64-macos.tar.gz"
    sha256 "0e89452e987609162700d05212185996e8744fab4a6cfd9e37bd0cafe2df8545"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.41/moon-v0.3.41-x86_64-macos.tar.gz"
    sha256 "decc16076b35ef037609d10217ae244ed8dcce57f11490eae49ccd6cbc3cd2fb"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.41/moon-v0.3.41-aarch64-linux-gnu.tar.gz"
    sha256 "d4fbc6cb1cd450a65cfd7636494012c22981eecca0ba4b6fbfc6b9be238310a3"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.41/moon-v0.3.41-x86_64-linux-gnu.tar.gz"
    sha256 "e9cdb95c2fa7d627f76b16af7dab30d4e13eb5c264e3b81c05bc1222ae203614"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.41/moon-v0.3.41-riscv64-linux-gnu.tar.gz"
    sha256 "8b265187a4c025e95289d26d1a6bfe103fd8c6c88299452570bd576cd822f9cc"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.41/moon-v0.3.41-aarch64-freebsd.tar.gz"
      sha256 "406a01f2736adbc745ebbe5f8e48744d653ecfb0a2c4b8b415168819a2addb46"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.41/moon-v0.3.41-x86_64-freebsd.tar.gz"
      sha256 "b86fba049da6484b3ca027de8900aa34231d4cef989203f6c837603f409c447a"
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
