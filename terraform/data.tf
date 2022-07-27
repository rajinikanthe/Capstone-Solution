output "vpc_id" {
  description = "ID of project VPC"
  value       = module.vpc.vpc_id
}

output "privateSubnet1_id" {
  description = "ID of privateSubnet1"
  value       = module.vpc.private_subnets[0]
}
output "privateSubnet2_id" {
  description = "ID of privateSubnet2"
  value       = module.vpc.private_subnets[1]
}
output "publicSubnet1_id" {
  description = "ID of publicSubnet1"
  value       = module.vpc.public_subnets[0]
}
output "publicSubnet2_id" {
  description = "ID of publicSubnet2"
  value       = module.vpc.public_subnets[1]
}

