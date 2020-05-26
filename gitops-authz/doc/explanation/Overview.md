# TL;DR

An overview of the structure of the gitops-authz repo.

## Intro

This repo works hand in hand with cloud-automation to manage the `ssh/authorized_keys` files on our VM's.

## How it works

Each VM runs a cronjob that invokes `gen3 gitops-authz apply $PROFILE` where the profile corresponds to one of the metadata files under the `machines/` folder.
The profile metadata specifies which users and groups that should have ssh access to different accounts (under the `/home/` folder) on the machine.  The `gitops-authz` script applies the first block under the profile's `authorized-keys` that matches a particular account.

For example, the following machine profile specifies that the devops group has access to `/home/ubuntu/` and `/home/devplanetv1/`, devops and qa groups can access `/home/qaplanetv1/`, etc.  


```
{
  "name": "cdistest",
  "description": "dev/qa admin vm",
  "authorized-keys": [
    {
      "pattern": "/home/ubuntu/",
      "groups": ["devops"],
      "users": []
    },
    {
      "pattern": "/home/devplanetv1/",
      "groups": ["devops"],
      "users": []
    },
    {
      "pattern": "/home/qaplanetv1/",
      "groups": ["devops", "qa"],
      "users": []
    },
    {
      "pattern": "/home/jenkins",
      "groups": ["devops", "qa"],
      "users": []
    },
    {
      "pattern": "/home/",
      "groups": ["devops", "devs", "qa"],
      "users": []
    }
  ]
}
```

## Ideas

* Too many commons/admin vm's to manage manually.
* Chef scripts and configuration.
* Gen3 workspace terraform tracking?
