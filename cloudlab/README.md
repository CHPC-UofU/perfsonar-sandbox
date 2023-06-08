# CloudLab Profile: perfsonar_sandbox

> **_NOTE:_** If you are new to CloudLab, it is highly recommended that you read through [CloudLab manual: Getting Started](http://docs.cloudlab.us/getting-started.html) before proceeding.

This repository contains:
1. A CloudLab experiment profile `perfsonar_sandbox` for experimenting with perfSONAR.
1. An associated Ansible playbook in this directory used to provision a perfSONAR experiment based on this profile.

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

## Develop the `perfsonar_sandbox` CloudLab Profile

The CloudLab profile is defined in `<repo root>/profile.py` using the `geni-lib` Pip package. Further details on authoring the profile can be found in [CloudLab manual: Describing a profile with python and geni-lib](http://docs.cloudlab.us/geni-lib.html).

## Run the Playbook

1. Create an experiment on CloudLab using this profile (`perfsonar_sandbox`).
1. Copy `./inventory/hosts.tmpl` to `./inventory/hosts`.
1. Replace the placeholder variables with actual values.
1. Test connecting to the experiment.
   ```shell
   (venv) $ ansible all -m ping
   aaaa.bbbb.cloudlab.us | SUCCESS => {
    "changed": false,
    "ping": "pong"
   }
   ...
   ```
1. Play the ansible.
   ```shell
   (venv) $ ansible-playbook playbook.yml

   PLAY [perfSONAR Archive]***************
   
   TASK [Gathering Facts]***************
   ok: [aaaa.bbbb.cloudlab.us]
   ...
   ```

## Resources

* [CloudLab homepage](https://www.cloudlab.us/)
* [CloudLab manual](http://docs.cloudlab.us/)
