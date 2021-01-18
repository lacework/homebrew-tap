class LaceworkCli < Formula
  VERSION = "v0.2.14"
  desc "The Lacework Command Line Interface is a tool that helps you manage the Lacework cloud security platform"
  homepage "https://github.com/lacework/go-sdk/wiki/CLI-Documentation"
  version VERSION
  license "Apache-2.0"
  bottle :unneeded
  
  if OS.mac?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-darwin-amd64.zip"
    sha256 "f9ce80aef1c2da8c6b2af1dee3a68f63dcb8f42399995e3c33ad595c96030c24"
  end
  if OS.linux? && Hardware::CPU.intel? && !Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-386.tar.gz"
    sha256 "6da2199230b508b4714f4b412d35c0661a54abda237b7f3283434afaae59f0cc"
  end
  if OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-amd64.tar.gz"
    sha256 "e75b8f8eeeda80e607fd6788bcc5847ddcf83d44b1b165b41c5fc2106d2fc6dc"
  end
  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-arm.tar.gz"
    sha256 "e640dc13f9382df7ac236ae8692c8709f809d838d7766fd84308cba9ad1ac29d"
  end
  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-arm64.tar.gz"
    sha256 "8ef0da29b76fe3a4c76e7ce9199696d12dc4467caf63dc9a553de8aad2a5b681"   
  end

  def install
    prefix.install "lacework"

    (bin/"lacework").write <<~EOS
    #!/bin/bash
    LW_HOMEBREW_INSTALL=1 exec "#{prefix}/lacework" "$@"
    EOS
  end

  test do
    assert_match "lacework #{VERSION}", shell_output("#{bin}/lacework version", 2)
  end
end
