function dl -a line path
  sed -i -e $line"d" $path
end
