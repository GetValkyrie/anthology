# Create synced data directory for postgresql
file { ['/opt', '/opt/postgresql', '/opt/postgresql/data']:
  ensure => 'directory',
}
