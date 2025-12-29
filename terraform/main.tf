terraform {
  required_version = ">= 1.0"
  
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

# Load biến môi trường từ .env
locals {
  # Chando
  chando_shop_id  = var.chando_shop_id != "" ? var.chando_shop_id : ""
  chando_api_key  = var.chando_api_key != "" ? var.chando_api_key : ""
  
  # Facialbar
  facialbar_shop_id = var.facialbar_shop_id != "" ? var.facialbar_shop_id : ""
  facialbar_api_key = var.facialbar_api_key != "" ? var.facialbar_api_key : ""
  
  # Labhair
  labhair_shop_id = var.labhair_shop_id != "" ? var.labhair_shop_id : ""
  labhair_api_key = var.labhair_api_key != "" ? var.labhair_api_key : ""
  
  # Menard
  menard_shop_id = var.menard_shop_id != "" ? var.menard_shop_id : ""
  menard_api_key = var.menard_api_key != "" ? var.menard_api_key : ""
  
  # Yaman
  yaman_shop_id = var.yaman_shop_id != "" ? var.yaman_shop_id : ""
  yaman_api_key = var.yaman_api_key != "" ? var.yaman_api_key : ""
}

# Template cho chando connector
resource "local_file" "chando_connector" {
  content = templatefile("${path.module}/templates/chando-pancake-crm-contact.json.tpl", {
    shop_id = local.chando_shop_id
    api_key = local.chando_api_key
  })
  filename = "${path.module}/../src/chando/api/chando-pancake-crm-contact.json"
}

# Có thể thêm các connector khác tương tự ở đây

