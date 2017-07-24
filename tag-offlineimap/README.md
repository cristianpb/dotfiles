# Password management

* *pass* is a simple password manager from the command line based on GPG.

First create a password for your email account(s):

```bash
$ pass insert Mail/account
```

Now create a python function that will decrypt the password:

```python
# ~/.offlineimap.py

#! /usr/bin/env python2
from subprocess import check_output


def get_pass(account):
    return check_output("pass Mail/" + account, shell=True).splitlines()[0]
```

This is an example for a multi-account setup. You can customize the argument to pass as defined previously.

Load this file from ~/.offlineimaprc and specify the defined function:

```bash
# ~/.offlineimaprc

[general]
# Path to file with arbitrary Python code to be loaded
pythonfile = ~/.offlineimap.py
...

[Repository Gmail]
# Decrypt and read the encrypted password
remotepasseval = get_pass("Gmail")
...
```

# Configure daemon

> Periodic synchronization with systemd

I’ve encountered problems trying to run OfflineIMAP continuously as a daemon. It would often freeze and not synchronize mail for hours. The most common solution to this is to start OfflineIMAP periodically with cron and only let it synchronize once on each run.

This is what I had been doing for over a year, until I’ve recently switched to the following systemd-based solution: I run systemd with the --user switch inside my user session, allowing me to configure services (like OfflineIMAP) very conveniently. Creating the following unit file in ~/.config/systemd/user allows you to start a single synchronization.

```
# checkmail.service

[Unit]
Description=check mail
RefuseManualStart=no
RefuseManualStop=yes

[Service]
Type=oneshot
ExecStart=/home/arch/.dotfiles/checkmail.sh
```

Additionally, a second .timer unit is needed to run the service every 10 minutes:

```
# checkmail.timer

[Unit]
Description=Check Mail every fifteen minutes
RefuseManualStart=no
RefuseManualStop=no

[Timer]
Persistent=false
OnBootSec= 5min
OnUnitActiveSec= 10min
Unit=checkmail.service

[Install]
WantedBy=default.target
```

You can now enable mail synchronization by executing

```
systemctl --user enable offlineimap.timer
```

See if OfflineIMAP is working correctly by following the journal:

```
journalctl -f
```

links: https://babushk.in/posts/offlineimap-systemd.html
