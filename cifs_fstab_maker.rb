#!/usr/bin/ruby

DEFAULT = {
	:ip_addr => "127.0.0.1",
	:uid => "user",
	:gid => "group",
	:username => "username",
	:password => "password",
}

CIFS_SETTINGS = [
	DEFAULT.merge({
		:ip_addr => "127.0.0.1",
		:share_folder => "desktop",
		:mount_point => "/mnt/desktop",
	}),
	DEFAULT.merge({
		:ip_addr => "127.0.0.1",
		:share_folder => "share",
		:mount_point => "/mnt/share",
	}),
]

CIFS_SETTINGS.each do |set|
	fstab = "//#{set[:ip_addr]}/#{set[:share_folder]}	#{set[:mount_point]}	cifs	noauto,user,uid=#{set[:uid]},gid=#{set[:gid]},codepage=cp932,dir_mode=0755,file_mode=0755,username=#{set[:username]},password=#{set[:password]},iocharset=utf8	0 0\n"
	puts fstab
end
