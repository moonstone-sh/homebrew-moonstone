class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.16"
  
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.16/moon-aarch64-macos.tar.gz"
    sha256 "936ebfbf7358fb49a23d18ae5c0bdfc66e94e873caf7962f0e1946649b8aa46d"
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.16/moon-x86_64-macos.tar.gz"
    sha256 "6f800c1e9c35553cc604f39ee355a7bf9244c43befb2ad27e9096847da8bc2ce"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.16/moon-aarch64-linux.tar.gz"
    sha256 "f544c03e4ceb6c0d05013f193a6d9efec6b03480b1ea8ca52cd4d374a3718535"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.16/moon-x86_64-linux.tar.gz"
    sha256 "0f7a03eefde2bc57d338530758ec70a1a333d59effb847121c5e08b055554647"
  end

  if OS.linux? && Hardware::CPU.riscv64?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.16/moon-riscv64-linux.tar.gz"
    sha256 "1d6a07addb15f3971e0fc157178249ed8d1ee8a909de6fd2ebe07c8bcf64c863"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.16/moon-aarch64-freebsd.tar.gz"
      sha256 "9fed34c961111df0af0fbe84839aaa3d7b1283ae412146fa31a384f1e59c7b4e"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.16/moon-x86_64-freebsd.tar.gz"
      sha256 "4e8c08d06f531b1c75b18801c49bc0a692b4adac555d928c2ca3f2cb5ec6a116"
    end
  end

  def install
    bin.install "moon"
  end

  test do
    system "#{bin}/moon", "version"
  end
end
