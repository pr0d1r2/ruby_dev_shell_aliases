function obsolete_gem_no_ri_no_rdoc_projects_autofix() {
  obsolete_gem_no_ri_no_rdoc_projects | \
    parallel -v "cd $HOME/projects/{} && rg -l '(--no-ri|--no-rdoc)' | parallel -v -I '[]' \"sed -e 's/--no-ri --no-rdoc/--no-document/g' -e 's/--no-rdoc --no-ri/--no-document/g' -e 's/--no-rdoc/--no-document/g' -e 's/--no-ri/--no-document/g' -i '' []\""
}
