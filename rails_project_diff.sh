function rails_project_diff() {
  if [ ! -d $1 ]; then
    echo "Not a directory: $1"
    return 1
  fi
  if [ ! -d $2 ]; then
    echo "Not a directory: $2"
    return 2
  fi
  local rails_project_diff_TMP="/tmp/.rails_project_diff-$$"
  local rails_project_diff_CWD=`pwd -P`
  local rails_project_diff_DIFF="$rails_project_diff_CWD/`basename $1`-and-`basename $2`.diff"
  mkdir -p $rails_project_diff_TMP || return $?
  echorun rsync -a $1/ $rails_project_diff_TMP/first/ --exclude log --exclude tmp --exclude .git --exclude vendor || return $?
  echorun rsync -a $2/ $rails_project_diff_TMP/second/ --exclude log --exclude tmp --exclude .git --exclude vendor || return $?
  cd $rails_project_diff_TMP || return $?
  diff -urN first/ second/ > $rails_project_diff_DIFF
  cd $rails_project_diff_CWD || return $?
  echorun rm -rf $rails_project_diff_TMP || return $?
  echorun open $rails_project_diff_DIFF || return $?
}
