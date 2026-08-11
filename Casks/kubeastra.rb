# KubeAstra desktop app.
#
# version/sha256 are maintained by .github/workflows/update-cask.yml. It is
# NOT yet triggered automatically — KubeAstra's release workflow sends no
# repository_dispatch, so run it by hand after each desktop release:
#   gh workflow run update-cask.yml --repo astraverse-io/homebrew-tap \
#     -f version=<x.y.z>
#
cask "kubeastra" do
  version "0.2.0"

  # arm64 only. There is no Intel build: PyInstaller cannot cross-compile
  # and GitHub retired the Intel macOS runners (DESKTOP_APP_PLAN decision 2).
  on_arm do
    sha256 "2ceb2d6709fe787d7c38f5d739b6a135d95526997337db58506e9cb9cb44b8d8"

    url "https://github.com/astraverse-io/KubeAstra/releases/download/desktop-v#{version}/KubeAstra_#{version}_aarch64.dmg",
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

  depends_on arch: :arm64
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
