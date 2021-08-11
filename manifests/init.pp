# ex: syntax=puppet si sw=2 ts=2 et
class hashicorp (
  $install_dir        = undef,
  $download_cache_dir = undef,
) {
  include '::hashicorp::defaults'
  include '::gnupg'

  gnupg_key { 'hashicorp':
    ensure     => present,
    key_id     => '72D7468F',
    user       => 'root',
    key_source => 'https://keybase.io/hashicorp/pgp_keys.asc?C874011F0AB405110D02105534365D9472D7468F',
    key_type   => public
  }

  file { $download_cache_dir:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/usr/local/bin/hashicorp-download.sh':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0744',
    source => 'puppet:///modules/hashicorp/hashicorp-download.sh',
  }
}
