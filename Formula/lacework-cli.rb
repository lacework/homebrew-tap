class LaceworkCli < Formula
  VERSION = "v0.23.0".freeze
  desc "Lacework command-line tool helps to manage the Lacework cloud platform"
  homepage "https://github.com/lacework/go-sdk/wiki/CLI-Documentation"
  version VERSION
  license "Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-darwin-arm64.zip"
      sha256 "25a8fef0630214ce63a0cc240c978c24373d7341362e0deff9c9370342449106"
    else
      url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-darwin-amd64.zip"
      sha256 "525c20d714f5f44b92251913b74e67a9633c0199802e2415cb56c1862adf99ec"
    end
  end
  if OS.linux? && Hardware::CPU.intel? && !Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-386.tar.gz"
    sha256 "27e14dec0d4e5b52e3ed358441965afdfa055042fdbb79c845095dc382c977dc"
  end
  if OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-amd64.tar.gz"
    sha256 "45327b72ae54f314917568b544459dbd070898744df260846bb5ce83f1b72055"
  end
  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-arm.tar.gz"
    sha256 "4c5d214582648c30ad559c4c2cf720dc46dc499dc866b5073b6d26f327e98c25"
  end
  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-arm64.tar.gz"
    sha256 "6a31c7f86c053fc39b8311ec7e309287fd9ef44af20e2605ad763620387e3ff9"
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
