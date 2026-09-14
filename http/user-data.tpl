#cloud-config
autoinstall:
  version: 1
  identity:
    hostname: multiflora
    username: __USER__
    password: "__PASS_HASH__"
  ssh:
    install-server: true
    allow-pw: true
  storage:
    layout:
      name: lvm
  packages:
    - qemu-guest-agent
    - openssh-server
  late-commands:
    - 'echo "__USER__ ALL=(ALL) NOPASSWD:ALL" > /target/etc/sudoers.d/90-__USER__'
    - 'chmod 0440 /target/etc/sudoers.d/90-__USER__'
    - 'curtin in-target -- systemctl enable qemu-guest-agent'
    - 'curtin in-target -- systemctl enable ssh'