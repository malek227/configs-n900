#!/bin/bash

if [ -f "/home/user/.user-ringtone" ] ; then
rm -rf `cat /home/user/.user-ringtone`
fi

if [ -f "/home/user/.user-smstone" ] ; then
rm -rf `cat /home/user/.user-smstone`
fi

if [ -f "/home/user/.user-imtone" ] ; then
rm -rf `cat /home/user/.user-imtone`
fi

if [ -f "/home/user/.user-emailtone" ] ; then
rm -rf `cat /home/user/.user-emailtone`
fi

rm -rf /home/user/.user-ringtone
rm -rf /home/user/.user-smstone
rm -rf /home/user/.user-imtone
rm -rf /home/user/.user-emailtone

