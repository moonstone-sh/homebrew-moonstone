class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.26"
  
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.26/moon-aarch64-macos.tar.gz"
    sha256 "f299572ef3b63501305bfd178cdd2954be98b507aff3b8374da592a91b50f862"
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.26/moon-x86_64-macos.tar.gz"
    sha256 "30694feb3a68f3a728ab0d65a4565c33deb8d53f730f84df637e33ac7e4208a4"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.26/moon-aarch64-linux.tar.gz"
    sha256 "71224db4c884b01199045fb430c580ad3288b1a2706037521d4d17e032ac00d2"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.26/moon-x86_64-linux.tar.gz"
    sha256 "a5bec76c6ecc677bad0a0ca05812ef1cfc1708549afebede74453055dce445b3"
  end

  if OS.linux? && Hardware::CPU.riscv64?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.26/moon-riscv64-linux.tar.gz"
    sha256 "2d415f67ef97ab6d54b690817ad6c973b5485d316fbabb80fdf2a8ec67fa0953"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.26/moon-aarch64-freebsd.tar.gz"
      sha256 "453e72c3bc75a3c0a78e68a29486cc3a007f61635f02c7c54cbcdbb143168e1d"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.26/moon-x86_64-freebsd.tar.gz"
      sha256 "b607ceb8335359bdb3c841c47d24d3d5032f7bd3d5f90157961b78f97e1cb485"
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
