class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.4.16"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.16/moon-v0.4.16-aarch64-macos.tar.gz"
    sha256 "0de9752fcc957ab3340b758aa9ceeec1082167710e63bf1392204df1a0007bac"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.16/moon-v0.4.16-x86_64-macos.tar.gz"
    sha256 "2c012c9fe46922cca13ecf13513b0039e505cf9ef257701d0e0170c97ac99cd2"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.16/moon-v0.4.16-aarch64-linux-gnu.tar.gz"
    sha256 "7ec6f2a239f29e96170992514100a83e7e22153fc09b544a06a4af4532d6ffcc"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.16/moon-v0.4.16-x86_64-linux-gnu.tar.gz"
    sha256 "cbc172df82204e47ec184a7dfa73ca55c08724d7d758163f46274e3e674ba7cf"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.16/moon-v0.4.16-riscv64-linux-gnu.tar.gz"
    sha256 "6d275461481be7fbf176901b745ad009ef03c7befb6759c9f8ea52b5c9c024c5"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.16/moon-v0.4.16-aarch64-freebsd.tar.gz"
      sha256 "e86e13a7b42c434d986a3e795f4aaa9d0e21d601209d20661cd0936d4e989e03"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.16/moon-v0.4.16-x86_64-freebsd.tar.gz"
      sha256 "d0b6f96eb469027a8182f19562d76f930efd3500eafc7df1c0b4cd774026d30c"
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
