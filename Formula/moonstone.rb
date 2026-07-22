class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.35"
  
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.35/moon-aarch64-macos.tar.gz"
    sha256 "e021a54febe78e39cb27c287691df993a1ae32793d8372d5e227a8f363e9faea"
  end

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.35/moon-x86_64-macos.tar.gz"
    sha256 "4aaf882d33e60f51838e884f2dad72b925e896a70d447c64bb62dda3018b752e"
  end

  if OS.linux? && Hardware::CPU.arm?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.35/moon-aarch64-linux.tar.gz"
    sha256 "4c092c9980c6a9636607ee1719a8c7ebdb069a05745c312d08804e9186f363a0"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.35/moon-x86_64-linux.tar.gz"
    sha256 "93888d0c373d0143681a9ddb091b31419925572608a5db86d1c0e046bd301602"
  end

  if OS.linux? && Hardware::CPU.riscv64?
    url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.35/moon-riscv64-linux.tar.gz"
    sha256 "96571dcbbb249ffeb2540b20675e518b5c0958cec959f43c6326a4fd6711ee5a"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.35/moon-aarch64-freebsd.tar.gz"
      sha256 "b7f082320c35fae184681e302dea4088cb5fdd08ecfc6dc05e758092967b4406"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.35/moon-x86_64-freebsd.tar.gz"
      sha256 "80a2c7e21c51dc8e4ab994b2ca12d5089b11dfa2d7b87aac92f72d446ca8d1c6"
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
