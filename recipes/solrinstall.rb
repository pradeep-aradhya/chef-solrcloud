#
# Cookbook Name:: solr-cloud
# Recipe:: solrinstall
#
# Copyright 2015, Pradeep Aradhya.
#
# All rights reserved - Do Not Redistribute
#

solrlnxclient = node[:solr_cloud]

[solrlnxclient[:loc], solrlnxclient[:home_dir], solrlnxclient[:cli_lib_Dir], solrlnxclient[:cfg_loc]].each do |dir|
    directory dir do
        mode "0644"
        owner solrlnxclient[:user]
        group solrlnxclient[:user]
        action :create
        recursive true
    end
end

remote_file "#{Chef::Config[:file_cache_path]}/#{solrlnxclient[:artifactName]}" do
    source solrlnxclient[:installer_url]
    owner solrlnxclient[:user]  
    group solrlnxclient[:user]
    mode "0655"
end

# extract Solr-Cloud tar
execute "Extract Solr-Cloud tarball" do
	user solrlnxclient[:user] 
	group solrlnxclient[:user]
	command "tar xfz #{Chef::Config[:file_cache_path]}/#{solrlnxclient[:artifactName]} -C #{solrlnxclient[:loc]}"
not_if %{ ls -A #{solrlnxclient[:home_dir]}/#{solrlnxclient[:sample_collection]} }
end

# extract Solr-Cloud.war
execute "Extract Solr-Cloud.war" do
    user solrlnxclient[:user] 
    group solrlnxclient[:user]
    command "unzip -q #{solrlnxclient[:home_dir]}/dist/#{solrlnxclient[:artifact]}.war -d #{solrlnxclient[:solrWarDir]}"
not_if %{ ls -A #{solrlnxclient[:solrWarDir]} }
end

template "#{solrlnxclient[:home_dir]}/solr.xml" do
                source "solr.xml.erb" 
                user solrlnxclient[:user]
                group solrlnxclient[:user]
                mode "0644"
end

# Copy Lib  file
execute "Copy war Lib file" do
    user solrlnxclient[:user] 
    group solrlnxclient[:user]
    command "cp -r #{solrlnxclient[:solrWarDir]}/WEB-INF/lib/* #{solrlnxclient[:cli_lib_Dir]}"
    notifies :run, "execute[Copy_Logger_Lib_file]"
#not_if %{ ls -A #{solrlnxclient[:cli_lib_Dir]} }
end

# Copy Logger Lib  file
execute "Copy_Logger_Lib_file" do
    user solrlnxclient[:user] 
    group solrlnxclient[:user]
    command "cp -r #{solrlnxclient[:home_dir]}/#{solrlnxclient[:sample_collection]}/lib/ext/* #{solrlnxclient[:cli_lib_Dir]}"
    action :run
end

# Copy Config  file
execute "Copy Config file" do
    user solrlnxclient[:user] 
    group solrlnxclient[:user]
    command "cp -r #{solrlnxclient[:home_dir]}/#{solrlnxclient[:sample_collection]}/solr/collection1/conf/* #{solrlnxclient[:cfg_loc]}"
#not_if %{ ls -A #{solrlnxclient[:cfg_loc]} }
end

# Make Collection file
execute "Copy example to Collection file" do
	user solrlnxclient[:user] 
	group solrlnxclient[:user]
	command "cp -r #{node[:solr_cloud][:home_dir]}/#{node[:solr_cloud][:sample_collection]} #{node[:solr_cloud][:home_dir]}/#{node[:solr_cloud][:collection]}"
not_if %{ ls -A #{node[:solr_cloud][:home_dir]}/#{node[:solr_cloud][:collection]} }
end

#Upload and Link schema configuration files to Zookeeper
bash "Upload and Link schema configuration files to Zookeeper" do
                user solrlnxclient[:user]
                group solrlnxclient[:user]
                cwd "#{solrlnxclient[:home_dir]}/#{solrlnxclient[:collection]}"
                returns 0
                code %{
			java -DnumShards=2 -DzkHost=ip-10-20-0-5:2181  -jar start.jar &> /dev/null
               }
end

