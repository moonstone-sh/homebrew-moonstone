class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.5.6"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.6/moon-v0.5.6-aarch64-macos.tar.gz"
    sha256 "11d396a82a149180726a43f4187679a15a3de5be5ecec0c4ab2da4841fd6c174"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.6/moon-v0.5.6-x86_64-macos.tar.gz"
    sha256 "804bb97ca8fdb8f0d5945f2611317fac76bdff4272c4aab0dd9c341827a73ec7"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.6/moon-v0.5.6-aarch64-linux-gnu.tar.gz"
    sha256 "025d4db0c1292e90ad0dea03ed41d20f8459be88fd22fa56071a83fca87c8344"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.6/moon-v0.5.6-x86_64-linux-gnu.tar.gz"
    sha256 "e45cb944da90ec4cf45bead986b661acb88bc3ff9e84fa71419a2f6bdeb7b6c2"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.6/moon-v0.5.6-riscv64-linux-gnu.tar.gz"
    sha256 "ccbaf30945900262f54caef65f0782ad0c07ee2df858b7ff5a9500fe13c1e941"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.6/moon-v0.5.6-aarch64-freebsd.tar.gz"
      sha256 "8c5729a329d9f730722e0de76fd91f7a3183e8c1f674cc1a86079bb8fcd32453"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.6/moon-v0.5.6-x86_64-freebsd.tar.gz"
      sha256 "ae6561fb7fd7906dcadeb4143b20e6a172aa35d359ee9aae37adfb3e1f3acc4f"
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
