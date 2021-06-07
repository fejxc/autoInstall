#! /bin/bash
tar --xvf Python-3.8.10.tar -C /opt/python
cd /opt/python/Python-3.8.10
./configure --prefix=/opt/python3
make && make install