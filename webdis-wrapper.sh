#!/usr/bin/env bash

tmp_dir=$(mktemp -d)
config_file=$tmp_dir/webdis.json

cat <<EOF > "$config_file"
  {
   "redis_auth" : "test:test",
   "acl" : [
        {
            "disabled":    ["BGREWRITEAOF",
                     "BGSAVE",
                     "CLIENT",
                     "COMMAND",
                     "CONFIG",
                     "DBSIZE",
                     "DEBUG",
                     "FLUSHALL",
                     "FLUSHDB",
                     "INFO",
                     "MONITOR",
                     "ROLE",
                     "SAVE",
                     "SHUTDOWN",
                     "SLAVEOF",
                     "SLOWLOG",
                     "SYNC",
                     "CLUSTER"]
        },

        {
            "http_basic_auth":    "user:password",
            "enabled":        []
        }
    ],
   "daemonize" : false,
   "database" : 0,
   "http_host" : "0.0.0.0",
   "verbosity" : 6,
   "logfile" : "/tmp/webdis.log",
   "redis_port" : ${REDIS_PORT:-6379},
   "redis_host" : "${REDIS_HOST:-localhost}",
   "http_port" : ${PORT:-7379},
   "websockets" : false,
   "threads" : 5,
   "pool_size" : 20
}
EOF

exec webdis "$config_file"