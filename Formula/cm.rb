# frozen_string_literal: true

# Generates Git commit message.
class Cm < Formula
  desc "cm generates Git commit messages from staged changes using a local MLX model."
  homepage "https://github.com/efeligne/cm"
  url "https://github.com/efeligne/cm/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "e3e0bb20029cc98e2d60f3ffd71e56d56bde173d362e488ce9d0336070997ead"
  license "MIT"

  depends_on "rust" => :build
  deny_network_access!

  def install
    system "make", "release"
    bin.install "target/release/cm"
  end

  test do
    assert_predicate bin / "cm", :executable?
  end
end
