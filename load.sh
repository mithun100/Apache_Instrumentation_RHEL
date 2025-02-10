#!/bin/bash
while :
do
    echo "======================================================================================"
    echo "Invoking the Application deployed in Apache on port 8080!"
    STARTTIME=$(date +"%Y-%m-%d %H:%M:%S:%3N")
    echo "Sent request at: $STARTTIME"
    curl http://localhost:8080/
    ENDTIME=$(date +"%Y-%m-%d %H:%M:%S:%3N")
    echo "Received response at: $ENDTIME"
    echo "Sleeping for 5 secs..."
    sleep 5
done

