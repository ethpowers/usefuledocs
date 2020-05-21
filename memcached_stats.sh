#!/bin/bash

watch 'php -r '"'"'$m=new Memcached;$m->addServer("127.0.0.1", 11211);print_r($m->getStats());'"'"
