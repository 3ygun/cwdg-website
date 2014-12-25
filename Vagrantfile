# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure('2') do |config|
  config.vm.box      = 'ubuntu/trusty32'

  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.provision :shell, path: 'script/vagrant-bootstrap', keep_color: true

  # Uncomment if you are using Linux
  # config.vm.synced_folder '.', '/vagrant', type: 'rsync'

  # Comment this out if your aren't using OSX
  config.vm.synced_folder ".", "/home/vagrant/cwdg-website"
end
