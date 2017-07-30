# unifi-video-controller

This docker image runs the unifi-video controller on Ubuntu. Originally intended for Unraid 6.x, it should run fine anywhere.

Set your local data, videos and logs directories in the `docker run` command. You can also specify a custom user and group for the daemon to run as.

The first run should create the file `system.properties` in your data directory. If it doesn't, create it yourself. *You* must add `is_default=true` as the first line in order to force the wizard to run.

Restart the docker, visit http://localhost:7080 or http://<ip.address>:7080/ to start the Unifi Video wizard.

## Run it
```
docker run -d \
        --name unifi-video \
        --cap-add SYS_ADMIN \
        --cap-add DAC_READ_SEARCH \
        --security-opt apparmor:unconfined \
        -p 7443:7443 \
        -p 7445:7445 \
        -p 7446:7446 \
        -p 7447:7447 \
        -p 7080:7080 \
        -p 6666:6666 \
        -v /srv/unifi-video/data:/var/lib/unifi-video \
        -v /srv/unifi-video/videos:/usr/lib/unifi-video/data/videos \
        -v /srv/unifi-video/logs:/var/log/unifi-video \
        -e TZ=Europe/Zurich \
        -e PUID=99 \
        -e PGID=100 \
        unifi-video
```

## tmpfs mount error

```
mount: tmpfs is write-protected, mounting read-only
mount: cannot mount tmpfs read-only
```

If you get this tmpfs mount error, add `--security-opt apparmor:unconfined \` to your list of run options. This error has been seen on Ubuntu, but may occur on other platforms as well.
