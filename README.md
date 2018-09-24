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
  image: milchundzucker/php-essentials:7.2
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
* VCS Tools
  * git
  * subversion
* Shims to (de)activate xdebug and uopz
* rsync and ssh
* trusted milchundzucker CA certificates
* modified SSH client config to accept every host key for `*.milchundzucker.de`

### PHP extensions

| Extension | PHP Version constraints                                               |
| --------- | --------------------------------------------------------------------- |
| bz2       | none                                                                  |
| gmp       | none                                                                  |
| intl      | none                                                                  |
| mcrypt    | ![PHP <= 7.1](https://img.shields.io/badge/PHP-%3C%3D%207.1-blue.svg) |
| opcache   | none                                                                  |
| pdo_mysql | none                                                                  |
| soap      | none                                                                  |
| sockets   | none                                                                  |
| sodium1   | ![PHP <= 5.6](https://img.shields.io/badge/PHP-%3C%3D%205.6-blue.svg) |
| sodium2   | ![PHP >= 7.0](https://img.shields.io/badge/PHP-%3E%3D7.0-blue.svg)    |
| ssh2      | ![PHP >= 7.2](https://img.shields.io/badge/PHP-%3E%3D7.0-blue.svg)    |
| uopz      | ![PHP >= 7.2](https://img.shields.io/badge/PHP-%3E%3D7.0-blue.svg)    |
| zip       | none                                                                  |
| xdebug    | none                                                                  |

## Gotchas
* 5.4, 5.5 & 5.6 come with old sodium (1.0.x) PECL extension which differs from 2.x significantly
* 5.4 comes with outdated xdebug 2.2.7, since it's end of life
* up to 7.1 mcrypt is included, from 7.2 onward it isn't part of the image anymore (since it was deprecated in 7.0 and removed in 7.2)
* uopz and ssh2 PECL extensions aren't ready for PHP 7.3 RC yet
