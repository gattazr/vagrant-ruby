module Ruby
	Version = '2.1.1'
	Gems = 
		[
			{
				:name => "bundler",
				:version => "1.6.2",
				:options => "--no-ri --no-rdoc",
				:gem_binary => "/usr/local/bin/gem"
			},
			{
				:name => "rails",
				:version => "4.1.0",
				:options => "--no-ri --no-rdoc",
				:gem_binary => "/usr/local/bin/gem"
			}
		]
end
