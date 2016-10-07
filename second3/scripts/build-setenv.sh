#!/bin/sh
LDFLAGS="-L/home/administrator/second3/common/lib $LDFLAGS"
export LDFLAGS
CFLAGS="-I/home/administrator/second3/common/include $CFLAGS"
export CFLAGS
		    
PKG_CONFIG_PATH="/home/administrator/second3/common/lib/pkgconfig"
export PKG_CONFIG_PATH
