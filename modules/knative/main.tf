
resource "helm_release" "knative_crds" {
  name       = "knative-crds"
  repository = "https://knative.github.io/helm-charts"
  chart      = "knative-crds"

  namespace        = "knative-serving"
  create_namespace = true
}

resource "helm_release" "knative_serving" {
  name       = "knative-serving"
  repository = "https://knative.github.io/helm-charts"
  chart      = "knative-serving"

  namespace = "knative-serving"

  depends_on = [
    helm_release.knative_crds
  ]
}
