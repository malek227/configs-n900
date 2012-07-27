#!/bin/sh
rm -rf $HOME/.osso_rss_feed_reader
mkdir $HOME/.osso_rss_feed_reader
mkdir -p $HOME/.osso_rss_feed_reader/cache/favicons
mkdir -p $HOME/.osso_rss_feed_reader/cache/feeds
cp /usr/share/pre-installed/osso_rss_feed_reader/rootdir/* $HOME/.osso_rss_feed_reader/
cp /usr/share/pre-installed/osso_rss_feed_reader/favicons/* $HOME/.osso_rss_feed_reader/cache/favicons/
cp /usr/share/pre-installed/osso_rss_feed_reader/feeds/* $HOME/.osso_rss_feed_reader/cache/feeds/
chown -R user:users $HOME/.osso_rss_feed_reader
