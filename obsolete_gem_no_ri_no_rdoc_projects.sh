function obsolete_gem_no_ri_no_rdoc_projects() {
  rg -l "(--no-ri|--no-rdoc)" "$HOME/projects" | sed -e "s|$HOME/projects/||" | cut -f 1 -d / | sort -u | grep -v ruby_dev_shell_aliases
}
