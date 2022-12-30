# 02: Blocks

## `Terraform` Block
- introduced onward v0.14
- define required version
- define required provders
- define backend

- only constant values allowed

```code
terraform {

    required_version = "~> 1.3.6"           # 1.3.x, where x >= 6
    
    required_providers {
        myaws = {
            source  = "hashicorp/aws"
            version = "~> 3.34.0"
        }
    }


    # define the state store for terraform.tfstate
    backend "s3" {
        bucket  = "my-remote-s3-bucket"
        key     = "path/to/key"
        region  = "us-east-1"
    }
}
```


## `Provider` Block
- core of terraform
- interconnect remote cloud and terraform cli


```code
provider "myaws" {
    profile = "default"                     #aws profile to be used
    region  = "us-east-1"                   #aws region to be used
}
```

## `Resource` Block
- resource definitions

```code
resource "aws_instance" "my_ec2_host" {
    ami_id          = "ami-<extn>"
    instance_type   = "t2.micro"
}
```
