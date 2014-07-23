# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'hashicorp/precise64'

  config.vm.network 'forwarded_port', guest: 10022, host: 10022
  config.vm.network 'forwarded_port', guest: 10080, host: 10080

  config.vm.provision "docker" do |docker|
    docker.pull_images 'sameersbn/gitlab:7.1.0'

    docker.run 'sameersbn/gitlab:7.1.0',
      args: "--name=gitlab -d -p 10022:22 -p 10080:80 -e 'GITLAB_PORT=10080' -e 'GITLAB_SSH_PORT=10022'"
  end
end
