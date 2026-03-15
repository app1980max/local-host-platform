
terraform {
  required_providers {
    argocd = {
      source  = "argoproj-labs/argocd"
      version = ">= 7.0.0"
    }
  }
}

provider "argocd" {
  server_addr = "https://argo-dev.appflex.io"
  username    = "admin"
  password    = "admin"
  insecure    = true
}

###---Application
resource "argocd_application" "keda" {
  metadata {
    name      = "keda"
    namespace = "argocd"
  }

  spec {
    project = "default"
    source {
      repo_url        = "https://kedacore.github.io/charts"
      chart           = "keda"
      target_revision = "2.17.0"
      
      helm {
        values = <<EOF
crds:
  install: true
EOF
      }
    }

    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "keda"
    }
    
    sync_policy {
      automated {
        prune = true
        self_heal = true
      }

      sync_options = [
        "CreateNamespace=true" # 👈 Enable namespace auto-creation
      ]
    }
  }
  depends_on = [argocd_application.minio]
}


