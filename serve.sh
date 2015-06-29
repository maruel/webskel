#!/bin/sh
# Copyright 2015 Marc-Antoine Ruel. All rights reserved.
# Use of this source code is governed under the Apache License, Version 2.0
# that can be found in the LICENSE file.

# This script starts a local web server to iterate quickly on the website.

cd "$(dirname $0)"
hugo server --bind=0.0.0.0 -w -b $(hostname)
