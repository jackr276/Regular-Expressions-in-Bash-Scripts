# Regular Expressions in Bash Scripts
Author: [Jack Robbins](https://www.github.com/jackr276)

This repository contains two scripts that make use of grep and regular expressions(regex) in bash scripts.

## [script_1.sh](https://github.com/jackr276/Regular-Expressions-in-Bash-Scripts/blob/main/script_1.sh)
This script takes in a file as a command line argument and extracts all dates in the file that are of any the following forms: "MM-DD-YYYY", "MM/DD/YYYY", "MM.DD.YYYY". It then uses an insertion sort algorithm to sort the dates in ascending order, and prints the dates out in their original format.

## [script_2.sh](https://github.com/jackr276/Regular-Expressions-in-Bash-Scripts/blob/main/script_2.sh)
This script takes in, as a command line argument, a file in which in line is of the form: "Firstname Lastname, YYYY-MM-DD, City, Country" and uses a regular expression to find every line where the name of the city is two words or more(for example, "New York" or "Los Angeles"). Once it finds one of these lines, it then extracts the name of the individual and their birthdate, and stores both in an associative array. Finally, the age of each person is calculated and the resulting ages and names are printed out, in descending age order.
