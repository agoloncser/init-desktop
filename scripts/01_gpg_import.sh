#!/bin/sh
while read line ; do
    curl -sSL $line | gpg --import -
  done <<EOF
    https://gist.githubusercontent.com/agoloncser/6c5219584ee53d7707c9829e0dda2f13/raw/f399041965c7bb4ce5407c98d69d0c2df03fbe0c/0x0C6236A7C7DFBA55-pub.asc
    https://gist.githubusercontent.com/agoloncser/1beeee7c1e4350180c6c14bfa345511d/raw/1bdb310d68987e237f671cff4d4a4c087ffbb93a/0xC2A886213D0258BC-pub.asc
    https://gist.githubusercontent.com/agoloncser/269a43332abb0304d0d87adf011fc2f6/raw/048087e4ae0e4aaf087dac5ec0a5c8036f61817d/0x46F0076ADF5B3ED2-pub.asc
    https://gist.githubusercontent.com/agoloncser/0107175877a5ce4abdd4fd3ef0bc8b9c/raw/036d41126a35c5e1a41cdcb1015ab8034400c584/0x6E32075ADEC66B59-pub.asc
EOF
