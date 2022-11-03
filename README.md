# cloud-platform-terraform-descheduler

[![Releases](https://img.shields.io/github/release/ministryofjustice/cloud-platform-terraform-descheduler/all.svg?style=flat-square)](https://github.com/ministryofjustice/cloud-platform-terraform-descheduler/releases)

This terraform module installs the [Descheduler](https://github.com/kubernetes-sigs/descheduler#descheduler-for-kubernetes) for Kubernetes. 

Descheduler, based on its policies, finds pods that can be moved and evicts them. These evicted pods are scheduled on nodes are that more suited (based on the policies used to evict them) 
## Usage

```hcl
module "descheduler" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-descheduler?ref="
}
```
## Enabled Policies

### RemoveDuplicates

This strategy makes sure that there is only one pod associated with a ReplicaSet (RS), ReplicationController (RC), StatefulSet, or Job running on the same node.

### LowNodeUtilization

This strategy finds nodes that are underutilised and evicts pods from overutilised nodes in the hope that recreation of evicted pods will be scheduled on these underutilised nodes. 

The underutilisation of nodes is determined by a configurable `threshold` thresholds. The `threshold` thresholds can be configured for cpu, memory, number of pods, and extended resources in terms of percentage (the percentage is calculated as the current resources requested on the node vs total allocatable. For pods, this means the number of pods on the node as a fraction of the pod capacity set for that node).


<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.descheduler](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

No inputs.

## Outputs

No outputs.

<!--- END_TF_DOCS --->

## Tags

## Reading Material

https://github.com/kubernetes-sigs/descheduler
