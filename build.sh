#! /bin/bash

readonly NAME=aide-watch
readonly VERSION=0.4

if ! [ -f aide-watch ]; then
    echo "No aide-watch -- wrong directory?" 1>&2
    exit 1
fi

/bin/rm -rf ./tree
/bin/mkdir -p tree/usr/local/share/aide-watch tree/usr/local/bin tree/var/db/aide-watch
/usr/bin/install -m 0555 aide-watch      tree/usr/local/bin/aide-watch
/usr/bin/install -m 0444 aide-watch.cron tree/usr/local/share/aide-watch/aide-watch.cron
/usr/bin/install -m 0644 ssh_config      tree/var/db/aide-watch/ssh_config

fpm -s dir -t rpm -C tree -f                                                                      \
    --name $NAME                                                                                  \
    --version $VERSION                                                                            \
    --iteration 1                                                                                 \
    --architecture all                                                                            \
    --license BSE                                                                                 \
    --category 'Security Tools'                                                                   \
    --depends bash                                                                                \
    --depends 'aide >= 0.15'                                                                      \
    --depends 'mailx >= 12.4-7'                                                                   \
    --provides "${NAME} = ${VERSION}"                                                             \
    --rpm-autoreqprov                                                                             \
    --directories /var/db/aide-watch                                                              \
    --directories /usr/local/share/aide-watch                                                     \
    --config-files /var/db/aide-watch/ssh_config                                                  \
    --description 'The aide-watch package provides a script to fetch a remote aide DB and locally
compare to the previous DB.  Transfer is via ssh and controlled by keys.'                         \
.
