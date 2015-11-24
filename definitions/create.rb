define :nginxsite_create do
  template "#{node[:nginx][:dir]}/sites-available/#{params[:name]}" do
    ::Chef::Log.debug("Generating Nginx site template for #{params[:name].inspect}")
    source params[:template]
    cookbook params[:cookbook]
    owner "root"
    group "root"
    mode 0644
    variables(
      :application_name => params[:name],
      :params => params[:variables]
    )
    if ::File.exists?("#{node[:nginx][:dir]}/sites-enabled/#{params[:name]}")
      notifies :reload, "service[nginx]", :delayed
    end
  end

  if params[:enable] then
    nginxsite_enable params[:name] do
    end
  else
    nginxsite_disable params[:name] do
    end
  end
end