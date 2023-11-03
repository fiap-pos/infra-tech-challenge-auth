# Atlas Organization ID 
variable "atlas_org_id" {
  type        = string
  description = "Atlas Organization ID"
}
# Atlas Project Name
variable "atlas_project_name" {
  type        = string
  description = "Atlas Project Name"
}

# Database name
variable "database_name" {
  type        = string
  description = "Database name"
}

# Atlas Project Environment
variable "environment" {
  type        = string
  description = "The environment to be built"
}

# Cluster Instance Size Name 
variable "cluster_instance_size_name" {
  type        = string
  description = "Cluster instance size name"
}

# Cloud Provider to Host Atlas Cluster
variable "cloud_provider" {
  type        = string
  description = "AWS or GCP or Azure"
}

# Atlas Region
variable "atlas_region" {
  type        = string
  description = "Atlas region where resources will be created"
}

# IP Address Access
variable "ip_address" {
  type = string
  description = "Cdir block to access cluster"
}