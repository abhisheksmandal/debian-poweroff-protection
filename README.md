# 🛡️ Debian Poweroff Protection

This repository provides Ansible playbooks and shell scripts to prevent a Debian-based server from being shut down via commands like `poweroff`, `halt`, or `shutdown`. Rebooting is still allowed.

This is useful for production servers, critical infrastructure, or kiosks where unintended shutdowns must be avoided.

---

## 📁 Contents

| File                   | Description                                            |
| ---------------------- | ------------------------------------------------------ |
| `prevent_poweroff.yml` | Ansible playbook to disable shutdown/poweroff commands |
| `revert_poweroff.yml`  | Ansible playbook to restore original shutdown behavior |
| `hosts.ini`            | Inventory file for localhost Ansible execution         |
| `prevent_poweroff.sh`  | Shell script equivalent of `prevent_poweroff.yml`      |
| `revert_poweroff.sh`   | Shell script to undo changes                           |

---

## ⚙️ Requirements

- Debian-based system (e.g., Debian, Ubuntu)
- `ansible` installed (for playbooks)
- `sudo` privileges

Install Ansible if not already installed:

```bash
sudo apt update
sudo apt install ansible -y
```

---

## 🚀 Usage

### ▶️ Prevent Poweroff (Ansible)

```bash
ansible-playbook -i hosts.ini prevent_poweroff.yml
```

Or without an inventory file:

```bash
ansible-playbook prevent_poweroff.yml -i localhost, --connection=local
```

### 🔁 Revert Poweroff Changes (Ansible)

```bash
ansible-playbook -i hosts.ini revert_poweroff.yml
```

---

## 🖥️ Shell Script Usage

### Prevent Poweroff

```bash
chmod +x prevent_poweroff.sh
sudo ./prevent_poweroff.sh
```

### Revert Poweroff

```bash
chmod +x revert_poweroff.sh
sudo ./revert_poweroff.sh
```

---

## 🔐 What This Does

- Replaces `/sbin/poweroff` and `/sbin/halt` with symlinks to `/bin/true`
- Disables executable permissions on `/sbin/shutdown`
- Masks systemd targets:
  - `poweroff.target`
  - `halt.target`
  - `shutdown.target`
- Keeps `reboot.target` unmasked

---

## 💡 Use Cases

- Prevent accidental or unauthorized shutdown
- Secure cloud or VPS instances
- Protect servers running critical tasks (e.g., file servers, kiosk mode systems)

---

## 🧹 Reversible

All changes can be cleanly rolled back using the provided `revert` playbook or script.

---

## 🛑 Disclaimer

Use responsibly. While this protects against common shutdown commands, it does not prevent hardware-level or physical power disconnections.
