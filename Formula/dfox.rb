class Dfox < Formula
  desc "Blazing-fast database client for your terminal: SQL and NoSQL in one TUI"
  homepage "https://github.com/0xataru/dfox"
  version "0.3.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/0xataru/dfox/releases/download/v0.3.5/dfox-aarch64-apple-darwin.tar.xz"
      sha256 "718a6e99f4dd81fd0cc9f930ab02e0b5ec5018fcafaa3187fbf63b1592e374a4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/0xataru/dfox/releases/download/v0.3.5/dfox-x86_64-apple-darwin.tar.xz"
      sha256 "17e932bde1d3626a515c916456cc466cf42abc76a6192d8bc27c9420b2c125a2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/0xataru/dfox/releases/download/v0.3.5/dfox-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3886353a5220811ad4f6b986f8cb5a23461e54cef9b3e2907abae4f2a806c7b1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/0xataru/dfox/releases/download/v0.3.5/dfox-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7aa850cb76e254f9a93357061a0b253df5dfc4f8684d943a8265f31a95b00717"
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
