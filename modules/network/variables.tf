variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_name" {
  type = string
}
variable "vnet_address_space" {
  type = list(string)

}

variable "common_tags" {
  description = "Etiquetas comunes pasadas desde el módulo raíz"
  type        = map(string)
  default     = {}
}

