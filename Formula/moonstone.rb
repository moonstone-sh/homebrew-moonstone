class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.33"
  
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.33/moon-aarch64-macos.tar.gz"
    sha256 "d0c4a5031835097ec3d0adef067102a37a561924cec1adf10d0e0f621b57d313"
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.33/moon-x86_64-macos.tar.gz"
    sha256 "4cb11b23cfaecc1903788fb69a4542b49ddc6f5da8f042eb09cf8bc93b01d1ba"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.33/moon-aarch64-linux.tar.gz"
    sha256 "e47ad9d357a21c70bf5b3367e2279ccdca4f40d496603c94e560151fcb608ee2"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.33/moon-x86_64-linux.tar.gz"
    sha256 "bc9aef62d9be62634785c4a7319d31c7c1886150a0d6057e6e8664dedd65d993"
  end

  if OS.linux? && Hardware::CPU.riscv64?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.33/moon-riscv64-linux.tar.gz"
    sha256 "32a0dd2fb078d48703e1f7c4acf0f6dbca033aa6f0c5e4950ab9f7979d63595f"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.33/moon-aarch64-freebsd.tar.gz"
      sha256 "fa2bfda9817a12702c5fe2059feeefc54ab3321e6e757a9144c4a6f3d4c639ec"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.33/moon-x86_64-freebsd.tar.gz"
      sha256 "da5bef29f106fec8db34807080a4f6a08fc6271b63b231138672594a90bf83ba"
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
