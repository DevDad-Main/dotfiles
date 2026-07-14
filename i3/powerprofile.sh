#!/bin/bash
case "$(powerprofilesctl get)" in
  performance) echo " Perf" ;;
  balanced)    echo " Bal" ;;
  power-saver) echo " Save" ;;
esac
