#!/bin/bash

# *  $Revision$
# *  $Date$
# *  $Author$
# *  $HeadURL$

killall rl_glue 2>/dev/null
killall test_1_agent 2>/dev/null
killall test_speed_environment 2>/dev/null
killall test_speed_experiment 2>/dev/null
sleep 1
rl_glue &
sleep 1
./test_1_agent &
sleep 1
./test_speed_environment &
sleep 1
./test_speed_experiment

test_outcome=$?
exit $test_outcome