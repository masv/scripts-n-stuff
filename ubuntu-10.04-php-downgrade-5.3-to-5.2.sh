#!/bin/bash

# Find installed PHP packages
php_installed=`dpkg -l | grep php| awk '{print $2}' |tr "\n" " "`

# Remove installed PHP packages
sudo aptitude purge $php_installed

# Use Karmic sources for PHP packages
# pin-params:  a (archive), c (components), v (version), o (origin) and l (label).
echo "Package: php5\nPin: release a=karmic\nPin-Priority: 991\n"  | sudo tee /etc/apt/preferences.d/php > /dev/null
apt-cache search php5-|grep php5-|awk '{print "Package:", $1,"\nPin: release a=karmic\nPin-Priority: 991\n"}'|sudo tee -a /etc/apt/preferences.d/php > /dev/null
apt-cache search -n libapache2-mod-php5 |awk '{print "Package:", $1,"\nPin: release a=karmic\nPin-Priority: 991\n"}'| sudo tee -a /etc/apt/preferences.d/php > /dev/null
echo "Package: php-pear\nPin: release a=karmic\nPin-Priority: 991\n"  | sudo tee -a /etc/apt/preferences.d/php > /dev/null

# Add Karmic apt sources
egrep '(main restricted|universe|multiverse)' /etc/apt/sources.list|grep -v "#"| sed s/lucid/karmic/g | sudo tee /etc/apt/sources.list.d/karmic.list > /dev/null

# update package database (use apt-get if aptitude crash)
sudo apt-get update

# Reinstall PHP packages
sudo apt-get install $php_installed

sudo aptitude hold `dpkg -l | grep php5| awk '{print $2}' |tr "\n" " "`
#done

