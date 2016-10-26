# !/bin/bash
# Runs every 5 minutes via cron
# Under Ubuntu 16.04; uses the "powerpanel" package for CyberPower UPSs
# https://www.cyberpowersystems.com/products/software/pppe-linux-software
# Checks the status output for "utility voltage" from a UPS attached via USB
# If the utility voltage is 0, it connects via ssh to the vSphere host vhost1 and shuts it down

export UTILITY_VOLTAGE=$(/usr/sbin/pwrstat -status | grep 'Utility Voltage' | awk {'print $3'})

if [ $UTILITY_VOLTAGE == '0' ]; then
        /usr/bin/ssh -i /home/mitchf/.ssh/id_rsa root@vhost1 '/sbin/shutdown.sh; /sbin/poweroff';
        echo 'Shutting down vhost1' >> /var/log/pwrstatd.log
fi
