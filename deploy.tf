
# To deploy the manifestfile 
resource "kubectl_manifest" "nodejs_deployment" {
  yaml_body = file("${path.module}/deployment.yaml")
}

resource "kubectl_manifest" "service" {
  yaml_body = file("${path.module}/service.yaml")
}