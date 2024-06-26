# cloud-platform-terraform-descheduler

[![Releases](https://img.shields.io/github/release/ministryofjustice/cloud-platform-terraform-descheduler/all.svg?style=flat-square)](https://github.com/ministryofjustice/cloud-platform-terraform-descheduler/releases)

This terraform module installs the [Descheduler](https://github.com/kubernetes-sigs/descheduler#descheduler-for-kubernetes) for Kubernetes. 

Descheduler, based on its policies, finds pods that can be moved and evicts them. These evicted pods are scheduled on nodes are that more suited (based on the policies used to evict them) 
## Usage

```hcl
module "descheduler" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-descheduler?ref=0.0.2"
}
```
## Enabled Policies

### RemoveDuplicates

This strategy makes sure that there is only one pod associated with a ReplicaSet (RS), ReplicationController (RC), StatefulSet, or Job running on the same node.

### LowNodeUtilization

This strategy finds nodes that are underutilised and evicts pods from overutilised nodes in the hope that recreation of evicted pods will be scheduled on these underutilised nodes. 

The underutilisation of nodes is determined by a configurable `threshold` thresholds. The `threshold` thresholds can be configured for cpu, memory, number of pods, and extended resources in terms of percentage (the percentage is calculated as the current resources requested on the node vs total allocatable. For pods, this means the number of pods on the node as a fraction of the pod capacity set for that node).

### HighNodeUtilization

This strategy finds nodes that are underutilised and evicts pods from the nodes in the hope that these pods will be scheduled compactly into fewer nodes. 

Used in conjunction with node auto-scaling, this strategy is intended to help trigger down scaling of under utilized nodes

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >=2.6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >=2.6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.descheduler](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_removeduplicates"></a> [enable\_removeduplicates](#input\_enable\_removeduplicates) | Enable RemoveDuplicates which spreads pods across cluster, for cluster wtih number of nodes < number of pods, set it to false | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Tags

## Reading Material

https://github.com/kubernetes-sigs/descheduler
