#!/bin/bash

version=17.0.1.2.0

find . -name __manifest__.py -exec sed -i "s/\"version\".*/\"version\": \"${version}\",/g" {} \;

