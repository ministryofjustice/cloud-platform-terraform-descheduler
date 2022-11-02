locals {
    deschduler-version = "v0.23.1"
}

resource "helm_release" "descheduler" {
    name       = "descheduler"
    repository = "https://kubernetes-sigs.github.io/descheduler/"
    chart      = "descheduler"
    namespace  = "kube-system"

values = [templatefile("${path.module}/templates/descheduler.yaml.tpl", {
    descheduler_version = local.deschduler-version
    })]
}