# Password management

## Initiate gpg-agent

* Import gpg keys

```
gpg --import XX.gpg
gpg --import XX.asc
```

* Copy conf

```
cp ~/.dotfiles/gpg-agent.conf .gnupg/gpg-agent.conf
```

* Trust key

```
gpg --edit-key B212E65B trust quit
```

## pass

*pass* is a simple password manager from the command line based on GPG. You can 
initiate using

```
pass init B212E65B
```

Create a password for your email account(s):

```bash
$ pass insert Mail/account
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
systemctl --user status offlineimap.timer
journalctl -f
```

links: https://babushk.in/posts/offlineimap-systemd.html
