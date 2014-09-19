# icinga-cookbook
Cookbook install's Icinga server on Debian/Ubuntu OS.

## Supported Platforms
* Ubuntu 12.04 / 14.04
* Debian 6 / 7

## Attributes

```ruby default['icingaadmin']['name'] = 'Admin' ``` - Sets icinga admin username.
```ruby default['icingaadmin']['password'] = 'Admin' ``` - Sets icinga admin password. 

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