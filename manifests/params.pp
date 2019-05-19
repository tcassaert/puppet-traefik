# == Class: traefik::params
#
class traefik::params {
  $install_method    = 'url'
  $download_url_base = 'https://github.com/containous/traefik/releases/download'
  $version           = '1.7.11'
  $archive_dir       = '/opt/puppet-archive'
  $bin_dir           = '/usr/local/bin'
  $max_open_files    = 16384

  $config_dir        = '/etc/traefik'
  $config_file       = 'traefik.toml'

  case $::architecture {
    'x86_64', 'amd64': { $arch = 'amd64' }
    'i386':            { $arch = '386'   }
    /^arm.*/:          { $arch = 'arm'   }
    default:           {
      fail("Unsupported kernel architecture: ${::architecture}")
    }
  }

  $os = downcase($::kernel)

  case $::osfamily {
    'Debian': {
      case $::operatingsystemrelease {
        /(^7.*|^14\.04.*)/ : {
          $init_style = 'debian'
        }
        default : {
          $init_style = 'systemd'
        }
      }
    }
    'RedHat': {
      case $::operatingsystemrelease {
        /^6.*/ : {
          $init_style = 'redhat'
        }
        default : {
          $init_style = 'systemd'
        }
      }
    }
    default: {
      fail("Unsupported osfamily ${::osfamily}, currently only supports Debian and RedHat")
    }
  }
}
