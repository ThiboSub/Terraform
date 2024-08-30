provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}
data "vsphere_datacenter" "dc" {
  name = var.datacenter
}
#data "vsphere_compute_cluster" "cluster" {
# name = "172.16.103.246"
# datacenter_id = data.vsphere_datacenter.dc.id
#}
data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_datastore" "datastore_2" {
  name          = "NFS01"
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_folder" "vm_folder" {
  path = "Datacenter/vm/ESXI 1/C1-gr6"
  # path = "Datacenter/vm/Formateurs/Abderaman/Groupe 6"
  # datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_resource_pool" "pool" {
  name          = "Abderaman"
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_network" "network" {
  name          = "G1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = "vm_terraform_matthias"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = data.vsphere_folder.vm_folder.id

  num_cpus = var.cpu_number
  memory   = var.ram_size
  guest_id = "otherLinux64Guest"
  disk {
    label            = "disk0"
    size             = 10
    eagerly_scrub    = false
    thin_provisioned = true
  }
  cdrom {
    datastore_id = data.vsphere_datastore.datastore_2.id
    path         = "[NFS01] ISO/Linux/debian-12.5.0-and64-netinst.iso"
  }
  network_interface {
    network_id = data.vsphere_network.network.id
    #  ipv4_address = "172.16.100.67"
    #  ipv4_netmask = 22
  }
  # ipv4_gateway = "172.16.100.1"
}


