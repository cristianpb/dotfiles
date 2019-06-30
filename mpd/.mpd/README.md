# Music Player Daemon (MPD) server

* Create mpd service file `~/.config/systemd/user/mpd.service`

```
[Unit]
Description=Music Player Daemon
After=network.target sound.target

[Service]
ExecStart=/usr/bin/mpd --no-daemon /home/arch/.mpdconf

[Install]
WantedBy=default.target
```

* enable service `systemctl --user enable mpd.service`
