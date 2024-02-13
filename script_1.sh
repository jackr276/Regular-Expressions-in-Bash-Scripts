#Jack Robbins
#Homework 2, Problem 1

#!bin/bash

#Use grep for regular expression matching to get all of the dates
dates=( $(grep -o '[0-9][0-9][\./-][0-9][0-9][\./-][0-9][0-9][0-9][0-9]' "$1") )
size=${#dates[@]}

declare -A unixTime
declare -a timeOnly=()

#translate everything into unix time(seconds since 1970)
for((i = 0; i < $size; i++)); do
    #grab the date out of the array for convenience
    date=${dates[i]}
    #grab year
    [[ $date =~ ([0-9]{4}) ]]
    year=${BASH_REMATCH[1]}
    #grab month
    [[ $date =~ ([0-9]{2}) ]]
    month=${BASH_REMATCH[1]}
    #grab day
    [[ $date =~ ([\./-][0-9]{2}) ]]
    day=$(echo ${BASH_REMATCH[1]} | cut -c 2-3)
    #calculate the time since 1970 using date
    timeSeconds=$(date +%s --date "${year}-${month}-${day}")
    #store the time since 1970 as a key in the associative array
    unixTime["$timeSeconds"]="$date"
    timeOnly+=("$timeSeconds")
done

echo "${!unixTime[@]}"




