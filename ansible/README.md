
# Ansible Playbook

Ansible Playbook for the perfSONAR sandbox project currently focusing on the Google Cloud Platform (GPC).

## Requirements

1. A Python interpreter with Ansible and the necessary Pip packages.
   ```shell
   $ python3.9 -m venv venv
   $ source ./venv/bin/activate
   $ (venv) pip install -r ./requirements.txt
   ```
1. Downloaded Ansible requirements.
   ```shell
   $ (venv) ansible-galaxy install -r ./requirements.yml
   ```
1. An installed and configured [gcloud CLI](https://cloud.google.com/sdk/docs/install#linux).
1. Authentication with the GCP.
   ```shell
   gcloud auth application-default login
   ```

## Connecting to VMs

Manually SSH to a VM via IAP tunnelling:

```shell
$ gcloud compute ssh default-001
```

or let Ansible do it.

## Resources

* [How to tell Ansible to use GCP IAP tunneling](https://xebia.com/blog/how-to-tell-ansible-to-use-gcp-iap-tunneling/)
* [GCP IAP Tunnelling on Ansible with Dynamic Inventory](https://www.bionconsulting.com/blog/gcp-iap-tunnelling-on-ansible-with-dynamic-inventory)
* [google.cloud.gcp_compute inventory – Google Cloud Compute Engine inventory source](https://docs.ansible.com/ansible/latest/collections/google/cloud/gcp_compute_inventory.html)