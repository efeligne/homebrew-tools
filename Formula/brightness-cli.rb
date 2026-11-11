# frozen_string_literal: true

# Controls display brightness on macOS.
class BrightnessCli < Formula
  desc "It just returns the current brightness level as a percentage"
  homepage "https://github.com/efeligne/mac-brightness-cli"
  url "https://github.com/efeligne/mac-brightness-cli/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "4209a3396491cdb33bd9dc7c73c8e1535804c1a01b959beb1398174bf725d3f8"
  license "MIT"

  deny_network_access!

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/brightness-cli"
  end

  test do
    assert_predicate bin / "brightness-cli", :executable?
  end
end
