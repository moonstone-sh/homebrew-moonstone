class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.7.0"
  revision 1
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.7.0/moon-v0.7.0-aarch64-macos.tar.gz"
    sha256 "ec8bf07783cb3dff8cfa79f9d1c36c91bd965a240981e610da6b207bb210e0da"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.7.0/moon-v0.7.0-x86_64-macos.tar.gz"
    sha256 "8a42c39c9bb76a5f890e69f6ac99cd295acae16faffe677e5acae0dec8c16132"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.7.0/moon-v0.7.0-aarch64-linux-gnu.tar.gz"
    sha256 "01be680c9055c5f5a15ca8d48c54433cd3b41af5ce92c8549d5e9628bd90bc25"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.7.0/moon-v0.7.0-x86_64-linux-gnu.tar.gz"
    sha256 "1ccc1b6d6f52e64840b98059a3f6714a75cb2249577e73a0d9f08f7cd18224fa"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.7.0/moon-v0.7.0-riscv64-linux-gnu.tar.gz"
    sha256 "c5b194268905a78eb5dd3059f68597f9bbbfa70243955f2a6afda5c565019ba6"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.7.0/moon-v0.7.0-aarch64-freebsd.tar.gz"
      sha256 "65811ef44fd8c3bbdfd7ad73f581e87572848035e19fd37a01d7bc70c5327889"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.7.0/moon-v0.7.0-x86_64-freebsd.tar.gz"
      sha256 "ba65547d291ab21f6a531463627da2ab7f5bfdbef2fccd8628c7b9b89aec2ac2"
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
