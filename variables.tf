 variable "disable_removeduplicates" {
  description = "A single string to fix issue 'Concourse erroring ProcessNotFoundError #4433'. Possible values are true, false. For the workspace 'Manager' only 'Remove Duplicates will be set to 'false'"
  default     = "true"
  type        = string
}

