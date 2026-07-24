class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.44"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.44/moon-v0.3.44-aarch64-macos.tar.gz"
    sha256 "afaa327e854527a16ef3ca8d60fc22d9a696abca25e4183caef7c6a7daa7ef57"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.44/moon-v0.3.44-x86_64-macos.tar.gz"
    sha256 "dea71e0469b98ab5f87250ad85b86e808883dea8ad0e4d9f1ce00a4bb6b59009"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.44/moon-v0.3.44-aarch64-linux-gnu.tar.gz"
    sha256 "4dd30f7793e194ce2c6d5cc12e77b00ee94ef8bb21b451b4271d01950e329355"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.44/moon-v0.3.44-x86_64-linux-gnu.tar.gz"
    sha256 "42f45e6e956091a3045a68199c18b5493470aae0f7b3d07678f4428cf6ac3d31"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.44/moon-v0.3.44-riscv64-linux-gnu.tar.gz"
    sha256 "60a5ffaa271c11bcbb5219e0505f59be01ae105e1f07cd7a89614d929262c3eb"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.44/moon-v0.3.44-aarch64-freebsd.tar.gz"
      sha256 "c270172bf5a1e467d6bcf62d2401d6538b62c79f4f4f0d65dd681c815c83959c"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.44/moon-v0.3.44-x86_64-freebsd.tar.gz"
      sha256 "ac2452e712ec79e7c585eff9d79696317920b359b56a7b2d478bf2b2ebe021d7"
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
