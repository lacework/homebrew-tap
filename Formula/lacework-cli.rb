class LaceworkCli < Formula
  VERSION = "v1.10.0".freeze
  desc "Lacework command-line interface helps to manage the Lacework platform"
  homepage "https://docs.lacework.com/cli"
  version VERSION
  license "Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-darwin-arm64.zip"
      sha256 "3052bb4c2ee08568d47c9f756a8d5320f52fedc55f90d7eb637d80df65fd81db"
    else
      url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-darwin-amd64.zip"
      sha256 "526a684d2b549776f7b5e21500bc55359bde5df67916d2f0c6ed04c4d4e3344b"
    end
  end
  if OS.linux? && Hardware::CPU.intel? && !Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-386.tar.gz"
    sha256 "105f1a06105540485480d2636bf55235128c934c13696324d8cfde7585e99ed9"
  end
  if OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-amd64.tar.gz"
    sha256 "80243d2820d15e64b853a3142d1554b7fe96ea3875aedbff6db5bb45e22d737b"
  end
  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-arm.tar.gz"
    sha256 "f635608a6106ee2a754d11403a0ec5c4b482b2f14eb7b85e2ef6433269c53392"
  end
  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/lacework/go-sdk/releases/download/#{VERSION}/lacework-cli-linux-arm64.tar.gz"
    sha256 "fbd9c1715806fcd5402a0b26e6b3ae1f3acd56c2133db335cb9fbff280e6c58c"
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
