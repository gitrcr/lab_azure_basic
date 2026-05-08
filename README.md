# Plantilla laboratorio Azure
!! usar solo en laboratorios !!
Crear una infraestructura básica en Azure utilizando Terraform. (requiere git y terraform)

* project: random-hex. Se añade a todos los recursos "-xxxxxx"
* resource_group: lab-rg
* storage account: opcional
* red virtual: 10.44.0.0/16
* subnet gtw-vlan (10.44.1.0/24)
* subnet srv-vlan (10.44.2.0/24) - sin internet
* subnet db-vlan (10.44.3.0/24) - sin internet
* azure linux vm: ubuntu 24 (certificad e ip pública)
* tags en todos los recursos

### 1. Clonar el repo azlab_linux

```bash
git clone https://github.com/gitrcr/azlab_linux.git
cd azlab_linux
# create ssh key (test) in compute module folder
ssh-keygen -t rsa -b 2048 -C "labadmin@linux-vm" -f .\modules\compute\id_labadmin
```

### 2. Crear cuenta de servicio en Azure
* Acceder a Azure (cuenta lab)
* Abrir Cloud Shell
* Pegar el siguiente código

```bash
bash <(wget -qO - https://raw.githubusercontent.com/gitrcr/scripts/refs/heads/main/azlab-sp.sh)
```
* Copiar el bloque entre "===="
* Pegar en el fichero terraform.tfvars

### 3. Revisar parámetros de cuenta: locals.tf
En caso de utilizar freetier, ajustar location y vm_size para disponer de las configuraciones gratuitas.

```bash
locals {
  location   = "northeurope"
  vm_size = "Standard_D2s_v3" # cost
  # vm_size = "Standard_B2ats_v2" # freetier
  }
```

### 4. Inicializar, aplicar y destruir

```bash
terraform fmt
terraform init -upgrade
terraform validate
terraform plan -out main.tfplan
terraform apply main.tfplan

# crear la infraestructura
terraform apply
# eliminar los objetos creados
# terraform destroy
```

### 5. Output y conexión al servidor

```bash
Outputs:

linux-vm = {
  "name" = "linux-05449521"
  "private_ip" = "10.44.1.4"
  "public_ip" = "20.234.86.65"   # copy public ip
}
location = "northeurope"
project_id = "05449521"
rg_name = "lab-rg-05449521"
storage_account = "storageacc05449521"
subnet_name_cidr = {
  "db-vnet" = "10.44.3.0/24"
  "gtw-vnet" = "10.44.1.0/27"
  "srv-vnet" = "10.44.2.0/24"
}
```

```bash
# ssh al servidor linux-vm
ssh labadmin@20.234.86.65 -i modules/compute/id_labadmin
```
