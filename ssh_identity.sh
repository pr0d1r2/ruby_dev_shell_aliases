function ssh_identity() {
  ssh-add -l | grep -q "^The agent has no identities.$" && ssh-add
}
