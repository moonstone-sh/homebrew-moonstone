class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.3.48"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.48/moon-v0.3.48-aarch64-macos.tar.gz"
    sha256 "13bfb12e5db11baa72df1134693cebfcb82c2343a97b4e7bf01b874997a20d55"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.48/moon-v0.3.48-x86_64-macos.tar.gz"
    sha256 "7b4807db2fd40230cfa9d9865727f474c90e0ea3d3e856420adc4f96b633863a"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.48/moon-v0.3.48-aarch64-linux-gnu.tar.gz"
    sha256 "8e4e41fe8bae478457c3453f71f3255d4c9bba34bfcfe861c5fd9f78bb0b5b06"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.48/moon-v0.3.48-x86_64-linux-gnu.tar.gz"
    sha256 "f2644245216286afa43a36674157a6d2e03bd48e98424c42f3954b082b466459"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.48/moon-v0.3.48-riscv64-linux-gnu.tar.gz"
    sha256 "c0926b7f4a3ab449860af71dcfa4664eb0e5322dad686ac42beef85a9d2251a3"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.48/moon-v0.3.48-aarch64-freebsd.tar.gz"
      sha256 "8a64124cbae3e451fae753fb8a4713d72d17e70e4654fc612aec2788fa1f879f"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.3.48/moon-v0.3.48-x86_64-freebsd.tar.gz"
      sha256 "9efa20e569f0f4cceac359f7dc0f0a2bc0a7547fa01814cd744771a125c332a6"
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
