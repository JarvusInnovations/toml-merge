# toml-merge
Merge two or more TOML files recursively

Inspired by [boivie/toml-merge](https://github.com/boivie/toml-merge), but with support added for recursivey merging via [merge-options](https://github.com/schnittstabil/merge-options).

## Usage

Install via Habitat:

```bash
hab pkg install --binlink jarvus/toml-merge
```

You might then use this in a config plan's `plan.sh` to layer some new defaults on top of a wrapped package's:

```bash
do_build_config() {
  do_default_build_config

  build_line "Merging config from ${wrapped_pkg_ident}"
  cp -nrv "$(pkg_path_for ${wrapped_pkg_ident})"/{config_install,config,hooks} "${pkg_prefix}/"
  toml-merge \
    "$(pkg_path_for ${wrapped_pkg_ident})/default.toml" \
    "${PLAN_CONTEXT}/default.toml" \
    > "${pkg_prefix}/default.toml"
}
```

You can also use STDIN to include heredoc content in the merge:

```bash
do_build_config() {
  do_default_build_config

  build_line "Merging config from ${wrapped_pkg_ident}"
  cp -nrv "$(pkg_path_for ${wrapped_pkg_ident})"/{config_install,config,hooks} "${pkg_prefix}/"
  toml-merge \
    "$(pkg_path_for ${wrapped_pkg_ident})/default.toml" \
    - \
    "${PLAN_CONTEXT}/default.toml" \
    > "${pkg_prefix}/default.toml" <<- END_OF_TOML
      [core]
        debug = false
        production = true
      [extensions.opcache.config]
        validate_timestamps = false
END_OF_TOML
}
```
