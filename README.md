# ligo/software-shell

This container is intended for use as a lightweight virtual machine that
replicates a LIGO software environment on all operating systems. It includes
a default user (albert) and command-line environment.

## Running on MacOS
The following command will ensure that user home directories are mounted in
such a way that the albert user has the same level of access as your account.
```
docker run -d -it --restart=unless-stopped -v /Users:/Users ligo-software-shell
```
