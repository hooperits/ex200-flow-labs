# Research Notes: 04-users-groups

Analysis of user, group, SGID, and ACL management on RHEL 9 VM.

## User creation commands
Create user with specific properties:
```bash
useradd -s /sbin/nologin -G sysadmin operator1
```

## SGID (Set Group ID) on Directory
Applying SGID causes files created inside `/srv/sysadmin_docs` to automatically inherit the group of the parent directory:
```bash
chmod 2770 /srv/sysadmin_docs
# or
chmod g+s /srv/sysadmin_docs
```

## Sticky Bit on Directory
Prevents users from deleting or renaming files owned by other users in a shared directory (e.g. `/tmp` or common uploads):
```bash
chmod +t /srv/public_uploads
```

## Access Control Lists (ACLs)
Standard permissions only support Owner, Group, and Others. ACLs allow setting permissions for specific users:
- Set: `setfacl -m u:auditor1:rx /srv/sysadmin_docs`
- View: `getfacl /srv/sysadmin_docs`
