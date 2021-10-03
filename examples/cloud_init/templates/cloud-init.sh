#cloud-config
hostname: ${hostname}
ssh_pwauth: True
users:
  - name: root
    lock_passwd: false
    hashed_passwd: '$1$SaltSalt$YhgRYajLPrYevs14poKBQ0'
  - name: ${user_name}
    shell: '/bin/bash'
    ssh-authorized-keys:
     - '${ssh_user_public_key}'
    sudo: ALL=(ALL) NOPASSWD:ALL
growpart:
  mode: auto
  devices: ['/']
write_files:
  - content: |
      #!/bin/bash
      set -e
      mkdir -p /var/tmp/hostname_script
      exec &> /var/tmp/hostname_script/output.log
      current=$(hostname)
      echo "Current hostname is $${current}"
      if [ "${hostname}" != "$${current}" ]; then
        echo "Hostnames do not match"
        if command -v hostnamectl > /dev/null; then
          echo "setting hostname to ${hostname}"
          hostnamectl set-hostname ${hostname}
        fi
      fi
    path: /usr/local/bin/set_hostname
    permissions: '0755'
  - content: |
      #!/bin/bash
      set -x
      exec &> /tmp/cloud-init.log
      apt-get update
      apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
      add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
      apt-get update
      apt-get install -y docker-ce docker-ce-cli containerd.io
      usermod -a -G docker ${user_name}
      sleep 10
      docker run --name postgres-test -e POSTGRES_PASSWORD=mysecretpassword -d postgres:latest
    path: /usr/local/bin/setup_docker
    permissions: '0755'
runcmd:
  - /usr/local/bin/set_hostname
  - /usr/local/bin/setup_docker
  - ["touch", "/tmp/finished"]
  - ["chown", "${user_name}:${user_name}", "/tmp/finished"]
