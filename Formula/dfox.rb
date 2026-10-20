class Dfox < Formula
  desc "Blazing-fast database client for your terminal: SQL and NoSQL in one TUI"
  homepage "https://github.com/0xataru/dfox"
  version "0.3.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/0xataru/dfox/releases/download/v0.3.6/dfox-aarch64-apple-darwin.tar.xz"
      sha256 "68cfd263e19239806a6cd0c93854afa28ae75af16693bd1ab3e855f271ac917f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/0xataru/dfox/releases/download/v0.3.6/dfox-x86_64-apple-darwin.tar.xz"
      sha256 "a715a0dd49d5a3b842fd8ea10fd73ff35055cc7597cb7f562e0730fcb47e1237"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/0xataru/dfox/releases/download/v0.3.6/dfox-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ef8e1d05db8eff058f7ae3c63a9a0065357ef269445823887035a59287cdeaff"
    end
    if Hardware::CPU.intel?
      url "https://github.com/0xataru/dfox/releases/download/v0.3.6/dfox-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1897d1e188715314b6f2a2d040bcb5b49c0ba9317fcbd67a46dbad527110bb74"
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
