<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.00 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.00 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | v4.7.0 |
| <a name="module_s3_bucket_remote_module"></a> [s3\_bucket\_remote\_module](#module\_s3\_bucket\_remote\_module) | git::https://github.com/smgriffiths144/terraform-modules.git | v1.6.0 |
| <a name="module_sqs"></a> [sqs](#module\_sqs) | terraform-aws-modules/sqs/aws | n/a |
| <a name="module_website_s3_bucket"></a> [website\_s3\_bucket](#module\_website\_s3\_bucket) | ./modules/s3 | n/a |
| <a name="module_website_s3_bucket_v2"></a> [website\_s3\_bucket\_v2](#module\_website\_s3\_bucket\_v2) | ./modules/s3 | n/a |
| <a name="module_website_s3_bucket_v3"></a> [website\_s3\_bucket\_v3](#module\_website\_s3\_bucket\_v3) | ./modules/s3 | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_internet_gateway.intgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_route.route1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.route2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.routetable1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.routetable2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.routetableassoc1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.routetableassoc2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.secure1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.secure2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.subnet1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.subnet2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | AL2023 in us-east-1 | `string` | `"ami-0e449927258d45bc4"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type | `string` | `"t2.micro"` | no |
| <a name="input_name_tag"></a> [name\_tag](#input\_name\_tag) | Name of the EC2 instance | `string` | `"My EC2 Instance"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secuirty_group_arn"></a> [secuirty\_group\_arn](#output\_secuirty\_group\_arn) | n/a |
| <a name="output_website_bucket_arn"></a> [website\_bucket\_arn](#output\_website\_bucket\_arn) | ARN of the bucket |
| <a name="output_website_bucket_name"></a> [website\_bucket\_name](#output\_website\_bucket\_name) | Name (id) of the bucket |
<!-- END_TF_DOCS -->