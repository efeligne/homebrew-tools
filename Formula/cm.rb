# frozen_string_literal: true

# Generates Git commit message.
class Cm < Formula
  desc "cm generates Git commit messages from staged changes using a local MLX model."
  homepage "https://github.com/efeligne/cm"
  url "https://github.com/efeligne/cm/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "3111cb6a1b3876a0377d73284ad03e02496f2b24443dc38e91a5db4b4cfed352"
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
