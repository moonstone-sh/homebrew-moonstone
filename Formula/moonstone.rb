class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.34"
  
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.34/moon-aarch64-macos.tar.gz"
    sha256 "375f70077cd73c27909174526cb0099523296538790a7ef362eed15b29360fda"
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.34/moon-x86_64-macos.tar.gz"
    sha256 "dadb025df494c4aae7c47511b033428091a351a363e6227190f6eb8acf6bc896"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.34/moon-aarch64-linux.tar.gz"
    sha256 "ef33a164e3e3f2e3cb520770783ed4d53a0d7631d229a413b93af9f9535c52a3"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.34/moon-x86_64-linux.tar.gz"
    sha256 "761238a2c63f10db552d7042fc17101bf0ccef3d52e36aa278aacedbcc0157cc"
  end

  if OS.linux? && Hardware::CPU.riscv64?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.34/moon-riscv64-linux.tar.gz"
    sha256 "31a229fd0dc3b8b9b11d779c071b3a464e7826005e9c8e01c17293e3c819bf28"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.34/moon-aarch64-freebsd.tar.gz"
      sha256 "3eab07e357a23c4a25206465edbe51129758fd9afcba119156e483ab5b2018d0"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.34/moon-x86_64-freebsd.tar.gz"
      sha256 "5ef916cb85a36c01435cead4cfe0bc946a7baace59666c9c29513beac2e00109"
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
