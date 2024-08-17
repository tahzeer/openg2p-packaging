## Version

To replace a version of `__manifest.py__` file, use the following command

```sh
find . -name __manifest__.py -exec sed -i "s/\"version\".*/\"version\": \"17.0.1.2.0-develop\",/g" {} \;
```
