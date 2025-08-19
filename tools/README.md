# Preparing for pegging a version

## Version hierarchy

## Create branch on Git repos

* Get a list of all repos associated with a packaged docker from the docker packaging file. See [samples](https://github.com/OpenG2P/openg2p-packaging/tree/main/packaging/packages)
* Create a branch on all the repos if the branch does not exist, like `17.0-1.2` for Odoo or `1.2` for non-Odoo
* Change all the versions of Odoo modules as given below. Make sure you put a `develop` suffix to indicate that this is not yet tagged.

## Update Odoo versions

To replace a version of `__manifest.py__` file, use the following command

```sh
find . -name __manifest__.py -exec sed -i "s/\"version\".*/\"version\": \"17.0.1.2.0-develop\",/g" {} \;
```

## Commit in bulk
Refer to `add_commit.sh`

## Tag a specific version
To tag a version,
* Decide on a tag name like `v1.2.0`. When it comes to tagging we DO NOT follow the Odoo convention, but instead just create a tag like `v1.2.0`.
* Create a branch with name without prefix like `1.2.0` on all the repos
* Update the version of all the Odoo modules to reflect the final Odoo module version, like `17.0.1.2.0`.
* Tag all the repos with `v1.2.0`. You may do this on command line or using Releases feature of Github. Although, these version may not be releases, so it may be miscommunication. Hence, suggested to this on command line. If you use Github's releases it appears as a proper release with name etc under Releases, however, if you just tag on command line it appears just as a 'tag' under Releases.

## Update version of docker

## Update version of Helm
