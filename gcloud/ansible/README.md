
# Ansible Playbook

Ansible Playbook for the perfSONAR sandbox project currently focusing on the Google Cloud Platform (GPC).

## Requirements

1. A Python interpreter with Ansible and the necessary Pip packages.
   ```shell
   $ python3.9 -m venv venv
   $ source ./venv/bin/activate
   (venv) $ pip install -r ./requirements.txt
   ```
1. Downloaded Ansible requirements.
   ```shell
   (venv) $ ansible-galaxy install -r ./requirements.yml
   ```
1. An installed and configured [gcloud CLI](https://cloud.google.com/sdk/docs/install#linux).
1. Authentication with the GCP.
   ```shell
   $ gcloud auth application-default login
   $ gcloud auth login
   ```

## Connecting to VMs

Test the configuration by viewing the dynamic inventory:

```shell
(venv) $ ansible-inventory -i ./inventory/gcp.yml --graph
```

Manually SSH to a VM via IAP tunnelling to propagate your SSH key file:

```shell
$ gcloud compute ssh <hostname>
```

and ping each group via Ansible to make sure the SSH key works:

```shell
(venv) $ ansible label_bundle_archive -i ./inventory/gcp.yml -m ping --private-key=~/.ssh/google_compute_engine
```

## Run the Playbook

Once the SSH keys are set up locally and on the remote hosts, play the Ansible.

```shell
(venv) $ ansible-playbook playbook.yml

PLAY [perfSONAR toolkit] ************************************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************************************
ok: [<IPv4>]

TASK [Install EPEL RPM] *************************************************************************************************************************************
ok: [<IPv4>]

TASK [Install perfSONAR-repo RPM] ***************************************************************************************************************************
[WARNING]: Module remote_tmp /root/.ansible/tmp did not exist and was created with a mode of 0700, this may cause issues when running as another user. To
avoid this, create the remote_tmp dir with the correct permissions manually
changed: [<IPv4>]

TASK [Install perfSONAR Toolkit bundle] *********************************************************************************************************************

...
```

## Resources

* [How to tell Ansible to use GCP IAP tunneling](https://xebia.com/blog/how-to-tell-ansible-to-use-gcp-iap-tunneling/)
* [GCP IAP Tunnelling on Ansible with Dynamic Inventory](https://www.bionconsulting.com/blog/gcp-iap-tunnelling-on-ansible-with-dynamic-inventory)
* [google.cloud.gcp_compute inventory – Google Cloud Compute Engine inventory source](https://docs.ansible.com/ansible/latest/collections/google/cloud/gcp_compute_inventory.html)