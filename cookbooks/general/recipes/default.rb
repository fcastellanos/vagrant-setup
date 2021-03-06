#
# Cookbook Name:: general
# Recipe:: default
#

script "Update ubuntu packages" do
  interpreter "bash"
  user "root"
  code <<-EOH
    apt-get update
    updatedb
  EOH
end

script "Fixing the 'Please check that your locale settings' error" do
  interpreter "bash"
  user "root"
  code <<-EOH
    if cat /etc/bash.bashrc | grep 'LC_ALL' > /dev/null; then
      echo 'Lang fix ready at /etc/bash.bashrc'
    else
      echo ''                                 >> /etc/bash.bashrc;
      echo '# Set en_US as default LOCALE'    >> /etc/bash.bashrc;
      echo 'export LANGUAGE=en_US.UTF-8'      >> /etc/bash.bashrc;
      echo 'export LANG=en_US.UTF-8'          >> /etc/bash.bashrc;
      echo 'export LC_ALL=en_US.UTF-8'        >> /etc/bash.bashrc;

      locale-gen en_US.UTF-8
      dpkg-reconfigure locales
    fi
  EOH
end
