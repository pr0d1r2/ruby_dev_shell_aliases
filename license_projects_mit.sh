function license_projects_mit() {
  for license_projects_mit_PROJ in `ls -d ~/projects/*`
  do
    if [ ! -f $license_projects_mit_PROJ/LICENSE ]; then
      if [ ! -f $license_projects_mit_PROJ/MIT-LICENSE ]; then
        cp -rvp ~/projects/plexus/LICENSE $license_projects_mit_PROJ/LICENSE
      fi
    fi
  done
}
