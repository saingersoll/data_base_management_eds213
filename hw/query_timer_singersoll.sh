# Sofia Ingersoll
# WK5 Q4
# 2024 / 5 / 10

# Part 1
# create a script — a “test harness”
# that will allow you to test something 
# (some code, an algorithm, a model, etc.) 
# by running it repeatedly, perhaps under varying conditions. 

# create a Bash script that will allow you to time how long it takes to run an SQL query. 
# your script will append the following record to the CSV tile timings.csv:
# invoked like this 
#% bash query_timer.sh label num_reps query db_file csv_file

 # Arguments:
  #    label:    explanatory label that will be output
   #   num_reps: number of repetitions
    #  query:    SQL query to run
     # db_file:  database file
      #csv_file: CSV file to create or append to

# psuedocode provided 
#get current time and store it
#loop num_reps times
 #   duckdb db_file query
#end loop
#get current time
#compute elapsed time
#divide elapsed time by num_reps
#write output


#!/bin/bash
# Check if correct number of arguments are provided
#if [ "$#" -ne 5 ]; then
 #   echo "Usage: bash query_timer.sh label num_reps query db_file csv_file"
  #  exit 1
#fi

# Store command line arguments in variables
#label="$1"
#num_reps="$2"
#query="$3"
#db_file="$4"
#csv_file="$5"

# Calculate elapsed time in seconds
#calculate_elapsed_time() {
 #   local start_time="$1"
 #   local end_time="$2"
 #   echo "$((end_time - start_time))"
#}

# Compute average time per repetition
#compute_average_time() {
 #   local elapsed_time="$1"
  #  local num_reps="$2"
   # bc -l <<< "$elapsed_time / $num_reps"
#}

# Main script logic
# Get current time
#start_time=$(date +%s)

# Loop num_reps times
#for ((i = 0; i < num_reps; i++)); do
 #   duckdb "$db_file" "$query" > /dev/null 2>&1
#done

# Get end time
#end_time=$(date +%s)

# Calculate elapsed time
#elapsed_time=$(calculate_elapsed_time "$start_time" "$end_time")

# Compute average time per repetition
#average_time=$(compute_average_time "$elapsed_time" "$num_reps")

# Extract filename without extension
# I was hoping to get the file name to output, but it keeps saying timings
#label=$(basename "$csv_file" .csv)
#label=$(basename "$csv_file" | rev | cut -d'.' -f2- | rev)

# Write output to CSV file
#echo "$label,$average_time" >> "$csv_file"


# make it executable 
 #chmod +x query_timer_singersoll.sh


# testing test harness
# query_timer_singersoll.sh with_index_a 1000 'SELECT COUNT(*) FROM Bird_nests' \
   #  database.db timings.csv

# SWEET! Close enough, The output was timings,.019


# Part 2
# I tried to integrate the three methods in the og function and it wasn't running right, so bringing back the old code

#!/bin/bash
# Check if correct number of arguments are provided
if [ "$#" -ne 5 ]; then
    echo "Usage: bash query_timer_singersoll.sh label num_reps query db_file csv_file"
    exit 1
fi

# Store command line arguments in variables
query_label="$1"
num_reps="$2"
query="$3"
db_file="$4"
csv_file="$5"

# Function to calculate elapsed time in seconds
calculate_elapsed_time() {
    local start_time="$1"
    local end_time="$2"
    echo "$((end_time - start_time))"
}

# Function to compute average time per repetition
compute_average_time() {
    local elapsed_time="$1"
    local num_reps="$2"
    bc -l <<< "$elapsed_time / $num_reps"
}

# Main script logic
# Get current time
start_time=$(date +%s)

# Loop num_reps times
for ((i = 0; i < num_reps; i++)); do
    duckdb "$db_file" "$query" > /dev/null 2>&1
done

# Get end time
end_time=$(date +%s)

# Calculate elapsed time
elapsed_time=$(calculate_elapsed_time "$start_time" "$end_time")

# Compute average time per repetition
average_time=$(compute_average_time "$elapsed_time" "$num_reps")

# Extract filename without extension
filename=$(basename "$csv_file")
label="${filename%.*}"

# Write output to CSV file
echo "$query_label,$average_time" >> "$csv_file"


# bash queries to test
# NOT IN
#query_timer_singersoll.sh not_in 1000 'SELECT Code FROM Species WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests);' database.db timings.csv
# JOIN
#query_timer_singersoll.sh outer_join 1000 'SELECT Code FROM Bird_nests RIGHT JOIN Species ON Species = Code WHERE Nest_ID IS NULL;' database.db timings.csv
# SET
#query_timer_singersoll.sh set_operation 1000 'SELECT Code FROM Species EXCEPT SELECT DISTINCT Species FROM Bird_nests;' database.db timings.csv


# I ran both of the code chunks for Part 2 a few times
# In the second version, even though we used different query methods
# the timing recorded for each was the same in almost every instance
# .020 and .021
# NOT IN was consistently 0.02, 
# so I would deduce this was the fastest method out of the three
