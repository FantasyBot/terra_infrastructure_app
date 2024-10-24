resource "aws_key_pair" "deployer_key" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_rsa_new.pub")
}

resource "aws_instance" "express_backend" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_cloudfront_security_group.id]
  key_name               = aws_key_pair.deployer_key.key_name
  subnet_id              = aws_subnet.public_subnet_1.id

  user_data = <<-EOF
              #!/bin/bash
              # Update the system
              sudo yum update -y

              # Install Node.js and npm
              sudo yum install -y nodejs npm git

              # Install PM2 globally
              sudo npm install -g pm2

              # Set up the application directory and set permissions
              mkdir -p /home/ec2-user/server_app
              sudo chown ec2-user:ec2-user /home/ec2-user/server_app
              sudo chmod 755 /home/ec2-user/server_app
              EOF

  tags = {
    Name        = "ExpressBackend"
    Environment = var.environment
  }
}

resource "aws_lb_target_group_attachment" "app_tg_attachment" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.express_backend.id
  port             = 80
}
