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
      url "https://github.com/rajasdevel/netshift/releases/download/v0.7.0/netshift_0.7.0_darwin_arm64.tar.gz"
      sha256 "370521fabb05e0aaf6984689243d142e59201c8b3bd455660275099e4637860e"
    end
    on_intel do
      url "https://github.com/rajasdevel/netshift/releases/download/v0.7.0/netshift_0.7.0_darwin_amd64.tar.gz"
      sha256 "af90434ee35e7acbdc59cee38d0b0414c0ebd5c2f850235169cadd321930ea7f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/rajasdevel/netshift/releases/download/v0.7.0/netshift_0.7.0_linux_arm64.tar.gz"
      sha256 "5d373bb5925db1ab98a0e27e251c863658139ac38f6a695deb816e31fd48338c"
    end
    on_intel do
      url "https://github.com/rajasdevel/netshift/releases/download/v0.7.0/netshift_0.7.0_linux_amd64.tar.gz"
      sha256 "ccdbb6ccf6dec0111341831b90b809011e9b0cbb1f295aa14ec774445b1a4db3"
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
