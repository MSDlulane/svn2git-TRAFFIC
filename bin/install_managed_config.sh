#!/bin/bash
svn co https://cptlsvn01.za.mhgad.com/repos/TRAFFIC
ln -s TRAFFIC/conf/$(hostname) TRAFFIC/etc
/opt/mhg/TRAFFIC/bin/legacy_uninstall.sh
/opt/mhg/TRAFFIC/bin/all_install.sh
