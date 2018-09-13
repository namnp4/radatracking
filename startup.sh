cd /home/rada_reporter

puma -C config/puma.rb
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start my_first_process: $status"
  exit $status
fi

while /bin/true; do
  PROCESS_1_STATUS=$(ps aux |grep -q my_first_process |grep -v grep)
  PROCESS_2_STATUS=$(ps aux |grep -q my_second_process | grep -v grep)
  # If the greps above find anything, they will exit with 0 status
  # If they are not both 0, then something is wrong
  if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 ]; then
    echo "One of the processes has already exited."
    exit -1
  fi
  sleep 60
done
