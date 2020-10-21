variable "prefix" {
  description = "A prefix used for all resources in this example"
  default = "aks-spot-cluster-demo"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be provisioned"
  default = "westeurope"
}