# Data Model and Test Scenarios: 04-users-groups

Layout of test inputs and outputs.

## Group
- Name: `sysadmin`

## Users
- User 1: `operator1` (group: `sysadmin`, shell: `/sbin/nologin`)
- User 2: `auditor1`

## Shared Directory
- Path: `/srv/sysadmin_docs`
- Permissions: `2770` (drwxrws---)
- Owner: `root`
- Group: `sysadmin`
- ACL: `user:auditor1:r-x`
