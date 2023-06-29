function bj --description "easily run background jobs"
  nohup $argv </dev/null &>/dev/null &
end
