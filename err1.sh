#!/bin/bash
set -e
echo "This is a Test Script. "
cd /nonexistent_directory
echo "This line will not be reached because of the 'set -e' directive. "
 echo "This line will not be executed. "
