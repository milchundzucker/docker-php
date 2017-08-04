# Docker Image: milchundzucker/php-essentials 
[![Docker Stars](https://img.shields.io/docker/stars/milchundzucker/php-essentials.svg)](https://hub.docker.com/r/milchundzucker/php-essentials/) [![Docker Pulls](https://img.shields.io/docker/pulls/milchundzucker/php-essentials.svg)](https://hub.docker.com/r/milchundzucker/php-essentials/) [![Docker Automated buil](https://img.shields.io/docker/automated/milchundzucker/php-essentials.svg)](https://hub.docker.com/r/milchundzucker/php-essentials/)

This is one of our docker images we use to build our software with GitLab CI (_Jenkins TBA_). It comes with some pre-installed 
tools, libraries, php-extensions and modified configurations.

## How to use this image

There are two things you should know upfront:

1. This image was build with **xdebug** but turned it off by default to speed up composer. If you need xdebug 
(i.e. code coverage with phpunit). You have to call `xdebug on` (and `xdebug off` to deactivate it again) before you run
something which relies on xdebug.
2. This image was also build with the **uopz** PHP extension, which is also turned off by default. If you need uopz
(i.e. swizzling code to ease up testing PHP functions such as `header()`), you have to call `uopz on` (and `uopz off` to deactivate
it again before you can run something which relies on uopz.

### On your Desktop
To run this image on your desktop and get a shell inside the container, you can run the following:

```shell
docker run --rm -it milchundzucker/php-essentials:5.6 bash
```

### Example: GitLab CI
A common task is to run phpunit tests with code coverage:

```yaml
job_name:
  image: milchundzucker/php-essentials:5.6
  script:
    - composer install
    - xdebug on
    - phpunit
  tags:
    - docker
```

## What's installed?
* composer
* Phing
* PHP Extensions
  * bz2
  * intl
  * opcache
  * pdo_mysql
  * soap
  * ssh2
* VCS Tools
  * git
  * subversion
* Shims to (de)activate xdebug and uopz
* rsync and ssh
* modified SSH client config to accept every host key for `*.milchundzucker.de`

## Gotchas
* 7.2-rc does not come with xdebug, since it's not yet compatible
