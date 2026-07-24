class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.42"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.42/moon-v0.3.42-aarch64-macos.tar.gz"
    sha256 "b46b757b13ff4634622ce87f7653bf180345bf710ba1fc6ce695cfd01ae5ccf3"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.42/moon-v0.3.42-x86_64-macos.tar.gz"
    sha256 "c18ee67f17c5e093ddb16995aed26a10399948321114be0d3b958d4f250120e0"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.42/moon-v0.3.42-aarch64-linux-gnu.tar.gz"
    sha256 "2993cca798c7efd8aa81c15a44f60d03777b364882cbcec8124fa2cbcb89c21b"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.42/moon-v0.3.42-x86_64-linux-gnu.tar.gz"
    sha256 "0712b549d3a304a6fb57a864ed1d4bfa8ea3fa7780d69f6bed5fda4d36a9eee1"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.42/moon-v0.3.42-riscv64-linux-gnu.tar.gz"
    sha256 "b6e144ce7fe716fb4dd69fa84259abc6ec7f0e8a39ae562338704a4847d8198c"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.42/moon-v0.3.42-aarch64-freebsd.tar.gz"
      sha256 "5047adb765315652cdb16d8e5e20ed41b595cd5ce997114cfe554ed890c1a855"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.42/moon-v0.3.42-x86_64-freebsd.tar.gz"
      sha256 "a534fe3f4e98070207a96d179e7a182cd88361f6d6ab0951fd994cf602f3b2c7"
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
