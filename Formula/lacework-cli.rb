class LaceworkCli < Formula
  VERSION = "v0.2.12"
  desc "The Lacework Command Line Interface is a tool that helps you manage the Lacework cloud security platform"
  homepage "https://github.com/lacework/go-sdk/wiki/CLI-Documentation"
  url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-darwin-amd64.zip"
  version "#{VERSION}"
  sha256 "30eccdd2317b09e3ad74c62e4c3c489dfd78a16e98d2afe359cbd0a4506025c8"
  license "Apache-2.0"

  bottle :unneeded

  def install
    bin.install "lacework"
  end

  test do
    assert_match "lacework #{VERSION}", shell_output("#{bin}/lacework version", 2)
  end
end

