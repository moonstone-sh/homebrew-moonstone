class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.25"
  
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.25/moon-aarch64-macos.tar.gz"
    sha256 "c454047360692d0454506955ad8e7ae42dd2bd2dd67f9e7a730aa0ca5fd0a536"
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.25/moon-x86_64-macos.tar.gz"
    sha256 "ce211a3dfd0b03babeed80eb66d0e9d6a0af372919e037c8a1745f6bacafcb62"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.25/moon-aarch64-linux.tar.gz"
    sha256 "906bc20f1af9ce095adcb0cafece1ffdc4886826bc867b1569acb936d1f6653a"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.25/moon-x86_64-linux.tar.gz"
    sha256 "68ffcbc080358b9538225bc8c52889e426383ba6d66dee8700d822e7dbb3ace4"
  end

  if OS.linux? && Hardware::CPU.riscv64?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.25/moon-riscv64-linux.tar.gz"
    sha256 "820e48a989da0b4317237cb21145bed073e202e466e4354915081a73bd000e18"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.25/moon-aarch64-freebsd.tar.gz"
      sha256 "4827db74b894e3e2ba3c93b35a5a34b1d84d54c2472b8ba677162789a3a803f0"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.25/moon-x86_64-freebsd.tar.gz"
      sha256 "7f32070f6bec2519a6b07a6157a86396d63f65b7c0aed5e866f3fb39b6563b4f"
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
