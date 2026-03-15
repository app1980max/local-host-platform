
resource "helm_release" "rancher" {
  name             = "rancher"
  namespace        = "cattle-system"
  repository       = "https://releases.rancher.com/server-charts/stable"
  chart            = "rancher"
  version          = "2.11.3"
  create_namespace = true

  values = [<<EOF
hostname: console-dev.appflex.io
# Admin credentials
bootstrapPassword: "q1w2e3r4100@"
replicas: 1

# Ingress configuration without cert-manager / LetsEncrypt
ingress:
  tls:
    source: secret     # Use your own TLS secret if needed
  extraAnnotations: {}
  ingressClassName: nginx

resources:
  requests:
    cpu: 250m
    memory: 512Mi
  limits:
    cpu: 500m
    memory: 1Gi
EOF
  ]
}
