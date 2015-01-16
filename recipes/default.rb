#
# Cookbook Name:: solr-cloud
# Recipe:: default
#
# Copyright 2015, Pradeep Aradhya.
#
# All rights reserved - Do Not Redistribute
#


case node[:os]
  when "linux"
	  Chef::Log.info("Its Linux")
Chef::Log.info("#{node[:platform]}")
	case node[:platform]
  		when "redhat", "centos", "suse", "fedora", "amazon"
    			include_recipe "solr-cloud::solrinstall"
	end
  when "windows"
    	Chef::Log.info("Its Windows...Nothing to do")
  else
    	Chef::Log.info("Oops...couldn't understand #{node.os} yet!!!")
end
