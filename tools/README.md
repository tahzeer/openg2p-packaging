# Preparing for pegging a version

* Get a list of all repos associated with a packaged docker from the docker packaging file. See [samples](https://github.com/OpenG2P/openg2p-packaging/tree/main/packaging/packages)
* Create a branch on all the repos if the branch does not exist, like `17.0-1.2` for Odoo or `1.2` for non-Odoo
* Change all the versions of Odoo modules as given below. Make sure you put a `develop` suffix to indicate that this is not yet tagged.

## Version

To replace a version of `__manifest.py__` file, use the following command

```sh
find . -name __manifest__.py -exec sed -i "s/\"version\".*/\"version\": \"17.0.1.2.0-develop\",/g" {} \;
```

## Commit in bulk
Refer to `add_commit.sh`
