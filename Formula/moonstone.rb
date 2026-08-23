class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.4.1"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.1/moon-v0.4.1-aarch64-macos.tar.gz"
    sha256 "69fa59aeac81fcfefa0b38a3c247d35a3ff111b24ae36cb89d3cf41bf4f426e1"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.1/moon-v0.4.1-x86_64-macos.tar.gz"
    sha256 "cbd092ac2bd31d17047e7ee85366eec8f013100940febc2c314367127e163070"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.1/moon-v0.4.1-aarch64-linux-gnu.tar.gz"
    sha256 "34502cd9850295cf7e098166e3f1c740cdcbaace6f8ad51d8bbe18c96480bb94"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.1/moon-v0.4.1-x86_64-linux-gnu.tar.gz"
    sha256 "31146c80c4c031ed233d50c3e2eefd108efd892c60cd0185df857c6aa7ef01ae"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.1/moon-v0.4.1-riscv64-linux-gnu.tar.gz"
    sha256 "abdb7a142384ac7c31f5a63455cc023ecf5bf8c8326eaeb0b7835a2ef3319d01"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.1/moon-v0.4.1-aarch64-freebsd.tar.gz"
      sha256 "7bcdc996d19b1be5640b27d3f80243f1c754dded03eef8ccdffb5a31980d2217"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.1/moon-v0.4.1-x86_64-freebsd.tar.gz"
      sha256 "18e3acc48a169ca2e645732142dfc201a1abd72bcf9f073f2b6a9bb0feeef3fd"
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
