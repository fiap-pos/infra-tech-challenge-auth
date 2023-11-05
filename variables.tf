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

# Application Tag name
variable "application_tag_name" {
  type        = string
  description = "Value to put in application tag"
}

# Database name
variable "database_name" {
  type        = string
  description = "Database name"
  default     = "tech_challenge_auth"
}

variable "database_username" {
  type = string
  description = "Database username"
  default = "techchallenge"
}

# Atlas Project Environment
variable "environment" {
  type        = string
  description = "The environment to be built"
  default = "dev"
}

# Atlas Region
variable "atlas_region" {
  type        = string
  description = "Atlas region where resources will be created"
  default     = "US_EAST_1"
}

variable "aws_region" {
  type = string
  description = "AWS Region"
  default = "us-east-1"
}
