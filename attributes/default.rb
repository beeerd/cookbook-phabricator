#
# Attribute file for Phabricator
#

# Where to install Phabricator, Arcanist and libphutil
default['phabricator']['path'] = '/opt/phabricator'

# Which user and group will Phabricator run as?
default['phabricator']['user'] = 'phabricator'

case node["platform_family"]
when "debian"
    default['phabricator']['group'] = 'www-data'
when "rhel"
    default['phabricator']['group'] = 'nginx'
end

# FQDN that will host Phabricator
default['phabricator']['domain'] = node[:fqdn]

# Git revisions to check out, use 'master' for bleeding edge
default['phabricator']['revision']['phabricator'] = 'master'
default['phabricator']['revision']['arcanist'] = 'master'
default['phabricator']['revision']['libphutil'] = 'master'

# Where to put source code repositories, both hosted and external
default['phabricator']['repository_path'] = '/var/repo'

# Set 'ssl' to true if you want to use SSL, and provide the paths.
default['phabricator']['ssl'] = false
default['phabricator']['ssl_cert_path'] = ''
default['phabricator']['ssl_key_path'] = ''

# MySQL credentials
default['phabricator']['mysql_host'] = 'localhost'
default['phabricator']['mysql_port'] = '3306'
default['phabricator']['mysql_user'] = 'phabricator'
default['phabricator']['mysql_password'] = 'changeme'

# PHP memory limit
default['phabricator']['php_memory_limit'] = '128M'

# Initial storage upgrade has been done
default['phabricator']['storage_upgrade_done'] = false

# MySQL option innodb_buffer_pool_size
mem = node['memory']['total'].split("kB")[0].to_i*1024*0.4
node.default['phabricator']['innodb_buffer_pool_size'] = mem.to_int

# Various config settings, feel free to expand with your own stuff.
default['phabricator']['config'] = {
    'storage.upload-size-limit' => '128M',
}

# Package dependencies
case node["platform_family"]
when "debian"
    default['phabricator']['packages'] = [
        'git', 'php5', 'php5-mysql', 'php5-gd', 'php5-dev', 'php5-curl', 'php-apc', 'php5-cli', 'php5-json'
    ]
when "rhel"
    default['phabricator']['packages'] = [
        'git', 'php', 'php-mysql', 'php-gd', 'php-devel', 'php-pear-Net-Curl', 'php-pecl-apc', 'php-cli', 'php-ldap', 'php-process', 'php-mbstring', 'redhat-lsb'
    ]
end

# Where to put Arcanist when using the arcanist recipe
default['phabricator']['arcanist']['destination'] = '/usr/local/lib/phabricator'
default['phabricator']['arcanist']['bin'] = '/usr/local/bin/arc'
