class LaceworkCli < Formula
  VERSION = "v0.7.0".freeze
  desc "Lacework command-line tool helps to manage the Lacework cloud platform"
  homepage "https://github.com/lacework/go-sdk/wiki/CLI-Documentation"
  version VERSION
  license "Apache-2.0"
  bottle :unneeded

  if OS.mac?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-darwin-amd64.zip"
    sha256 "95c959a445a2891521c10dd9a3dd2b3313a4466a47de1988645526d1350beb7f"
  end
  if OS.linux? && Hardware::CPU.intel? && !Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-386.tar.gz"
    sha256 "af15ee935e1df4dffb6f627d3e36cf1aab6dd5f1bbc2ac9406fbf80963342eb1"
  end
  if OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-amd64.tar.gz"
    sha256 "859b11ba373b084c0f96f775822d5575f0900a9309cf166421519d66f6bd6c57"
  end
  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-arm.tar.gz"
    sha256 "0cbc0c691557f9bed1801598bae7f6ee2c8c1f3fa3700068dc088823dcd508e7"
  end
  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-arm64.tar.gz"
    sha256 "e2615987055153db1307eaba1a133914c62a911251ba784c73e967a414aedcb2"
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
