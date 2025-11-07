.PHONY: validate reconcile check

validate:
	@echo "🔍 Validiere Manifeste..."
	@find . -name '*.yaml' -type f ! -path './.git/*' -exec kubectl --dry-run=client apply -f {} \; 2>&1 | grep -v "unchanged" || true
	@echo "✅ Validierung abgeschlossen"

check:
	@echo "🔍 Flux Status:"
	@flux check
	@echo ""
	@echo "📦 Kustomizations:"
	@kubectl get kustomizations -n flux-system
	@echo ""
	@echo "🔄 GitRepositories:"
	@kubectl get gitrepositories -n flux-system

reconcile:
	@echo "🔄 Reconcile flux-system..."
	@flux reconcile source git flux-system
	@flux reconcile kustomization flux-system
	@echo "✅ Reconciliation abgeschlossen"

tree:
	@tree -L 3 -I '.git' --dirsfirst