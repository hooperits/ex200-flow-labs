# Implementation Plan: 04-users-groups

Detailed design for Module 04 - Users and Groups.

## User Review Required
None. Standard design according to constitution.

## Proposed Changes

### Labs Folder

#### [NEW] [demo.sh](file:///home/juanca/proys/RHCSA-EX200/labs/04-users-groups/demo.sh)
Interactive Bash 5.x tutorial showing:
- User management: `useradd`, `usermod`, `userdel`, `chage`.
- Group management: `groupadd`, `groupdel`.
- Special permissions: SGID (`g+s`), Sticky Bit (`o+t`).
- Access Control Lists (ACLs): `setfacl`, `getfacl`.

#### [NEW] [instructions.md](file:///home/juanca/proys/RHCSA-EX200/labs/04-users-groups/instructions.md)
Detailed guidelines in Spanish for:
1. Creating group `sysadmin`.
2. Creating user `operator1` with secondary group `sysadmin` and a non-login shell (`/sbin/nologin`).
3. Creating a shared directory `/srv/sysadmin_docs`.
4. Configuring ownership of the directory to group `sysadmin`, and applying SGID (`chmod 2770`) so files created inside inherit the group `sysadmin`.
5. Creating user `auditor1`, and granting them read-only access (ACL `r-x`) to `/srv/sysadmin_docs` using `setfacl`.

#### [NEW] [hints.md](file:///home/juanca/proys/RHCSA-EX200/labs/04-users-groups/hints.md)
Pistas for `useradd`, `chmod g+s`, and `setfacl -m u:user:r-x` syntax.

#### [NEW] [verify.sh](file:///home/juanca/proys/RHCSA-EX200/labs/04-users-groups/verify.sh)
Validates:
- Group `sysadmin` exists.
- User `operator1` exists, has secondary group `sysadmin`, and shell `/sbin/nologin`.
- Directory `/srv/sysadmin_docs` exists, belongs to group `sysadmin`, and has SGID (2770).
- User `auditor1` exists and has explicit ACL read-only permission (`r-x` or `r-`) on the directory.

#### [NEW] [reset.sh](file:///home/juanca/proys/RHCSA-EX200/labs/04-users-groups/reset.sh)
Deletes users, groups, and directories created during the lab.

## Verification Plan

### Manual Verification
- Run verify.sh before solving (should fail).
- Solve the challenge and check verify.sh (should pass).
- Check demo.sh duration is at least 3 minutes.
