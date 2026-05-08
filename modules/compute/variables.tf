variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "project_id" {
  type    = string
  description = "ID del proyecto para nombrar recursos"
}

variable "subnet_ids" {
  type = map(string)
}

variable "vm_size" {
  type = string
}

variable "ssh_key_path" {
  default = "id_labadmin.pub"
}


