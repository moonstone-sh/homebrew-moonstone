class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.27"
  
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.27/moon-aarch64-macos.tar.gz"
    sha256 "b60b0284b7857a85f22acae2b7f263e4c39412dc9e4efb281fab2e6508818ab0"
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.27/moon-x86_64-macos.tar.gz"
    sha256 "55d7e9ca8b0307c920e1c1dbc54131e878a0e5be425364b052d6f98b42d021e2"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.27/moon-aarch64-linux.tar.gz"
    sha256 "aca3f3e198a0b7f882a4560385ba8bec24b330488afa2f68e40fa4f61562146c"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.27/moon-x86_64-linux.tar.gz"
    sha256 "8c9ef0b8cfaf3065cb641890291130e68bc6eaa4f126d58009574c41cecc8e5f"
  end

  if OS.linux? && Hardware::CPU.riscv64?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.27/moon-riscv64-linux.tar.gz"
    sha256 "91d8e3485210188e9ed4afb15538d4c3cd319594115462f7be92a827c95e224b"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.27/moon-aarch64-freebsd.tar.gz"
      sha256 "48b969470903b99a4baa063c2879b90b015341f16f76355cec7ae1169879e5ac"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.27/moon-x86_64-freebsd.tar.gz"
      sha256 "206c4bdbd305ffb675ee13ec66711b4e74dceb967dd98fdf411781cf138f4d42"
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
