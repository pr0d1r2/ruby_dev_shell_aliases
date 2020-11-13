# Update only necessary gems needed by bundle audit
#
# Example usage:
#   bundle_audit_update
function bundle_audit_update() {
  if (bundle exec bundle-audit check --update 2>/dev/null | grep "^Name:" | cut -b7- | sort -u | grep -Eq "^(actionpack|actionview|activestorage|activesupport)$"); then
    echorun bundle update rails $(bundle exec bundle-audit check --update 2>/dev/null | grep "^Name:" | cut -b7- | sort -u)
  else
    echorun bundle update $(bundle exec bundle-audit check --update 2>/dev/null | grep "^Name:" | cut -b7- | sort -u)
  fi
  return $?
}
