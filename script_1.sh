#Jack Robbins
#Homework 2, Problem 1

#!bin/bash

#Use grep for regular expression matching to get all of the dates
dates=( $(grep -o '[0-9][0-9][\./-][0-9][0-9][\./-][0-2]0[0-2][0-9]' "$1") )

echo ${dates[@]}

