function tailr_logs
  tailr --list
end

    #_arguments "1:Args:(`tailr --list` --completions -l --list)"

complete --no-files -c tailr -s l -l list -d "list available logs"
complete --no-files -c tailr -a (tailr --list)
