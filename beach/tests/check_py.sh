#!/bin/bash

check_py () {
  for CHECK_PYTHON in "$CHECK_PYTHON" python2.7 python27 python2 python; do
    # Break (while keeping the CHECK_PYTHON value) if found.
    command -v "$CHECK_PYTHON" > /dev/null && break
  done
  if [ "$?" != "0" ]; then
    echo "Cannot find any Pythons; please install one!"
    exit 1
  fi

  PYVER=`"$CHECK_PYTHON" -V 2>&1 | cut -d" " -f 2 | cut -d. -f1,2 | sed 's/\.//'`
  if [ "$PYVER" -lt 26 ]; then
    echo "You have an ancient version of Python entombed in your operating system..."
    echo "This isn't going to work; you'll need at least version 2.6."
    exit 1
  fi
}

check_py
