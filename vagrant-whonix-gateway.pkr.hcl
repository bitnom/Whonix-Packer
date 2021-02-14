variable "do_api_token" {
    type    = string
    default = "${env("DO_API_TOKEN")}"
}


source "digitalocean" "vagrant-whonix-gateway" {
    api_token    = "${var.do_api_token}"
    image        = "debian-10-x64"
    region       = "nyc3"
    size         = "s-1vcpu-1gb"
    ssh_username = "root"
}

# a build block invokes sources and runs provisioning steps on them.

build {
    sources = ["source.digitalocean.vagrant-whonix-gateway"]
    
    provisioner "file" {
        destination = "/root/torrc.sh"
        source      = "./torrc.sh"
    }
    provisioner "file" {
        destination = "/root/build.sh"
        source      = "./build.sh"
    }
    provisioner "shell" {
        inline = [
            "DEBIAN_FRONTEND=noninteractive",
            "sudo apt-get update",
            "DEBIAN_FRONTEND=noninteractive; echo \"no\n\" | apt-get install -y apt-cacher-ng",
            "sudo apt-get install -y gnupg2 sudo git apt-utils wget time curl lsb-release fakeroot dpkg-dev procps",
            "apt-get install -y adduser",
            "wget https://www.whonix.org/patrick.asc -O ~/patrick.asc",
            "gpg --import ~/patrick.asc",
            "gpg --keyid-format long --import --import-options show-only --with-fingerprint ~/patrick.asc",
            "sudo apt-key --keyring /etc/apt/trusted.gpg.d/whonix.gpg add ~/patrick.asc",
            "echo \"deb http://deb.whonix.org buster main\" | tee /etc/apt/sources.list.d/whonix.list",
            "apt-get update && apt-get upgrade -y",
            "apt-get install -y genmkfile",
            "adduser --quiet --disabled-password --home /home/user --gecos 'user,,,,' user",
            "echo \"user:changeme\" | chpasswd",
            "addgroup user sudo",
            "apt-get install -y net-tools tor",
            "sh ~/torrc.sh",
            "pkill tor",
            "tor 2>&1 &",
            "sleep 5",
            "apt-get update && apt-get dist-upgrade -y",
            "chmod +x /root/build.sh",
            "reboot"
        ]
    }
    provisioner "shell2" {
        script = "sh /root/build.sh"
        pause_before = "30s"
    }


    post-processor "vagrant" {}
}