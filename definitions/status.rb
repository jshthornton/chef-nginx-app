define :nginxsite_enable do
  execute "nxensite #{params[:name]}" do
    command "/usr/sbin/nxensite #{params[:name]}"
    notifies :reload, "service[nginx]", :delayed
    not_if do
      ::File.symlink?("#{node[:nginx][:dir]}/sites-enabled/#{params[:name]}")
    end
  end
end

define :nginxsite_disable do
  execute "nxdissite #{params[:name]}" do
    command "/usr/sbin/nxdissite #{params[:name]}"
    notifies :reload, "service[nginx]", :delayed
    only_if do
      ::File.symlink?("#{node[:nginx][:dir]}/sites-enabled/#{params[:name]}")
    end
  end
end