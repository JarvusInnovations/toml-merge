pkg_name=toml-merge
pkg_origin=jarvus
pkg_version="0.1.0"
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_upstream_url="https://github.com/JarvusInnovations/toml-merge"
pkg_license=("Apache-2.0")
pkg_deps=(core/node)
pkg_bin_dirs=(bin)


do_build() {
  pushd "${CACHE_PATH}" > /dev/null
  cp -v \
    "${PLAN_CONTEXT}/package.json" \
    "${PLAN_CONTEXT}/package-lock.json" \
    ./
  npm install
  popd > /dev/null
}

do_install() {
  pushd "${CACHE_PATH}" > /dev/null
  cp -r ./* "${pkg_prefix}/"
  {
    echo "#!$(pkg_path_for core/node)/bin/node"
    echo
    cat "${PLAN_CONTEXT}/toml-merge.js"
  } > "${pkg_prefix}/bin/toml-merge"
  chmod +x "${pkg_prefix}/bin/toml-merge"
  popd > /dev/null
}
