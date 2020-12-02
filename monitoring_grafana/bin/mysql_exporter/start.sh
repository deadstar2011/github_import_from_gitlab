#!/bin/bash
export DATA_SOURCE_NAME="username:password@tcp(ip_mysql:3306)/basename" && ./mysqld_exporter --web.listen-address="localhost:9102" &
