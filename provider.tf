terraform {
  required_version = ">= 0.13"

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

provider "kubectl" {
  config_path = "~/int/kubeconfig.yaml"
}


#Giving Helm access 
provider "helm" {
  kubernetes {
     config_path = "~/int/kubeconfig.yaml"
  }
}

provider "kubernetes" {
   config_path = "~/int/kubeconfig.yaml"
}

