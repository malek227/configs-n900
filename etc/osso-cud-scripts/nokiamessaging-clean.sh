#!/bin/sh                                               
                                                        
logger -p user.debug -t NOKIAMESSAGING -- Executing nokiamessaging-clean.sh
                                                                           
# First we kill intellisyncd to make sure that, when we remove             
# all the data, intellisyncd won't write again                             
logger -p user.debug -t NOKIAMESSAGING -- Stopping nokiamessaging
initctl stop nokiamessaging
PIDS=`pidof intellisyncd` && kill -15 $PIDS                                
                                                                           
# Removing intellisyncd user data folder                                   
logger -p user.debug -t NOKIAMESSAGING -- Removing Intellisync data folder
rm -rf /home/user/.intellisyncd                                              
                                                                             
exit 0
