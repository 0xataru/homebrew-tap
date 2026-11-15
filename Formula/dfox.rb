class Dfox < Formula
  desc "Blazing-fast database client for your terminal: SQL and NoSQL in one TUI"
  homepage "https://github.com/0xataru/dfox"
  version "0.5.37"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/0xataru/dfox/releases/download/v0.5.37/dfox-aarch64-apple-darwin.tar.xz"
      sha256 "29ec04b2caf1eab35a7e7077a4935eb4eb9ceec83697417f89b4ecb3b0bdd69a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/0xataru/dfox/releases/download/v0.5.37/dfox-x86_64-apple-darwin.tar.xz"
      sha256 "17f1d27ec3eb84a304fe07b03922b35ae8b4db7967c6f0a79d0449a162d0a795"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/0xataru/dfox/releases/download/v0.5.37/dfox-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9776b10a9bc3499f45e468a95c5dec63dc07ad43218ac0a501aed37cc8455e09"
    end
    if Hardware::CPU.intel?
      url "https://github.com/0xataru/dfox/releases/download/v0.5.37/dfox-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5b20acf856ff63a983c39753cda934ae4238e5e4c6443a930d5ca1bcaf44e7d0"
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
