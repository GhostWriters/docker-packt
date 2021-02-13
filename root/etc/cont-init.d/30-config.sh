#!/usr/bin/with-contenv bash
# shellcheck shell=bash

CFG=/config/configFile.cfg

# If environment arguments have been provided, switch the values in the sample config to these

if [ -n "$PACKT_EMAIL" ]; then
	echo 'ENV PACKT_EMAIL provided'
	sed -i s/email=.*/email="$PACKT_EMAIL"/ $CFG
else
	echo 'ENV PACKTEMAIL not set'
fi

if [ -n "$PACKT_PASSWORD" ]; then
	echo 'ENV PACKT_PASSWORD provided'
	sed -i s/password=.*/password="$PACKT_PASSWORD"/ $CFG
else
	echo 'ENV PACKTEMAIL not set'
fi

if [ -n "$PACKT_DOWNLOAD_FORMATS" ]; then
	echo "ENV PACKT_DOWNLOAD_FORMATS provided as '$PACKT_DOWNLOAD_FORMATS'"
	sed -i s/download_formats:.*/download_formats:\ "$PACKT_DOWNLOAD_FORMATS"/ $CFG
else
	echo 'ENV PACKT_DOWNLOAD_FORMATS not set'
fi

if [ -n "$PACKT_DOWNLOAD_BOOK_TITLES" ]; then
	echo "ENV PACKT_DOWNLOAD_BOOK_TITLES provided as '$PACKT_DOWNLOAD_BOOK_TITLES'"
	sed -i s/download_book_titles:.*/download_book_titles:\ "$PACKT_DOWNLOAD_BOOK_TITLES"/ $CFG
else
	echo 'ENV PACKT_DOWNLOAD_BOOK_TITLES not set'
	sed -i s/download_book_titles:.*/download_book_titles:/ $CFG
fi

if [ -n "$PACKT_ANTICAPTCHA_KEY" ]; then
	echo 'ENV PACKT_ANTICAPTCHA_Key provided'
	sed -i s/key:.*/key:\ "$PACKT_ANTICAPTCHA_KEY"/ $CFG
else
	echo 'ENV PACKT_ANTICAPTCHA_KEY not set'
fi

echo 'Replacing path with /data'
sed -i s@download_folder_path:.*@download_folder_path:\ \\/data@ $CFG

echo 'Set logfile path to /data'
sed -i s@ebook_extra_info_log_file_path:.*@ebook_extra_info_log_file_path:\ \\/data\\/eBookMetadata.log@ $CFG

# Copy crontab default if needed
if [ ! -f /config/crontabs/root ]; then
	echo 'Crontabs root file not found so creating the default'
	cp /etc/crontabs/root /config/crontabs/
else
	echo 'Crontabs root file not found'
fi

# Import user crontabs
echo 'Import user crontabs'
rm /etc/crontabs/*
cp /config/crontabs/* /etc/crontabs/

# Permissions
chown -R abc:abc /config

echo 'Start crond'
crond -f
