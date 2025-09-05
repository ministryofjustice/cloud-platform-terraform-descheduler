locals {
  descheduler-version = "0.32.2"
}

resource "helm_release" "descheduler" {
  name       = "descheduler"
  repository = "https://kubernetes-sigs.github.io/descheduler/"
  chart      = "descheduler"
  namespace  = "kube-system"
  version    = local.descheduler-version

    values = [templatefile("${path.module}/templates/descheduler.yaml.tpl", {
               enable_removeduplicates  =    var.enable_removeduplicates
  })]
}
