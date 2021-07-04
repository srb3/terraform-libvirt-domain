#cloud-config
hostname: ${hostname}
ssh_pwauth: True
users:
  - name: root
    lock_passwd: false
    hashed_passwd: '$1$SaltSalt$YhgRYajLPrYevs14poKBQ0'
  - name: ${user}
    shell: '/bin/bash'
    ssh-authorized-keys:
     - '${ssh_public_key}'
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
      apt-get update
      apt-get install -y apt-transport-https \
      ca-certificates curl gnupg-agent \
      software-properties-common
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
      add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable"
      apt-get update
      apt-get install -y docker-ce docker-ce-cli containerd.io
      sleep 10
      docker run -d centos:latest
    path: /usr/local/bin/set_hostname
    permissions: '0755'
runcmd:
  - [ touch, /root/metest ]
  - /usr/local/bin/set_hostname

