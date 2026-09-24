class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.4.19"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.19/moon-v0.4.19-aarch64-macos.tar.gz"
    sha256 "73396e4ec802a1eab94196365ebd35d489f80164473d140a95501572ecd0788c"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.19/moon-v0.4.19-x86_64-macos.tar.gz"
    sha256 "34dd3ddf4c60b350ff94d53daac5a57880431523bba3fcac233815a275aec42a"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.19/moon-v0.4.19-aarch64-linux-gnu.tar.gz"
    sha256 "e1fec08ff5ab9f02c51b6e3e668f9b6a1beada03b27280a3381dd5c73bb24fe9"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.19/moon-v0.4.19-x86_64-linux-gnu.tar.gz"
    sha256 "abf36015cf79b6e9afd4589c58fb431aeaab4ba80413f93faf5767e4b2c16f74"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.19/moon-v0.4.19-riscv64-linux-gnu.tar.gz"
    sha256 "c65d8f24f28e37d6778296f457d90d01b35f83c79e285904830cf957e24f294b"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.19/moon-v0.4.19-aarch64-freebsd.tar.gz"
      sha256 "f957548c96c1153a842269ad034922fcf1009fbbc34d2dc77e1cbbf70c173537"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.19/moon-v0.4.19-x86_64-freebsd.tar.gz"
      sha256 "41595820573b15ccb98807ca91c3143159153f198c836daca4994766c2286649"
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
