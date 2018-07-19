# Datadog Terraform Integration
Terraform code to automate Datadog AWS integration

## About
This is the subset of *terraform* configuration files that you can use in order to configure Datadog into your AWS environment. 

This process is described and document on [Datadog documentation page](https://docs.datadoghq.com/integrations/amazon_web_services/).

## Requisites
### Terraform

You must [download Terraform binary](https://www.terraform.io/downloads.html) and install it (single binary)

### Credentials
For credentials you can either use a shared credentials file (usually created through *aws-cli*) or export them though your shell of preference.

For *aws-cli*, after installing the package you must run:
```
$ aws configure
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: us-west-2
Default output format [None]: json
```

For the shell approach, just export `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` variables:

```
$ export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
$ export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

### Variables
Make sure you edit both `backend.tf` and `variable.tf` before running this (otherwise it will fail).

The `backend.tf` file doesn't accept interpolations because it runs prior any of Terraform features that format and build your code, so that's why all variables aren't just inside one single file.

## Executing
For executing this you must first initialize your configuration with:
```
$ terraform init
```
This will create a `.terraform/` folder containing some information there. Then you can both *validate* and *plan* your configuration:
```
$ terraform validate
$ terraform plan
```
This will validate your syntax and output some information identifying what will be done into your AWS environment. For deploying these changes into your environment:
```
$ terraform apply
```

## Author
Marcelo Marques da Silva Varge
(marcelo.varge at gmail)
