[![Docker pulls](https://img.shields.io/docker/pulls/nazarpc/phpmyadmin.svg?label=Docker pulls)](https://registry.hub.docker.com/u/nazarpc/phpmyadmin/)
[![Docker stars](https://img.shields.io/docker/stars/nazarpc/phpmyadmin.svg?label=Docker stars)](https://registry.hub.docker.com/u/nazarpc/phpmyadmin/)

# phpMyAdmin as Docker container
This container may be used with MySQL or MariaDB linked containers.

#How to use
With MySQL:
```bash
docker run --name mysql -e MYSQL_ROOT_PASSWORD=my_password -d mysql
docker run --rm --link mysql:mysql -p 1234:80 nazarpc/phpmyadmin
```

With MariaDB:
```bash
docker run --name mariadb -e MYSQL_ROOT_PASSWORD=my_password -d mariadb
docker run --rm --link mariadb:mysql -p 1234:80 nazarpc/phpmyadmin
```
(internally it should be called `mysql` anyway)

After these commands you'll be able to access phpMyAdmin via `http://localhost:1234`, press `Ctrl+C` to stop container, and it will be removed automatically (because of `--rm` option). Feel free to change `1234` to any port you like.

# Difference from other similar containers with phpMyAdmin
This container is much simpler, it doesn't use any custom base, just official PHP 5.6 container with built-in Apache2 web server.

Also this container generates `blowfish_secret` configuration option (unique for each container instance, you don't have to rebuild it yourself), so that you will automatically use cookie sessions (for your convenience).

Plus, I'll try to keep it up to date with new releases of phpMyAdmin and PHP (feel free to ping me if I miss some release), so, by using `nazarpc/phpmyadmin` image you'll always have latest versions of both of them.

#Questions?
Open an issue and ask your question there:)

#License
Public Domain
