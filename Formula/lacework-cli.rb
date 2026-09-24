class LaceworkCli < Formula
  VERSION = "v2.19.0".freeze
  desc "Lacework command-line interface helps to manage the Lacework platform"
  homepage "https://docs.lacework.com/cli"
  version VERSION
  license "Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-darwin-arm64.zip"
      sha256 "cc1cc1fc57ede7ea1045c3b9512b9083055b7492acaef05c62894b686801d0e5"
    else
      url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-darwin-amd64.zip"
      sha256 "f42d113da175c2f48c604032e7353ba3e23a6918349029fac8e1a7c11302dee7"
    end
  end
  if OS.linux? && Hardware::CPU.intel? && !Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-386.tar.gz"
    sha256 "96714bed38dab03eb06730b07c9cf88da4f0061ab775cc0694499e28a9949516"
  end
  if OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-amd64.tar.gz"
    sha256 "180c3321133741bf119d76cf2d1742df0c5c70d0f14e8b7c98cef6ecadf40b34"
  end
  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-arm.tar.gz"
    sha256 "a079efebc56ef715372341d6790f0818c5836063d05fe15d21a7c0b83efba12a"
  end
  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-arm64.tar.gz"
    sha256 "ddd619bd9fb248b8732515889dcfa468593cb6457ee628d692b7262ce0e3fd81"
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
