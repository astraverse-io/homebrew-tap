# KubeAstra desktop app.
#
# version/sha256 are maintained by .github/workflows/update-cask.yml, which
# the KubeAstra release workflow triggers on each `desktop-v*` tag. Editing
# them by hand is fine but usually unnecessary.
#
# NOT YET INSTALLABLE: the first signed DMG ships with desktop Phase 2. Until
# then `version` is a placeholder and `brew install` will fail on checksum.
cask "kubeastra" do
  version "0.0.0"

  on_arm do
    sha256 :no_check

    url "https://github.com/astraverse-io/KubeAstra/releases/download/desktop-v#{version}/KubeAstra_#{version}_aarch64.dmg",
        verified: "github.com/astraverse-io/KubeAstra/"
  end
  # Delete this block if the x64 build lane is dropped (see DESKTOP_APP_PLAN
  # decision 2 — GitHub has been retiring Intel macOS runners and PyInstaller
  # cannot cross-compile).
  on_intel do
    sha256 :no_check

    url "https://github.com/astraverse-io/KubeAstra/releases/download/desktop-v#{version}/KubeAstra_#{version}_x64.dmg",
        verified: "github.com/astraverse-io/KubeAstra/"
  end

  name "KubeAstra"
  desc "AI-powered Kubernetes investigation assistant"
  homepage "https://github.com/astraverse-io/KubeAstra"

  livecheck do
    url :url
    regex(/^desktop[._-]v?(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  depends_on macos: :big_sur

  app "KubeAstra.app"

  zap trash: [
    "~/Library/Application Support/KubeAstra",
    "~/Library/Caches/io.astraverse.kubeastra",
    "~/Library/Preferences/io.astraverse.kubeastra.plist",
    "~/Library/Saved Application State/io.astraverse.kubeastra.savedState",
  ]

  # KubeAstra runs kubectl from the user's PATH rather than bundling it.
  caveats do
    <<~EOS
      KubeAstra uses the kubectl and kubeconfig already on this machine.
      If kubectl is not installed:
        brew install kubectl
    EOS
  end
end
