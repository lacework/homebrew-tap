class LaceworkCli < Formula
  VERSION = "v0.14.0".freeze
  desc "Lacework command-line tool helps to manage the Lacework cloud platform"
  homepage "https://github.com/lacework/go-sdk/wiki/CLI-Documentation"
  version VERSION
  license "Apache-2.0"
  bottle :unneeded

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-darwin-arm64.zip"
      sha256 "25ee7518c0feda50cf2ea58ba0dbbce1c725e29042d5638fe4aba9edca8cdf18"
    else
      url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-darwin-amd64.zip"
      sha256 "869008a6146eb7627c4dbc0c107f7cd933663be57144e467e34ddd6af73b6d16"
    end
  end
  if OS.linux? && Hardware::CPU.intel? && !Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-386.tar.gz"
    sha256 "5627289ceda023dd2fb04c3b43716facc0d621472501018bccdfbef50b06b1df"
  end
  if OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-amd64.tar.gz"
    sha256 "a1b135153d54321196e06e788d341bb1dcdcb0a9b0c07f166b89142d58e219fb"
  end
  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-arm.tar.gz"
    sha256 "46b1469e0ee9ec3280d4cd708a92e36f2547dda61c8f801b6dd02ce967c8ce9b"
  end
  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-arm64.tar.gz"
    sha256 "6212c2a6f6b0d547d4b450dc1fea70cdfdf17fde8d826ea7be7444673776207b"
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
