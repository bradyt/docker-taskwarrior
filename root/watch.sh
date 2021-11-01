cd /root/opt/var/taskd/log
touch taskd.log
ls * | entr -cs 'cat taskd.log'
