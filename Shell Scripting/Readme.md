**Utkarsh Raj 24BCS10318**

# System Information Script

A Bash script that gathers essential system metrics (date, hostname, logged-in user, disk usage, running processes), accepts user input via `read -p`, creates directories and files, and redirects process lists using `>`.

---

## Required Commands Covered

* `mkdir` — Directory creation (`mkdir -p`)
* `touch` — File creation
* `echo` — Formatted printing
* `df` — Disk space inspection (`df -h`)
* `ps` — Process listing (`ps aux`)
* `read -p` — Interactive user prompts
* Variables — Storing system info and file paths
* `>` — Standard output redirection into a target file

---

## Usage

```bash
chmod +x sys_info.sh
./sys_info.sh
```

---

## Script Execution Output

![output1](<screenshots/output1.png>)
![output2](<screenshots/output2.png>)

---

## Verification of Output Redirection

Running `head -n 10 sys_logs/processes.txt`:

![redirected output](<screenshots/redirected.png>)