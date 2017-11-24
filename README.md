# Google Cloud Platform NAT Gateway Terraform Module

A Terraform Module for creating either 1 or 3 NAT Gateways in a given Google Project. Inspired by a simalar ['google module'](https://github.com/GoogleCloudPlatform/terraform-google-nat-gateway) but more opinionated, and does not use Managed Instance Groups as the goal for this module is for Terraform to completely own the instances, not to have an external entity creating/destroying them.

## Usage

```
module "terraform-gcp-natgateway" {
  source = "github.com/migs/terraform-gcp-natgateway"
  project = "${var.project}"
  region = "${var.region}"
}
```
## High Availability

By passing the `ha` variable as `true`, 3 NAT gateways will be created instead of 1

## Variables

See `variables.tf`

## Outputs

The following outputs are defined:

`nat-gateway-zone1-external_ip` : External IP of nat-gateway-zone1
`nat-gateway-zone2-external_ip` : External IP of nat-gateway-zone2
`nat-gateway-zone3-external_ip` : External IP of nat-gateway-zone3
