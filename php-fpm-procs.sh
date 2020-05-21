#!/bin/bash

# Total Max PHP_FPM Processes = (Total RAM - (Used RAM + Buffer)) / (Memory per php process)

TOTAL_RAM=$(vmstat -s | grep 'total memory' | awk '{print $1}')
USED_RAM=$(vmstat -s | grep 'used memory' | awk '{print $1}')
BUFFER_RAM=$(vmstat -s | grep 'buffer memory' | awk '{print $1}')

# Average Memory usage by all php-fpm processes
AVG=$(ps -ylC php-fpm --sort:rss | awk '{sum+=$8} END {printf("%d",sum/NR)}')

MAX_PHP_FPM_PROCESS=$(let x=${TOTAL_RAM}-${USED_RAM}+${BUFFER_RAM} y=x/${AVG}; echo $y)


echo "PHP-FPM statistics:"
echo "Can run: $MAX_PHP_FPM_PROCESS"
echo "Running: $(ps -ef | grep -c php-fpm)"
