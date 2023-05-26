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

1. A populated `./override.tf` file created from `./override.tf.tmpl`

## Contributing

The team should contribute changes via the standard feature branch/pull request GitFlow.

Currently `./.github/workflows/docs.yml` will run on pull requests that touch this content, parse the source for documentation, and then append that documentation to the `./README.md` via a new commit on that feature branch.

## Prepare Working Directory

1. Initialize Terraform to prepare the Terraform working directory for additional `terraform` commands.
   ```shell
   $ terraform init
   ```
   If any updates are made to the hard-coded module and/or provider versions, you will need to add the `-upgrade` option. Otherwise, an error will occur during initialization.

### Additional Terraform Commands

1. Always begin by displaying the changes required by the current configuration.
   ```shell
   $ terraform plan -var-file ./override.tf
   ```
1. Follow that by creating and/or updating the infrastructure.
   ```shell
   $ terraform apply -var-file ./override.tf
   ```
   If an error occurs, check the **Gotchas** below for additional commands.
1. And if necessary, remove the previously-created infrastructure.
   ```shell
   $ terraform destroy -var-file ./override.tf
   ```

See the resource links below for more details on the `terraform` CLI.

## Gotchas

### Soft DELETES

Some `resource`s can have soft **DELETED** `state` attributes such as:
* `google_iam_workload_identity_pool`
* `google_iam_workload_identity_pool_provider`

As described in [GitHub: Gracefully handle soft deletes #12941](https://github.com/hashicorp/terraform-provider-google/issues/12941), a work-around is required after a `terraform destroy` before a `terraform apply` will succeed.

1. Undelete the soft-deleted pools and providers.
   ```shell
   $ gcloud iam workload-identity-pools undelete github-workflows --location=global
   $ gcloud iam workload-identity-pools providers undelete github-workflow-provider --workload-identity-pool=github-workflows --location=global
   ```
1. Import the new state into terraform for both the pools and providers.
   ```shell
   $ terraform import  -var-file ./override.tf google_iam_workload_identity_pool.github-workflows github-workflows
   $ terraform import  -var-file ./override.tf google_iam_workload_identity_pool_provider.github-workflow-provider github-workflows/github-workflow-provider
   ```

1. Re-run the `apply` command:
   ```shell
   terraform apply -var-file ./override.tf
   ```

### Error acquiring the state lock

It is possible to cause an error with the state lock file when doing things like pounding **Ctrl + c** during `terraform appy <args>`. There are probably other ways to arrive at this error, but we have not encountered them yet.

```shell
$ terraform plan -var-file ./override.tf
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
<!-- END_TF_DOCS -->  