#!/usr/bin/env zsh
set -euo pipefail

gen() {
  local cmd="$1"; shift
  local file="$1"; shift || true
  local out="$HOME/.oh-my-zsh/completions/${file}";

  if command -v "$cmd" >/dev/null 2>&1; then
    if "$cmd" completion zsh >/dev/null 2>&1; then
      "$cmd" completion zsh > "$out"
      echo "✅ $cmd → $out"
    else
      echo "⚠️  $cmd unterstützt 'completion zsh' nicht (prüfe Befehl)"
    fi
  else
    echo "⏭️  $cmd nicht installiert, überspringe"
  fi
}

gen kubectl _kubectl || true
gen helm _helm || true
gen flux _flux || true
gen minikube _minikube || true
gen docker _docker || true

# kopiere .kubeconfig von workspace ordner in .kube/config, sofern vorhanden und ordner prüfen
if [ -f .kubeconfig ]; then
  mkdir -p $HOME/.kube
  cp .kubeconfig $HOME/.kube/config
  echo "✅ kopiere .kubeconfig nach $HOME/.kube/config"
else
  echo "⏭️  keine .kubeconfig im workspace ordner gefunden, überspringe"
fi