class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.4.14"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.14/moon-v0.4.14-aarch64-macos.tar.gz"
    sha256 "d5737764d2c9e712bbc469dc40193d8b8524487a6be1da9a891e25237398a667"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.14/moon-v0.4.14-x86_64-macos.tar.gz"
    sha256 "1c8d375e601f343262c13184499406ef889166b13e1745abada3b448f176710b"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.14/moon-v0.4.14-aarch64-linux-gnu.tar.gz"
    sha256 "b5776faa348947046fb0e1c858598ea09293a31333ab3331598b7c573ec4ed12"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.14/moon-v0.4.14-x86_64-linux-gnu.tar.gz"
    sha256 "89bac3ba438d2262f4582347df9bea4fc425421e50e2b6210aaca3aeaf41b6eb"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.14/moon-v0.4.14-riscv64-linux-gnu.tar.gz"
    sha256 "a5295179f402b2dcfa35a6ed58f4e974e02214c566c2a4610031b7b372445ce2"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.14/moon-v0.4.14-aarch64-freebsd.tar.gz"
      sha256 "80a3c6a89ba7ee6258c2516cf9ac195d4f516dcf91314a5dff0f3ddf3846afe4"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.4.14/moon-v0.4.14-x86_64-freebsd.tar.gz"
      sha256 "c01194d3506ab980b330a3487a98e29aed6326e8eee5dbdb2dd5263602f2a1aa"
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
