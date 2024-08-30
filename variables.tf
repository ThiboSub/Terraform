#Export TF_LOG=DEBUG

variable "vsphere_user" {
  description = "Utilisateur VSphere"
  type        = string
}

variable "vsphere_password" {
  description = "MDP VSphere"
  type        = string
}
variable "vsphere_server" {
  description = "Adresse IP du serveur VSphere"
  type        = string
}

variable "cpu_number" {
  description = "Nombre de CPU de la VM"
  type        = number
  default     = 1
}

variable "ram_size" {
  description = " Mémoire RAM de la VM"
  type        = number
  default     = 1024
}

variable "network_name" {
  description = "Nom du réseau"
  type        = string
}

variable "datacenter" {
  description = "Nom du DataCenter"
  type        = string
}
variable "datastore" {
  description = "Nom du DataStore"
  type        = string
}
