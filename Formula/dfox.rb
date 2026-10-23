class Dfox < Formula
  desc "Blazing-fast database client for your terminal: SQL and NoSQL in one TUI"
  homepage "https://github.com/0xataru/dfox"
  version "0.5.33"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/0xataru/dfox/releases/download/v0.5.33/dfox-aarch64-apple-darwin.tar.xz"
      sha256 "27eaa66944eff35c474c19bfa4ad47c8900f7e140ea32052aa350b45bafbcc12"
    end
    if Hardware::CPU.intel?
      url "https://github.com/0xataru/dfox/releases/download/v0.5.33/dfox-x86_64-apple-darwin.tar.xz"
      sha256 "22b2f381716253148560c19ddb7e3229e522450af3182a38a1a1061a0b20e77b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/0xataru/dfox/releases/download/v0.5.33/dfox-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "74f37d487ed32e16f495972b50dd7976a93cffcdbb9f6c907d5d6a86aee8d122"
    end
    if Hardware::CPU.intel?
      url "https://github.com/0xataru/dfox/releases/download/v0.5.33/dfox-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "729b5fc095cbd8bf4542187262779cfe8c156d7b358ba5b64f46d437bdcbbdb3"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "dfox"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "dfox"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "dfox"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "dfox"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dfox version")
  end
end
