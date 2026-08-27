class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.4.4"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.4/moon-v0.4.4-aarch64-macos.tar.gz"
    sha256 "8463f9d84870980b373e01d1492cd1d52631bb510bae42204c32446e191945a5"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.4/moon-v0.4.4-x86_64-macos.tar.gz"
    sha256 "cb01d39bb3ff4dd6d3da3fd548df72f92ccc76b89168f654ed7f41cb1530e1b8"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.4/moon-v0.4.4-aarch64-linux-gnu.tar.gz"
    sha256 "9e5229105a00b6d875675f70a4cf624aa1f298efa8ededf854a9ce339dd23d81"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.4/moon-v0.4.4-x86_64-linux-gnu.tar.gz"
    sha256 "834cb6b7f7eb375ab71c69b11415f6a992a8818bd69af8641c4040286d0ec952"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.4/moon-v0.4.4-riscv64-linux-gnu.tar.gz"
    sha256 "5526c5602fad99fdf944b5cafcb4b20bb81c16543a666cdfbdee9efef2e9e1e4"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.4/moon-v0.4.4-aarch64-freebsd.tar.gz"
      sha256 "dea222eb8cf99aca3ce659331f2fcdf348cd391064981b6032fd814e736f3233"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.4/moon-v0.4.4-x86_64-freebsd.tar.gz"
      sha256 "21224b03efd271b850536c7480b24d69ebfd3adc3a220c140c710d0cfc4e8ec9"
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
