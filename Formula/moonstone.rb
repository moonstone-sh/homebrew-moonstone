class Moonstone < Formula
  desc "Reliable Lua environments, ready at a snap"
  homepage "https://moonstone.sh"
  version "0.5.7"
  
  if OS.mac? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.7/moon-v0.5.7-aarch64-macos.tar.gz"
    sha256 "e1625cfa844f303b5ff4bd066eec51173b109592cea225e8896cd574d19508aa"
  end

  if OS.mac? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.7/moon-v0.5.7-x86_64-macos.tar.gz"
    sha256 "2ea281513b273ddd75931447233f98acf80b1ec7d665934007b77d481dd4fa97"
  end

  if OS.linux? && Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.7/moon-v0.5.7-aarch64-linux-gnu.tar.gz"
    sha256 "139e42d12b93d95c00245f01bd118f7b61cb93d0ebcba03f7914795e35e48754"
  end

  if OS.linux? && Hardware::CPU.intel?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.7/moon-v0.5.7-x86_64-linux-gnu.tar.gz"
    sha256 "7a15a706926abc7a992365ba567132cc17435b018e4df16baaad32851d349147"
  end

  if OS.linux? && Hardware::CPU.riscv64?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.7/moon-v0.5.7-riscv64-linux-gnu.tar.gz"
    sha256 "ea892aee5bd9a5852f0fc2879d2b3d909edd539088460995a98f5c6b81d3a7ea"
  end

  if OS.respond_to?(:freebsd?) && OS.freebsd?
    if Hardware::CPU.arm?
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.7/moon-v0.5.7-aarch64-freebsd.tar.gz"
      sha256 "89d00b9a8600cd69ed264894bc7d0d96e172d98a9af92bdd88efc4c8b7448af4"
    else
      url "https://github.com/moonstone-sh/moonstone/releases/download/v0.5.7/moon-v0.5.7-x86_64-freebsd.tar.gz"
      sha256 "63fafdeba362aa85e942271634916f4d36dfe7e1c1e0fad2b802e14a90987e5f"
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
