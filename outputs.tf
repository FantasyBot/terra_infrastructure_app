
output "instance_public_ip" {
  value = aws_instance.express_backend.public_ip
}

output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "public_subnet_1" {
  value = aws_subnet.public_subnet_1.id
}

output "subnet_id_2" {
  value = aws_subnet.public_subnet_2.id
}

output "security_group_id" {
  value = aws_security_group.allow_cloudfront_security_group.id
}

output "alb_dns_name" {
  value = aws_lb.app_alb.dns_name
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.main_igw.id
  description = "The ID of the Internet Gateway."
}

output "public_route_table_id" {
  value       = aws_route_table.public_route_table.id
  description = "The ID of the public route table."
}

output "s3_bucket_website_url" {
  value = aws_s3_bucket_website_configuration.frontend_bucket_website.website_endpoint
}

output "cloudfront_url" {
  value = aws_cloudfront_distribution.react_app_distribution.domain_name
}
