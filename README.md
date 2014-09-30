# icinga-cookbook
Cookbook install's Icinga server on Debian/Ubuntu OS from source.
As default used latest icinga, v.1.11.7

## Depends
* Apache2 cookbook.
* Apt cookbook.

## Supported Platforms
* Ubuntu 12.04 / 14.04
* Debian 6 / 7

## Attributes

| Key | Type | Description | Example |
|-----|------|-------------|---------|
| set['apache']['default_site_enabled'] | boolean | Enables default apache site. (Needed if you haven't any enabled sites.) | true/false |
| default['icingaadmin']['name'] | text | Sets icinga admin username | 'Admin' |
| default['icingaadmin']['password'] | text | Sets icinga admin password | 'Password' |
| default['icinga']['root'] | text | Sets icinga root directory | '/opt/icinga' |
| default['icinga_sys']['user'] | text | Name of user that will be added in system. | 'icinga' |
| default['icinga_sys']['password'] | text | Password of icinga user | 'icinga' |
| default['icinga_sys']['group'] | text | Group for icinga command line tools. | 'icinga-cmd' |
| default['nagios_plugins']['root'] | text | Nagios plugin directory. By default in Debian/Ubuntu plugins stores in '/usr/lib/nagios/plugins' | '/usr/lib/nagios/plugins' |
| default['icinga']['source']['version'] | text | Icinga version. | '1.11.7' |

## Usage

### icinga::default

Include `icinga` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[icinga::default]"
  ]
}
```
## License and Authors

Author:: Denis Chekirda (<dchekirda@gmail.com>)