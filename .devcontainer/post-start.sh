# Wait for dockerd to start
until pids=$(pidof dockerd)
do   
    sleep 1
done

echo "DEBUG: Docker is running. Proceed."

docker run \
    -e K6_DYNATRACE_URL=$DT_URL \
    -e K6_DYNATRACE_APITOKEN=$DT_K6_TOKEN \
    --mount type=bind,source=./k6scripts,target=/k6scripts hrexed/xk6-dynatrace-output:0.11 run /k6scripts/script.js \
    -o output-dynatrace