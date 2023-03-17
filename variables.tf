 variable "enable_removeduplicates" {
  description = "Enable RemoveDuplicates which spreads pods across cluster, for cluster wtih number of nodes < number of pods, set it to false"
  default     = true
  type        = bool
}

