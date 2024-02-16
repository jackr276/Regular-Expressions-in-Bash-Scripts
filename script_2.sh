# Jack Robbins
# Homework 2, problem 2

#!bin/bash

#Declare an array for holding all dates(may be used)

#Declare an associative array for holding people and their ages(in seconds)
declare -A peopleAge
#Declare a regular array for holding ages(in seconds)
declare -a ages=()

#Get the current time in seconds for calculating age
timeSeconds=$(date +%s)

#Read the file in line by line, checking for people who have a two word city
while read -r line; do
    #Get the lines where we see a city that has two or more words in its name
    if [[ $(echo "$line" | grep -E ',([[:space:]][A-Za-z]{1,}){2,},') ]]; then
	#We need to grab the person's name and DOB(to calculate age) if here
        name=$(echo "$line" | grep -E -o '^[A-Za-z]{1,}[[:space:]][A-Za-z]{1,}' )

	#We expect to see dates in YYYY-MM-DD
        dob=$(echo "$line" | grep -E -o '[0-2][0-9]{3}-[0-1][0-9]-[0-3][0-9]')

	#Convert age into seconds since 1970 for calculations/sorting
	dobSeconds=$(date +%s --date "$dob")
	ageSeconds=$(($timeSeconds-$dobSeconds))

        #Key the associative array by age in seconds
	peopleAge["$ageSeconds"]="$name"
        ages+=("$ageSeconds")
    fi
done < "$1"

#Now we need to sort the ages array(using insertion sort algorithm)
#get size of array
size=${#ages[@]}
#insertion sort algorithm
for((i = 1; i < $size; i++)); do
    #get each array element as a key
    key=${ages[i]}

    #Declare j
    j=$(($i-1))

    #while j more than key, perform swap
    while [[ $j -ge 0 ]] && [[ ${ages[j]} -lt $key ]]; do
        #bring array[j] forward
        ages[$(($j+1))]=${ages[j]}
        #decrement j with arithmetic expansion
        ((j--))
    done
    #put key in the next spot
    ages[$(($j+1))]=$key
done

#now that ages are sorted, we can safely print and convert back to years
for age in "${ages[@]}"; do
    #Note: 1 year = 31557600 seconds
    echo "${peopleAge[$age]}" is $((${age}/31557600))
done
