class LaceworkCli < Formula
  VERSION = "v0.21.0".freeze
  desc "Lacework command-line tool helps to manage the Lacework cloud platform"
  homepage "https://github.com/lacework/go-sdk/wiki/CLI-Documentation"
  version VERSION
  license "Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-darwin-arm64.zip"
      sha256 "fc475a37c95d6f0630bd35dc790d84938460fd50ac94ef3eef1e3bf2ee22c8da"
    else
      url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-darwin-amd64.zip"
      sha256 "77cb470498efebe055d01090066f7d9bfa83b3e237cbaf1840d7e827bfab952e"
    end
  end
  if OS.linux? && Hardware::CPU.intel? && !Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-386.tar.gz"
    sha256 "3fc07c77a3284134d4abf977d519c5b927b6eea95a8fdc8619c31b61b558095d"
  end
  if OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-amd64.tar.gz"
    sha256 "95d05ab95bac850265a404c903dd677775d1e125bc65f7e04042602ba5c11b67"
  end
  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-arm.tar.gz"
    sha256 "adb7ebf9b85855703eccddc70d7e359c365a103f0753afd37ed2dfe14af98fd2"
  end
  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-arm64.tar.gz"
    sha256 "055b565b778f20bcaf169886768c277d7b9e60a7ff201945e756c28d9b82ce93"
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
