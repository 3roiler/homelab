# GitOps Homelab Setup

Dieses Repository implementiert eine GitOps-Umgebung mit FluxCD für dein Homelab.

## Struktur

```
homelab/
├── flux-system/              # Hauptproduktions-Flux-Konfiguration (main branch)
├── flux-system-dev/          # Dev-Umgebung Flux-Konfiguration
├── environments/             # Umgebungsspezifische Konfigurationen
│   ├── dev/                 # Development Umgebung
│   ├── staging/             # Staging Umgebung (für später)
│   └── prod/                # Production Umgebung (für später)
├── apps/                    # Anwendungsdefinitionen
│   └── nginx-example/       # Beispiel-Nginx-App
└── infrastructure/          # Infrastruktur-Komponenten
    └── namespaces/          # Kubernetes Namespaces
```

## Branches und Umgebungen

- **main**: Production-Umgebung (überwacht von deinem Kubernetes-Cluster)
- **dev**: Development-Umgebung (dieser Branch)

## Erste Schritte

### 1. Dev-Umgebung einrichten

Um die dev-Umgebung in deinem Cluster zu aktivieren:

```bash
# Committen und pushen der aktuellen Änderungen
git add .
git commit -m "feat: initial GitOps structure for dev environment"
git push origin dev

# Dev-Flux in deinem Cluster installieren (auf dem main-Cluster)
kubectl apply -f flux-system-dev/
```

### 2. Überprüfung der Deployment

```bash
# Flux-Status überprüfen
flux get sources git
flux get kustomizations

# Pods überprüfen
kubectl get pods -n default
kubectl get services -n default
```

### 3. Workflow für neue Anwendungen

1. **Neue App erstellen**: Füge eine neue App im `apps/` Verzeichnis hinzu
2. **Environment aktualisieren**: Füge die App in `environments/dev/apps/kustomization.yaml` hinzu
3. **Testen**: Committe auf dev-branch und überprüfe das Deployment
4. **Produktiv nehmen**: Merge dev → main für Production

## Nächste Schritte

1. **Secrets Management**: Integriere SOPS oder Sealed Secrets
2. **Monitoring**: Füge Prometheus/Grafana hinzu
3. **Multi-Tenancy**: Erweitere Namespace-Strategien
4. **Helm Charts**: Integriere Helm für komplexere Anwendungen
5. **Image Automation**: Automatisiere Image-Updates

## Nützliche Befehle

```bash
# Flux reconciliation forcieren
flux reconcile source git flux-system-dev
flux reconcile kustomization flux-system-dev

# Logs anzeigen
flux logs --follow --tail=10

# Suspend/Resume
flux suspend kustomization flux-system-dev
flux resume kustomization flux-system-dev
```

## Troubleshooting

### Häufige Probleme:

1. **GitRepository not found**: Überprüfe SSH-Key und Repository-URL
2. **Kustomization failed**: Überprüfe YAML-Syntax mit `kubectl apply --dry-run`
3. **Resource conflicts**: Überprüfe Namespace-Konflikte

### Debug-Befehle:

```bash
# Beschreibung von Flux-Ressourcen
kubectl describe gitrepository flux-system-dev -n flux-system
kubectl describe kustomization flux-system-dev -n flux-system

# Events anzeigen
kubectl get events -n flux-system --sort-by='.lastTimestamp'
```