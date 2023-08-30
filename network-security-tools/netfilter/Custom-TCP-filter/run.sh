#!/bin/bash

sudo kill 9 `ps -aux | grep rate_limiter | awk '{print $2}'`
make clean
make
sudo ./rate_limiter
