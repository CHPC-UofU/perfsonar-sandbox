# perfSONAR Sandbox Terraform Module

Terraform module for the perfSONAR sandbox project currently focusing on the Google Cloud Platform (GPC).

## Requirements

1. An installed and configured [Hashicorp Terraform CLI](https://developer.hashicorp.com/terraform).
1. An installed and configured [gcloud CLI](https://cloud.google.com/sdk/docs/install#linux).
1. Authentication with the GCP.
   ```shell
   gcloud auth application-default login
   ```
1. A Google Cloud Project with `serviceusage` and `cloudresourcemanager` APIs already enabled.
   ```shell
   gcloud services enable serviceusage.googleapis.com cloudresourcemanager.googleapis.com
   ```
   
    * Enabling either of these via Terraform requires they already be enabled ([learn more](https://medium.com/rockedscience/how-to-fully-automate-the-deployment-of-google-cloud-platform-projects-with-terraform-16c33f1fb31f)).

1. A populated `./override.tfvars` file created from `./override.tfvars.tmpl`

## Contributing

The team should contribute changes via the standard feature branch/pull request GitFlow.

Currently `./.github/workflows/terraform-docs.yml` will run on pull requests that touch this content, parse the source for documentation, and then append that documentation to the `./README.md` via a new commit on that feature branch.

## Prepare Working Directory

1. Initialize Terraform to prepare the Terraform working directory for additional `terraform` commands.
   ```shell
   $ terraform init
   ```
   If any updates are made to the hard-coded module and/or provider versions, you will need to add the `-upgrade` option. Otherwise, an error will occur during initialization.

### Additional Terraform Commands

1. Always begin by displaying the changes required by the current configuration.
   ```shell
   $ terraform plan -var-file ./override.tfvars
   ```
1. Follow that by creating and/or updating the infrastructure.
   ```shell
   $ terraform apply -var-file ./override.tfvars
   ```
   If an error occurs, check the **Gotchas** below for additional commands.
1. And if necessary, remove the previously-created infrastructure.
   ```shell
   $ terraform destroy -var-file ./override.tfvars
   ```

See the resource links below for more details on the `terraform` CLI.

## Gotchas

### Error acquiring the state lock

It is possible to cause an error with the state lock file when doing things like pounding **Ctrl + c** during `terraform appy <args>`. There are probably other ways to arrive at this error, but we have not encountered them yet.

```shell
$ terraform plan -var-file ./override.tfvars
╷
│ Error: Error acquiring the state lock
│ 
│ Error message: writing "gs://path/to/terraform/state/default.tflock" failed: googleapi: Error 412:
│ At least one of the pre-conditions you specified did not hold., conditionNotMet
│ Lock Info:
│   ID:        <id>
│   Path:      gs://path/to/terraform/state/default.tflock
│   Operation: OperationTypeApply
│   Who:       <you>
│   Version:   1.4.6
│   Created:   2023-05-05 16:50:55.86294629 +0000 UTC
│   Info:      
│ 
│ 
│ Terraform acquires a state lock to protect the state from being written
│ by multiple users at the same time. Please resolve the issue above and try
│ again. For most commands, you can disable locking with the "-lock=false"
│ flag, but this is not recommended.
```

If you are **absolutely positively super sure** no one else is running Terraform right now, execute the following to unlock the current state.

```shell
$ terraform force-unlock <id>
Do you really want to force-unlock?
  Terraform will remove the lock on the remote state.
  This will allow local Terraform commands to modify this state, even though it
  may still be in use. Only 'yes' will be accepted to confirm.

  Enter a value: yes

Terraform state has been successfully unlocked!

The state has been unlocked, and Terraform commands should now be able to
obtain a new lock on the remote state.
```

See [Command: force-unlock](https://developer.hashicorp.com/terraform/cli/commands/force-unlock) for more details.

## Resources

* [What is Terraform](https://developer.hashicorp.com/terraform/intro)
* [Best practices for using Terraform](https://cloud.google.com/docs/terraform/best-practices-for-terraform)
* [How to Fully Automate the Deployment of Google Cloud Platform Projects with Terraform](https://medium.com/rockedscience/how-to-fully-automate-the-deployment-of-google-cloud-platform-projects-with-terraform-16c33f1fb31f)
* [Terraform: How To Rename (Instead Of Deleting) A Resource](https://openupthecloud.com/terraform-rename-instead-delete/)
* [Store Terraform state in a Cloud Storage bucket](https://cloud.google.com/docs/terraform/resource-management/store-state#change_the_backend_configuration)
* [Export your Google Cloud resources into Terraform format](https://cloud.google.com/docs/terraform/resource-management/export)
* [Command: force-unlock](https://developer.hashicorp.com/terraform/cli/commands/force-unlock)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.1 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.60.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.60.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_enabled_google_apis"></a> [enabled\_google\_apis](#module\_enabled\_google\_apis) | terraform-google-modules/project-factory/google//modules/project_services | ~>14.2.0 |
| <a name="module_vm_compute_instance"></a> [vm\_compute\_instance](#module\_vm\_compute\_instance) | terraform-google-modules/vm/google//modules/compute_instance | ~>8.0.1 |
| <a name="module_vm_instance_template"></a> [vm\_instance\_template](#module\_vm\_instance\_template) | terraform-google-modules/vm/google//modules/instance_template | ~>8.0.1 |
| <a name="module_vpc_router"></a> [vpc\_router](#module\_vpc\_router) | terraform-google-modules/cloud-router/google | ~>5.0.0 |

## Resources

| Name | Type |
|------|------|
| [google_compute_firewall.allow-ingress-from-iap-ipv4](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.allow_internal_ipv4](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.allow_internal_ipv6](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_network.vpc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_subnetwork.vpc_subnet](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_perfsonar_instances"></a> [perfsonar\_instances](#input\_perfsonar\_instances) | The perfSONAR instances, each comprised of:<br>* num\_instances: The number of compute instances to create.<br>* role: The perfSONAR role to assign to the instance as a label. | <pre>list(object({<br>    num_instances = number<br>    role          = string<br>  }))</pre> | <pre>[<br>  {<br>    "num_instances": 1,<br>    "role": "archive"<br>  },<br>  {<br>    "num_instances": 1,<br>    "role": "testpoint"<br>  },<br>  {<br>    "num_instances": 1,<br>    "role": "toolkit"<br>  }<br>]</pre> | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The Project ID for the Google Cloud project. | `string` | `""` | no |
| <a name="input_project_number"></a> [project\_number](#input\_project\_number) | The Project Number for the Google Cloud project | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | The region is a specific geographical location where resources are hosted. | `string` | `"us-central1"` | no |
| <a name="input_software_stack_name"></a> [software\_stack\_name](#input\_software\_stack\_name) | The name of the software stack. | `string` | `"sandbox"` | no |
| <a name="input_source_image_family"></a> [source\_image\_family](#input\_source\_image\_family) | The source image family in the associated project. | `string` | `"centos-7"` | no |
| <a name="input_source_image_project"></a> [source\_image\_project](#input\_source\_image\_project) | The project where the source image comes from. | `string` | `"centos-cloud"` | no |
| <a name="input_stack_type"></a> [stack\_type](#input\_stack\_type) | The stack type for the compute instance interfaces to identify whether the IPv6 feature is enabled or not. | `string` | `"IPV4_ONLY"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The zone within a region where resources are hosted. | `string` | `"us-central1-c"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_name"></a> [vpc\_name](#output\_vpc\_name) | Virtual Private Cloud (VPC) name. |
| <a name="output_vpc_subnet_name"></a> [vpc\_subnet\_name](#output\_vpc\_subnet\_name) | Virtual Private Cloud (VPC) subnet name. |
<!-- END_TF_DOCS -->  