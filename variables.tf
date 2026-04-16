variable "project" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}

variable "zone_name" {
  type        = string
  default     = "poguri.fun"
  description = "description"
}

variable "zone_id" {
  type        = string
  default     = "Z0626606ZLZ3TG4RMXQL"
  description = "description"
}

variable "sonar" {
  default = false
}