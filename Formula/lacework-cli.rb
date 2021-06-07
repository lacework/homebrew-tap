class LaceworkCli < Formula
  VERSION = "v0.8.0".freeze
  desc "Lacework command-line tool helps to manage the Lacework cloud platform"
  homepage "https://github.com/lacework/go-sdk/wiki/CLI-Documentation"
  version VERSION
  license "Apache-2.0"
  bottle :unneeded

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-darwin-arm64.zip"
    sha256 "823079aaeaa5363cc1408122a3a23f516a54c8dc1938c74437d40f392600c70b"
    else
      url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-darwin-amd64.zip"
    sha256 "911bad1eff6206a41e5c02e2b3439ab30cbb3c5107e60177b198a69bdf24e58a"
    end
  end
  if OS.linux? && Hardware::CPU.intel? && !Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-386.tar.gz"
    sha256 "6d473af02c4fde2318fbfd13f2ac0d441fd021e0fc4665511095e24951f70357"
  end
  if OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-amd64.tar.gz"
    sha256 "38b803274c9cc50fce2ab75140afdff61436b71c0e41a2eeb8fc901ad895562f"
  end
  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-arm.tar.gz"
    sha256 "8d9a7300cac62465ef77aa3c2fa89f8d30c80590cae750400fad89ab27c5fda9"
  end
  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-arm64.tar.gz"
    sha256 "eed7d5f26eb187a55869b120dec50ca15c09511a999ec641ae16d98bacdfbb0a"
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
