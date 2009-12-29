#!/bin/sh

instance_dir_base=/opt/ldap/ds6/instances
instance_dirs=`ls -1 $instance_dir_base`
backup_dir=/var/backup/dsee
date=`date +%Y%m%d%H%M%S`

echo "Backing up to $backup_dir/$date"

mkdir $backup_dir/$date

for d in $instance_dirs; do
        echo "Backing up instances in $d."
        instances=`ls -1 $instance_dir_base/$d`

        for i in $instances; do
                echo "Backing up instance $d/$i..."
                mkdir -p $backup_dir/$date/$d
                $instance_dir_base/$d/$i/db2bak $backup_dir/$date/$d/$i
                echo "Done."
        done
done

exit 0
