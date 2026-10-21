class Dfox < Formula
  desc "Blazing-fast database client for your terminal: SQL and NoSQL in one TUI"
  homepage "https://github.com/0xataru/dfox"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/0xataru/dfox/releases/download/v0.4.0/dfox-aarch64-apple-darwin.tar.xz"
      sha256 "3827db7718d80936e8c63dd158dc520e6cb507ba35d43988803b015d65380e3c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/0xataru/dfox/releases/download/v0.4.0/dfox-x86_64-apple-darwin.tar.xz"
      sha256 "e1e1636897239effea2a5b9a68fd718e08c1a6a71e22d11913cdd40c080fc8b7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/0xataru/dfox/releases/download/v0.4.0/dfox-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7df90beed6ba0e8b74753ad013063570ded8a534601533368dec42a1963ee991"
    end
    if Hardware::CPU.intel?
      url "https://github.com/0xataru/dfox/releases/download/v0.4.0/dfox-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d05690be96621260adc9556f69e06e3c48a59a89c6810a9babfce33fd580423e"
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
end
