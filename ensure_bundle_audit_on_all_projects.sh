function ensure_bundle_audit_on_all_projects() {
  find "$HOME/projects" -type d -depth 1 | \
    parallel \
    "if (test -e {}/Gemfile.lock); then (cat {}/.overcommit.yml 2>/dev/null | grep -q BundleAudit || (echo 'Missing BundleAudit in {}/.overcommit.yml' ; return 1)); else (return 0); fi"
}
