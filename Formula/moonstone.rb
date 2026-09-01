class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.4.9"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.9/moon-v0.4.9-aarch64-macos.tar.gz"
    sha256 "c1731e19182aeb8d6e213330afccb36a91d4bd76d41fb1c8ad5f767b4dc23519"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.9/moon-v0.4.9-x86_64-macos.tar.gz"
    sha256 "e9562424ec481d5599f7a3f0ddd2ad89bfde818280408e913366cd0b9c6de7c1"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.9/moon-v0.4.9-aarch64-linux-gnu.tar.gz"
    sha256 "8a971210ef4dbbc51ba3df3eba0eec3cada52a5809d8bf4f1934b3138a283dcd"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.9/moon-v0.4.9-x86_64-linux-gnu.tar.gz"
    sha256 "8b1550de7402c12bb3df80c6bdbc06f8867384c373ca2ac4be6f2fbc95d67ac3"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.9/moon-v0.4.9-riscv64-linux-gnu.tar.gz"
    sha256 "ede4b9934611ee2306cd03b5ac3047be3daa4dc6ef6cebde1322852807d7217b"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.9/moon-v0.4.9-aarch64-freebsd.tar.gz"
      sha256 "780e61fde75405793797edb0f68f4ed5c0bc51efb6a3583d4b54df6afb6fe14d"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.9/moon-v0.4.9-x86_64-freebsd.tar.gz"
      sha256 "4923fe852bc9495f474142564c54fe5061ef37610e298635fc157e5a74871a09"
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
