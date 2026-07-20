class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.23"
  
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.23/moon-aarch64-macos.tar.gz"
    sha256 "417c0a31f09efc95371d6f903d2b7e66120c65b4886b03d71e7c86618d07da19"
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.23/moon-x86_64-macos.tar.gz"
    sha256 "25044bcf8b89cf131e9cfd382a572cea8c1d415d05bdaeb48cef85a9b0ec40ec"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.23/moon-aarch64-linux.tar.gz"
    sha256 "14726adbebc7de26caa9d4720eea21f53216435846ac657264a73e9fcac7b6ec"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.23/moon-x86_64-linux.tar.gz"
    sha256 "455ad96c89546be277c95e9e6e5f54b6dd854dbfb2d8254a2af5a722d622ee14"
  end

  if OS.linux? && Hardware::CPU.riscv64?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.23/moon-riscv64-linux.tar.gz"
    sha256 "670b32b0e5243daa9709da45a2a6127db3721d8094f7b7df5ac7bf53c3c84e2f"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.23/moon-aarch64-freebsd.tar.gz"
      sha256 "3928275d87b619636dc38fe47a7eaa03854db4a9d0ce390e487e6e54c9e69f70"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.23/moon-x86_64-freebsd.tar.gz"
      sha256 "f9a13e341eaf34cdf9a843c7f0ae6a7c336f1e58f4cf92a20fa18bcdf428c028"
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
