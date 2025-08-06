class LaceworkCli < Formula
  VERSION = "v2.5.1".freeze
  desc "Lacework command-line interface helps to manage the Lacework platform"
  homepage "https://docs.lacework.com/cli"
  version VERSION
  license "Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-darwin-arm64.zip"
      sha256 "0bf6706f57326d41b9ad7e7578ab86097560255348ffb19643ac272131f18ee3"
    else
      url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-darwin-amd64.zip"
      sha256 "a9aad1886065c1907e555e2a8ed1d946bf21854debc3e8719609ceb52105b8b9"
    end
  end
  if OS.linux? && Hardware::CPU.intel? && !Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-386.tar.gz"
    sha256 "bc740d9e25d29230911d9c77ddf5b90fe90936cd66e17307f2dc54844d471c39"
  end
  if OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-amd64.tar.gz"
    sha256 "4b90b79779c6c3f73c4c41cd146c24b6176131a6accd314048bb7c937691e50e"
  end
  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-arm.tar.gz"
    sha256 "c66e6d949b2c5aafa4eef76ccff82bc5e233ecdcbb3f144412814d537793d50e"
  end
  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-arm64.tar.gz"
    sha256 "06a8b777926cd7fafcb55efa80170bfcc0886aa7b4e9f2edb2f14de5ebbc111d"
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
