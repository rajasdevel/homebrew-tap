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
      url "https://github.com/rajasdevel/netshift/releases/download/v0.7.1/netshift_0.7.1_darwin_arm64.tar.gz"
      sha256 "4bf8b021b78bebdfd57e4fed00136c8dd87593941e0e14e6faab15547b0cee32"
    end
    on_intel do
      url "https://github.com/rajasdevel/netshift/releases/download/v0.7.1/netshift_0.7.1_darwin_amd64.tar.gz"
      sha256 "c0ef9567585171ea4b44a55eb79e57133db6ecd4a89f119bd3b33a20f641b440"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rajasdevel/netshift/releases/download/v0.7.1/netshift_0.7.1_linux_arm64.tar.gz"
      sha256 "79cb62c3f4c2652444a389ec00c8c03b331a7abb55bd786307b2648afd560bed"
    end
    on_intel do
      url "https://github.com/rajasdevel/netshift/releases/download/v0.7.1/netshift_0.7.1_linux_amd64.tar.gz"
      sha256 "d89eb10e8ff47ffaf6774903bcb71fa9abe732e6a9db803d0515bd51e96d7d5a"
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
