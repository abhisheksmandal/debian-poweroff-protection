# Prevent and Revert Poweroff on Debian Server

This guide explains how to **prevent your Debian server from powering off**, even when the `poweroff` command is used, while still allowing `reboot`. It also includes clear steps to **revert the changes** if needed.

---

## 🚫 Prevent Poweroff (While Allowing Reboot)

### 1. Override `poweroff` Command

```bash
sudo mv /sbin/poweroff /sbin/poweroff.bak
sudo ln -s /bin/true /sbin/poweroff
```

---

### 2. Disable `halt` and `shutdown` Commands

```bash
sudo mv /sbin/halt /sbin/halt.bak
sudo ln -s /bin/true /sbin/halt

sudo mv /sbin/shutdown /sbin/shutdown.bak
sudo cp /sbin/shutdown.bak /sbin/shutdown
sudo chmod -x /sbin/shutdown
```

Alternatively, link shutdown to `/bin/true`:

```bash
sudo ln -sf /bin/true /sbin/shutdown
```

---

### 3. Mask systemd Shutdown Targets

```bash
sudo systemctl mask poweroff.target halt.target shutdown.target
```

> This prevents systemd from performing shutdown/halt/poweroff operations.

---

### 4. Allow Reboot

```bash
sudo systemctl unmask reboot.target
```

---

### 5. (Optional) Monitor Poweroff Attempts

You can set up auditd or use aliases/scripts to log unauthorized shutdown attempts. (Not covered in this guide.)

---

## 🔁 Revert Changes (Restore Poweroff Ability)

### 1. Restore Original Binaries

```bash
sudo rm /sbin/poweroff
sudo mv /sbin/poweroff.bak /sbin/poweroff

sudo rm /sbin/halt
sudo mv /sbin/halt.bak /sbin/halt

sudo rm /sbin/shutdown
sudo mv /sbin/shutdown.bak /sbin/shutdown
sudo chmod +x /sbin/shutdown
```

> If no backup exists, reinstall the package:
```bash
sudo apt-get install --reinstall systemd-sysv
```

---

### 2. Unmask systemd Shutdown Targets

```bash
sudo systemctl unmask poweroff.target halt.target shutdown.target
```

---

### 3. (Optional) Re-enable Shutdown for Users

If any policy changes were made (e.g., sudoers or PAM), revert those accordingly.

---

### 4. Test

```bash
sudo poweroff
```

If your server powers off, the changes have been reverted successfully.

---

## ✅ Done

Use this guide carefully, especially on production systems. For automation, consider using an Ansible playbook or a shell script.
