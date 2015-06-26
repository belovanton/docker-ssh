Make:

    docker build -t sshd .

Config:

 - SSH_PASSWORD : The root password.
 - SSH_AUTHORIZED_KEY : A key that will be added to the authorized key file of the root user.
 - SSH_PASSWORD_WWW : The www-data user password

Run:

    docker run \
        --name sshd \
        --volumes-from <container_id> \
        -d \
        -e SSH_PASSWORD=<password> \
        -e SSH_AUTHORIZED_KEY="<key>" \
        -p 2222:22 \
        sshd
