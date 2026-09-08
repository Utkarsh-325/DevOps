# Task 1: Soft Link & Hard Link

## Inode
An inode (index node) is a data structure on a Linux filesystem that stores metadata about a file (permissions, owner, size, timestamp) and pointers to its actual data blocks on disk. The filename is merely an entry in a directory pointing to an inode number.

## Hard Link
A directory entry that points directly to an existing inode. It shares the exact same inode number as the original file.

## Soft Link (Symbolic Link)
A distinct file with its own unique inode. Its data block contains only a text path pointing to the target file.

---

### Core Differences
| Feature | Hard Link | Soft Link |
|---|---|---|
| Inode Number | Identical to Target | Unique/Different |
| Across Filesystems | No | Yes |
| If Target is deleted | Data Persists; Link remains valid | Becomes broken |
| File Size | Reports size of Underlying data | Size equals length of Target path |

---

### Creation & Deletion
![Soft vs Hard Link](<screenshots/Create_Delete.png>)
- We use `ln base.txt hard.txt` to make the hard link.
- We use `ln -s base.txt soft.txt` to make the soft link.
- We can also notice that the inode number is the same for `base.txt` and `hard.txt`; and different for soft link.
- After we delete the main link, we can see that the hard link works and shows an output while the soft link shows an error saying that `No such file or directory`.

---

# Task 2: adduser vs useradd

Both commands create user accounts in Linux, but they operate at very different layers:

- useradd is a low-level system binary native to all Linux distributions.
- adduser is a high-level interactive Perl script built on top of useradd (standard on Debian and Ubuntu).

### Which Command is Preferred on Ubuntu and Why?
- For Manual / Interactive Administration: adduser is preferred.
It enforces best practices out of the box: it prevents creating orphaned users without home directories, assigns standard permissions (750 or 755), prompts for a secure password immediately, and loads user profile dotfiles (.bashrc, .profile) automatically from /etc/skel.

- For Automation, CI/CD, and Scripts: useradd is preferred.
Because adduser is designed to be interactive, it can block non-interactive pipelines. Tools like Dockerfiles, Ansible playbooks, or bash automation scripts use useradd with explicit flags (e.g., useradd -m -s /bin/bash deployer).

---

### Using adduser to create a test user:
![adduser](<screenshots/adduser.png>)
- We start by giving the command to create the user which shows us a output where we need to set a password for the new user and fill the details for it.
- After confirming the details that we filled, a new user is created which in this case is user `utkarsh`.
- We then verified the account creation by checking the user record in /etc/passwd, user ID and group associations.
- We also verified that the home directory exists with populated skeleton files.

---

# Task 3: journalctl
- journalctl is the centralized command-line interface used to query and view logs indexed by systemd-journald.
- Unlike traditional syslog daemons that dump plain text into `/var/log/messages` or `/var/log/syslog`, systemd-journald collects logs from the Linux kernel, system services, standard output (stdout), and standard error (stderr) into a indexed binary format. journalctl is the tool used to query, parse, and filter this binary store.

## Key Advantages
- Single Unified Log Engine: No need to check multiple scattered files in `/var/log/`.
- Structured Metadata: Logs are stored with metadata (PID, Unit name, Timestamp, Priority level).
- Fast Indexing & Filtering: Filter easily by service name, boot session, time window, or severity level without piping through complex grep and awk commands.

## Commands
### 1. Basic Navigation
```bash
# View all logs from oldest to newest (opens in 'less' pager; press 'q' to quit)
journalctl

# View logs in reverse order (newest first)
journalctl -r

# View the last N lines (e.g., 20 lines)
journalctl -n 20
```

### 2. Filtering by Time & Boot
```bash
# View logs from the current boot only
journalctl -b

# View logs from the previous boot (useful for investigating crashes/reboots)
journalctl -b -1

# View logs generated within the last 15 minutes
journalctl --since "15 minutes ago"

# View logs within a specific time window
journalctl --since "2026-09-07 13:00:00" --until "2026-09-07 14:00:00"
```

### 3. Filtering by Severity / Priority
Linux log priority levels range from 0 (emerg) to 7 (debug). Use -p to filter:
```bash
# View all logs marked as 'err' (error) or more critical
journalctl -p err -b
```
(Priorities: emerg (0), alert (1), crit (2), err (3), warning (4), notice (5), info (6), debug (7))

## Checking Service Logs
We us the -u flag. The -u flag filters specifically by a systemd unit name.

### 1. Checking logs for a common background service
- Logs for cron scheduler
![journalctl](<screenshots/journalctl.png>)

### 2. Streaming logs live
- We can use -f (follow) to stream service logs in real time
![journalctl stream](<screenshots/journalctl-stream.png>)

### 3. Combining flags
- In real-world incidents, we usually combine flags to pinpoint errors:
![journalctl combined](<screenshots/journalctl-combined.png>)

