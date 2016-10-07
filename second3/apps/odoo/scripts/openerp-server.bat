@echo off
set PATH=/home/administrator/second3/python/scripts;/home/administrator/second3/python;%PATH%
set PYTHONPATH=/home/administrator/second3/python/Lib/site-packages;/home/administrator/second3/apps/odoo/Lib/site-packages;
/home/administrator/second3/python/python.exe "/home/administrator/second3/apps/odoo/Scripts/openerp-server" %*
            