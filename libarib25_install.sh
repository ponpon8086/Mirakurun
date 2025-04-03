cp /tmp/libarib25/b25 /usr/local/bin/b25
cp /tmp/libarib25/libarib25.* /usr/local/lib/
rm /usr/local/lib/libarib25.so
rm /usr/local/lib/libarib25.so.0
ln -s /usr/local/lib/libarib25.so.0.2.5 /usr/local/lib/libarib25.so.0
ln -s /usr/local/lib/libarib25.so.0 /usr/local/lib/libarib25.so

mkdir -p /usr/local/include/arib25
cp /tmp/libarib25/*.h /usr/local/include/arib25/
rm -rf /tmp/libarib25
ldconfig

