# frozen_string_literal: true

# Generates Git commit message.
class Cm < Formula
  desc "cm generates Git commit messages from staged changes using a local MLX model."
  homepage "https://github.com/efeligne/cm"
  url "https://github.com/efeligne/cm/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "85251af5c160c333d4d17d77ae9edba4e7559a4849148f0bc871328f39e7dc8c"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "make", "release"
    bin.install "target/release/cm"
  end

  test do
    assert_predicate bin / "cm", :executable?
  end
end
