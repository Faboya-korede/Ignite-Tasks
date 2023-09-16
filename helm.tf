#Helm repo to set up monitoring, prometheus, grafana
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "kube-prometheus" {
  depends_on = [kubernetes_namespace.monitoring]
  namespace  = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  version    = "45.7.1"
  chart      = "kube-prometheus-stack"
  timeout = 2000
  name = "prometheus"
}