class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.4.8"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.8/moon-v0.4.8-aarch64-macos.tar.gz"
    sha256 "cfff75f2eb368414e9c73674b1dc8b71489f302c5113bc670fb4cf85dd2f6846"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.8/moon-v0.4.8-x86_64-macos.tar.gz"
    sha256 "dd7357866bd77cc9b3c3f6c2d4293b32bc6ffbb50f85bdc3b07e3b6d72d56705"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.8/moon-v0.4.8-aarch64-linux-gnu.tar.gz"
    sha256 "2f4ded6175c142d9eb44d794b80a6cedaabc9c3ee6470c11b5ec774bfa6a1c4a"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.8/moon-v0.4.8-x86_64-linux-gnu.tar.gz"
    sha256 "8fc6216a51beb9a991260d7e501971536f8142ab9ee9c51627ef62c91c161a8a"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.8/moon-v0.4.8-riscv64-linux-gnu.tar.gz"
    sha256 "24d308f1cbf9cad89710151c39f214cdc945962eccda899283efc88c3ecb7269"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.8/moon-v0.4.8-aarch64-freebsd.tar.gz"
      sha256 "f0611d97c7ea32ac9f3cf0250e5b59e31d9dde92be09b8db119445dc31876088"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.8/moon-v0.4.8-x86_64-freebsd.tar.gz"
      sha256 "52e6ee8419e04ea4da84e5227c64706f0abc7d958928768d036d3e3a7ac84d74"
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
