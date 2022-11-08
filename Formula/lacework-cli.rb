class LaceworkCli < Formula
  VERSION = "v0.45.0".freeze
  desc "Lacework command-line interface helps to manage the Lacework platform"
  homepage "https://docs.lacework.com/cli"
  version VERSION
  license "Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-darwin-arm64.zip"
      sha256 "ac4c32b8faca200e7efefda2ea43f62383c423b6f25583af4e68ef07edee0926"
    else
      url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-darwin-amd64.zip"
      sha256 "35e0d90f037edfcb7719d3606849b212760e93313767d86d5ea273b4ff00f2e2"
    end
  end
  if OS.linux? && Hardware::CPU.intel? && !Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-386.tar.gz"
    sha256 "3c5bfa64bfb3ae77b447749c75dfee90fa56b172355013e297e1e27b885460a5"
  end
  if OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-amd64.tar.gz"
    sha256 "f315b000a752f8206b2bb7c4c5e397460c910a4c05d070e1080866cd8ecd7f34"
  end
  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-arm.tar.gz"
    sha256 "cc1c2a5d8e6099cc8e8aad6e9aa1ac56f49723454e048a572dfae5e1a7f52681"
  end
  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-arm64.tar.gz"
    sha256 "f4b0e2bdc27bdf0191e4b7d3a35d5075077009766b4fa11ec87d85de62889308"
  end

  def install
    prefix.install "lacework"

    (bin/"lacework").write <<~EOS
      #!/bin/bash
      LW_HOMEBREW_INSTALL=1 exec "#{prefix}/lacework" "$@"
    EOS
  end

  test do
    assert_match "lacework #{VERSION}", shell_output("#{bin}/lacework version")
  end
end
