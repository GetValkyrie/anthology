# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "host" do |host|
    host.vm.box = "hashicorp/precise64"
    host.vm.provision :puppet do |puppet|
      puppet.options = ['--verbose']
    end
    host.vm.provision 'docker' do |docker|
      # This is just a convenient way to install docker on the host.
    end
    # Port-forwarding to the gitlab container
    host.vm.network 'forwarded_port', guest: 10022, host: 11022
    host.vm.network 'forwarded_port', guest: 10080, host: 11080
    # Port-forwarding to the pgsql container
    #host.vm.network 'forwarded_port', guest: 20022, host: 20022
    #host.vm.network 'forwarded_port', guest: 20080, host: 20080
  end

  # Ensure that the Docker provider uses our host maching.
  config.vm.provider "docker" do |d|
    d.vagrant_vagrantfile = './Vagrantfile'
    d.vagrant_machine = 'host'
    d.force_host_vm = true
  end

  config.vm.define "pgsql" do |pgsql|
    pgsql.vm.provider "docker" do |d|
      d.image = "sameersbn/postgresql:latest"
      d.name = 'pgsql'
      #d.ports = ['20022:22', '20080:80']
      d.volumes = ['/opt/postgresql/data:/var/lib/postgresql']
    end
  end

  config.vm.define "gitlab" do |gitlab|
    gitlab.vm.provider 'docker' do |d|
      d.image = 'smerrill/vagrant-ubuntu-puppet'
      d.name = 'gitlab'
      d.volumes = ['/vagrant/gitlab/data:/home/git/data']
      d.ports = ['10022:22', '10080:80']
      d.env = { 'GITLAB_PORT' => '10080', 'GITLAB_SSH_PORT' => '10022' }
      d.has_ssh = true

      # Ensure Vagrant knows the SSH port. See
      # https://github.com/mitchellh/vagrant/issues/3772.
      override.gitlab.ssh.port = 10022
    end
    gitlab.vm.provision :puppet do |puppet|
      puppet.options = ['--verbose']
    end
  end

end
