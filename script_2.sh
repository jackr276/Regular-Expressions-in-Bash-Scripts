# Jack Robbins
# Homework 2, problem 2

#!bin/bash

#Declare an array for holding all dates(may be used)

#Declare an associative array for holding people and their ages
declare -A peopleAge
#Declare a regular array for holding people
declare -a people=()

#Get the current time in seconds for calculating age
timeSeconds=$(date +%s)

#Read the file in line by line, checking for people who have a two word city
while read -r line; do
    #Get the lines where we see a city that has two or more words in its name	
    if [[ $(echo "$line" | grep -E ',([[:space:]][A-Za-z]{1,}){2,},') ]]; then
	#We need to grab the person's name and DOB(to calculate age) if here
        name=$(echo "$line" | grep -E -o '^[A-Za-z]{1,}[[:space:]][A-Za-z]{1,}' )
	people+=("$name")

	#We expect to see dates in YYYY-MM-DD
        dob=$(echo "$line" | grep -E -o '[0-2][0-9]{3}-[0-1][0-9]-[0-3][0-9]')

	#Convert age into seconds since 1970 for calculations, then convert the difference into years
	dobSeconds=$(date +%s --date "$dob")
	ageSeconds=$(($timeSeconds-$dobSeconds))

	#convert to age in years
	#Note: 1 year = 31557600 seconds
	ageInYears=$((ageSeconds/31557600))
	peopleAge["$name"]="$ageInYears"
    fi
done < "$1"

echo "${peopleAge[@]}"
