// Define empty variable blocks – values inherited from module blocks
variable "project_name" {}
variable "group_name" {}
variable "location" {}
variable "interface_ids" {}

variable "vm_size" {
    default = "Standard_B1ms"
}

variable "storage_size" {
    default = "Standard_LRS"
}