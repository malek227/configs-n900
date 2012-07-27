if [ $SHELL = "/bin/sh" ]; then
  if [ -x /bin/bash4 ]; then
    case $- in
      *i*) exec bash4 $@;;
    esac
  fi
fi
