class LaceworkCli < Formula
  VERSION = "v2.19.1".freeze
  desc "Lacework command-line interface helps to manage the Lacework platform"
  homepage "https://docs.lacework.com/cli"
  version VERSION
  license "Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-darwin-arm64.zip"
      sha256 "8e9da622cee36bc8b1a66e35e2292205094384e4734d15ea8ab0b6a5bc104c85"
    else
      url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-darwin-amd64.zip"
      sha256 "d78c744d39f4ce7e46ebeaeb489a57908fcb6817a04d8a40da1e191209c76da5"
    end
  end
  if OS.linux? && Hardware::CPU.intel? && !Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-386.tar.gz"
    sha256 "e8055e0fb0dcf7bed66605fc09150832e8460de5af1cbfede17cb8dfc06cfbe2"
  end
  if OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-amd64.tar.gz"
    sha256 "5dc7ce2493cde514d63a4463a66337e15efe76efcc6bc7e8ad6f8874aa3ed64a"
  end
  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-arm.tar.gz"
    sha256 "534c8ab55ca8c50bd3846da904f1bc7ded9455e564dfceda9586d88725917635"
  end
  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-arm64.tar.gz"
    sha256 "476784b6f9766739322ff25d2d8a94c74b3809ae5fc76c12054769defa9d0d5d"
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
