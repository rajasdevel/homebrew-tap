class Netshift < Formula
  desc "Run your own scripts when your public IP or connectivity changes"
  homepage "https://github.com/rajasdevel/netshift"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # Prebuilt release archives. Bump with scripts/bump-formula.py in the netshift
  # repository, which takes the checksums from the release's SHA256SUMS.
  on_macos do
    on_arm do
      url "https://github.com/rajasdevel/netshift/releases/download/v0.6.0/netshift_0.6.0_darwin_arm64.tar.gz"
      sha256 "ca2e304a0a6ec60a10f671848cb4a10f7c9806a056546f33393da52ad91a6e06"
    end
    on_intel do
      url "https://github.com/rajasdevel/netshift/releases/download/v0.6.0/netshift_0.6.0_darwin_amd64.tar.gz"
      sha256 "453020faf83a9530d2c9f0432e29da54500a1f22f169360b7a364868240e87b9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rajasdevel/netshift/releases/download/v0.6.0/netshift_0.6.0_linux_arm64.tar.gz"
      sha256 "ee950cfd8608845a550cd5369cc9432161200d775a43ba097f08be7bd6d2b63f"
    end
    on_intel do
      url "https://github.com/rajasdevel/netshift/releases/download/v0.6.0/netshift_0.6.0_linux_amd64.tar.gz"
      sha256 "cdd52c8a54c04c6d16508a6ab6538403394e2190ae3bd5ed633324ead25bc5d1"
    end
  end

  def install
    bin.install "netshift"
    pkgshare.install "config", "recipes"
    doc.install Dir["docs/*.md"]
  end

  def caveats
    <<~EOS
      Example profiles and recipes are in:
        #{opt_pkgshare}

      An installed NetShift service runs its own copy of the binary. After
      `brew upgrade netshift`, run this again for each profile:
        netshift --config PROFILE service install --start
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/netshift --version").strip
    output = shell_output("#{bin}/netshift --config #{pkgshare}/config/example.json validate")
    assert_match "Valid profile \"example\"", output
  end
end
