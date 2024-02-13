#Jack Robbins
#Homework 2, Problem 1

#!bin/bash

#Use grep for regular expression matching to get all of the dates
dates=($(grep -o '[0-9][0-9][\./-][0-9][0-9][\./-][0-9][0-9][0-9][0-9]' "$1"))
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
    #also store the unix time for ease of sorting
    timeOnly+=("$timeSeconds")
done

#Now we need to sort the timeOnly array(using insertion sort algorithm)
#get size of array
size=${#timeOnly[@]}
#insertion sort algorithm
for((i = 1; i < $size; i++)); do
    #get each array element as a key
    key=(${timeOnly[i]})

    #Declare j
    j=$(($i-1))

    #while j more than key, perform swap
    while [[ $j -ge 0 ]] && [[ ${timeOnly[j]} -gt $key ]]; do
        #bring array[j] forward
        timeOnly[$(($j+1))]=${timeOnly[j]}
        #decrement j with arithmetic expansion
        ((j--))
    done
    #put key in the next spot
    timeOnly[$(($j+1))]=$key
done

#Finally, print out everything in order
for entry in "${timeOnly[@]}"; do
    echo ${unixTime["$entry"]}
done
