locals {
  cluster_instance_size_name = "M0"
  cloud_provider = "AWS"
  ip_address = "0.0.0.0/0"
}

# Create a Project
resource "mongodbatlas_project" "atlas-project" {
  org_id = var.atlas_org_id
  name = var.atlas_project_name
}

# Create a Database User
resource "mongodbatlas_database_user" "db-user" {
  username = var.database_username
  password = random_password.db-user-password.result
  project_id = mongodbatlas_project.atlas-project.id
  auth_database_name = "admin"
  roles {
    role_name     = "readWrite"
    database_name = var.database_name
  }
}

# Create a Database Password
resource "random_password" "db-user-password" {
  length = 16
  special = true
  override_special = "_%@"
}

# Create Database IP Access List
resource "mongodbatlas_project_ip_access_list" "ip" {
  project_id = mongodbatlas_project.atlas-project.id
  cidr_block = local.ip_address
}

# Create an Atlas Advanced Cluster 
resource "mongodbatlas_advanced_cluster" "atlas-cluster" {
  project_id = mongodbatlas_project.atlas-project.id
  name = "${var.environment}-cluster"
  cluster_type = "REPLICASET"
  backup_enabled = false
  replication_specs {
    region_configs {
      electable_specs {
        instance_size = local.cluster_instance_size_name
      }
      priority              = 7
      provider_name         = "TENANT"
      backing_provider_name = local.cloud_provider
      region_name           = var.atlas_region
    }
  }
  tags {
    key   = "environment"
    value = var.environment
  }
  tags {
    key   = "application"
    value = var.application_tag_name
  }
}

# Stores variables into AWS ssm
resource "aws_ssm_parameter" "mongodb_database_url" {
  name        = "/${var.environment}/${var.application_tag_name}/MONGODB_URI"
  description = "Auth Mongo DB Password"
  type        = "SecureString"
  value       = "mongodb+srv://${var.database_username}:${mongodbatlas_database_user.db-user.password }@${replace(mongodbatlas_advanced_cluster.atlas-cluster.connection_strings.0.standard_srv, "mongodb+srv://", "")}"

  depends_on = [ 
    random_password.db-user-password,
    mongodbatlas_advanced_cluster.atlas-cluster
  ]
}

# Stores variables into AWS ssm
resource "aws_ssm_parameter" "mongodb_username" {
  name        = "/${var.environment}/${var.application_tag_name}/MONGODB_DATABASE"
  description = "Database name"
  type        = "String"
  value       = var.database_name
  depends_on = [ random_password.db-user-password ]
}

# Creates a S3 Bucket to hold terraform tfstate file 
resource "aws_s3_bucket" "auth_infra_bucket" {
  bucket = tech_challenge_auth
}

# Bucket Ownership Controls
resource "aws_s3_bucket_ownership_controls" "auth_infra_bucket_owner" {
  bucket = aws_s3_bucket.auth_infra_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

#Bucket ACL
resource "aws_s3_bucket_acl" "auth_infra_bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.auth_infra_bucket_owner]

  bucket = aws_s3_bucket.auth_infra_bucket.id
  acl    = "private"
}




# Outputs to Display
output "atlas_cluster_connection_string" { value = mongodbatlas_advanced_cluster.atlas-cluster.connection_strings.0.standard_srv }
output "project_name"      { value = mongodbatlas_project.atlas-project.name }
output "username"          { value = mongodbatlas_database_user.db-user.username } 
output "bucket"            { value = aws_s3_bucket.auth_infra_bucket.s3_bucket_bucket_domain_name}
output "user_password"     { 
  sensitive = true
  value = mongodbatlas_database_user.db-user.password 
}