#!/usr/bin/expect

set user jira-gitlab
set password rmfkdnsem#4

spawn su - "$user"
expect "Password:"
send "$password\r";

interact
