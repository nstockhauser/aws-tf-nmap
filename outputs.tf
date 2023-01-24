

### Public IP of Good Guy Computer ###

output "aws_instance_good_public_dns" {
  value = "ssh ubuntu@${aws_instance.good.public_ip} -i test-key"
}

output "aws_instance_bad_public_dns" {
  value = "ssh ubuntu@${aws_instance.bad.public_ip} -i test-key"
}