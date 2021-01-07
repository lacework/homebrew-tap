class LaceworkCli < Formula
  VERSION = "v0.2.13"
  ARCH = RbConfig::CONFIG['host_cpu'].downcase

  desc "The Lacework Command Line Interface is a tool that helps you manage the Lacework cloud security platform"
  homepage "https://github.com/lacework/go-sdk/wiki/CLI-Documentation"
  version "#{VERSION}"
  license "Apache-2.0"
  
  if OS.mac?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-darwin-amd64.zip"
    sha256 "91e12d7e14ad9c3f780e9c73cc4bb18cb9d6151ad91678262daf6b326c2e03a8"
  elsif OS.linux?
    case ARCH
      when "aarch64"
        url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-arm64.tar.gz"
        sha256 "0d7f44c29cb2d850dc859e40f6151aa4979bb7438456968b0806ddc772a29da4"   
      when /i\d86|x86|i86pc/
        url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-386.tar.gz"
        sha256 "c3e0b866b8d4079c71f167ca0538c850e48c36532ba19a9673cdf6514142bfe3"
      when /^arm/
        url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-arm.tar.gz"
        sha256 "4cdc974952facd126a703858d7cb012cf393f7b394a590fe41f37e0abdb55e27"
      when /amd64|x86_64|x64/
        url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-amd64.tar.gz"
        sha256 "938f7f14a6d6bd3a7e6ab7eca29ccbe3719df0d8863f4eb5bb0fe69dad45c717"
      else
        print "The Lacework CLI formula does not support this Architecture #{ARCH}"
      end
  end

  bottle :unneeded

  def install
    bin.install "lacework"
  end

  test do
    assert_match "lacework #{VERSION}", shell_output("#{bin}/lacework version", 2)
  end
end
