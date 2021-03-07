#!/usr/bin/env bash

tmp_dir=$(mktemp -d)
config_file=$tmp_dir/webdis.json

cat <<EOF > "$config_file"
  {
   "daemonize" : false,
   "database" : 0,
   "http_host" : "0.0.0.0",
   "verbosity" : 6,
   "logfile" : "/tmp/webdis.log",
   "redis_port" : ${REDIS_PORT:-6379},
   "redis_host" : "${REDIS_HOST:-localhost}",
   "http_port" : ${PORT:-7379},
   "redis_auth" : ["soufiane", "8critique!-4plongée&-1soldaté-5relief'-4touristes(-7coup(-8chaleur§-touche9ç-insomnie3--batterie6+"],
   "websockets" : false,
   "threads" : 5,
   "pool_size" : 20,
   "acl" : [
      {
         "disabled" : [
            "DEBUG"
         ]
      },
      {
        "http_basic_auth" : "user:password"
      }
   ]
}
EOF

exec webdis "$config_file"