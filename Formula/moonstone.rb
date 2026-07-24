class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.43"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.43/moon-v0.3.43-aarch64-macos.tar.gz"
    sha256 "49077c73b9beed657afe9860a4ee36f65c42ea0cad80c8d48bb7cf4a507b9401"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.43/moon-v0.3.43-x86_64-macos.tar.gz"
    sha256 "3486790fd1d445e1afef624de7e78f531135d5ce14584743d1e9813883ee3468"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.43/moon-v0.3.43-aarch64-linux-gnu.tar.gz"
    sha256 "807ca3a7c4b013e76889ca7366daee2d7afe9f78131bdb8a21e30455eb46cbca"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.43/moon-v0.3.43-x86_64-linux-gnu.tar.gz"
    sha256 "43750b9924eb3254c35b91f27af50fd31888c9e8ef462ba7583687301d245b42"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.43/moon-v0.3.43-riscv64-linux-gnu.tar.gz"
    sha256 "6c0c60db8dda047463984b31d8ed1f01c66085edb9de9bfb19a260dfb41d91fc"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.43/moon-v0.3.43-aarch64-freebsd.tar.gz"
      sha256 "88ea7af79bcb1cf92b622b2cec38ecc6a5600db96e7c989c91543707d7863266"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.43/moon-v0.3.43-x86_64-freebsd.tar.gz"
      sha256 "817567b93c1ad636f70984f4dd2a1f358de4c3efe1081e282076d1483ad267e7"
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
