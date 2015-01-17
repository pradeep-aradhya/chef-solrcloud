#
# Cookbook Name:: solr-cloud
# Attribute:: default
#
# Copyright 2015, Pradeep Aradhya.
#
# All rights reserved - Do Not Redistribute
#

#Solr Attribute
default[:solr_cloud][:user] = "root"
default[:solr_cloud][:version] = "4.10.3"
default[:solr_cloud][:artifact] ="solr-#{node[:solr_cloud][:version]}"
default[:solr_cloud][:artifactName] ="#{node[:solr_cloud][:artifact]}.tgz"
default[:solr_cloud][:installer_url] = "http://archive.apache.org/dist/lucene/solr/#{node[:solr_cloud][:version]}/#{node[:solr_cloud][:artifactName]}"
default[:solr_cloud][:loc] ="/opt"
default[:solr_cloud][:home_dir] ="#{node[:solr_cloud][:loc]}/#{node[:solr_cloud][:artifact]}"
default[:solr_cloud][:sample_collection] ="example"
default[:solr_cloud][:solrWarDir] = "#{node[:solr_cloud][:home_dir]}/solr-war"
default[:solr_cloud][:cli_lib_Dir] = "#{node[:solr_cloud][:home_dir]}/solr-cli-lib"
default[:solr_cloud][:cfg_loc] = "#{node[:solr_cloud][:home_dir]}/config-files"
default[:solr_cloud][:collection] ="hindu"
default[:solr_cloud][:script_loc] ="#{node[:solr_cloud][:home_dir]}/#{node[:solr_cloud][:collection]}/scripts/cloud-scripts"
default[:solr_cloud][:zk_script] ="zkcli.sh"
default[:solr_cloud][:confname] ="solr1"
default[:solr_cloud][:dataDir] ="#{node[:solr_cloud][:loc]}/#{node[:solr_cloud][:artifact]}/data"
default[:solr_cloud][:zk_server1] ="ip-10-20-0-5:2181"
default[:solr_cloud][:javaArgs] ="-server -Xmx1G -Xms1G -XX:PermSize=256m -XX:MaxPermSize=256m -Xss260k -XX:+UnlockDiagnosticVMOptions -XX:+UseCompressedOops -XX:+CMSIncrementalPacing -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:ErrorFile=java_err.log -XX:HeapDumpPath=java.hprof -XX:+UseCMSInitiatingOccupancyOnly -XX:+CMSIncrementalMode -XX:+CMSClassUnloadingEnabled -XX:CMSIncrementalDutyCycle=10 -XX:+UseParNewGC -XX:+HeapDumpOnOutOfMemoryError -XX:+DisableExplicitGC -XX:SoftRefLRUPolicyMSPerMB=1 -XX:NewRatio=1 -XX:CMSIncrementalDutyCycleMin=0"


