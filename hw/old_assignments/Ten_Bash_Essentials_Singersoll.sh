# Sofia Ingersoll
# WK5 Q3
# 2024 / 5 / 10

#----
#!/bin/bash

# 1. Compare the output of these three commands:
    ls
    ls .
    ls "$(pwd)/../week3"

    Explain why you see what you see.

# All 3 outputs were identical. 
# Typical listing of folder contents
# This is because we're letting the
# command line know exactly where we are

#----
# 2. Try the following two commands:
# The first prints filenames and line counts. 
# The second prints a bare number. 

    wc -l *.csv
    cat *.csv | wc -l

# Why does it print that number, and why does it not print any filenames?
# It's computing the concatonated total line count of all the csv files listed

#----  
# 3. You want to count the total number of lines in all CSV files and try this command:

    cat *.csv | wc -l species.csv

# What happens and why?
# output 100 species.csv
# We specified the species.csv, so we only return the line count for it. 

#----
# 4. You’re given

    name=Moe

# and you’d like to print “Moe_Howard”. You try this:

    echo "$name_Howard"

# but that doesn’t quite work. What fix can you apply to $name to make this command give the desired effect?
# We need to indicate the name is a variable using {}
    echo "${name}_Howard"

#----
# 5. You create a script and run it like so:

    bash myscript.sh *.csv

# What are the values of variables $1 and $#? Explain why the script does not see just one argument passed to it.
# In the current directory 
# $1 refers to the first positional parameter passed to the script, $# refers to the total number of positional parameters passed to the script.
# The script does not see just one argument passed to it because the shell expands the wildcard *.csv before passing the arguments to the script.
# $1 will contain the value of the first CSV filename, e.g., file1.csv.
# $# will contain the total number of CSV files matched by the pattern.

#----
# 6. You create a script and run it like so:

    bash myscript.sh "$(date)" $(date)

# In your script, what is the value of variable $3?

# "$(date)": captures the current date and time as a single string and pass it as a single argument to the script.
# Fri May 10 18:58:38 PDT 2024
# $3 = 10
# $(date): This will capture the current date and time, but without quotes, it will be subject to word splitting by the shell.
# Fri
# no $3, only $1

#----
# 7. Create a file you don’t care about (because you’re about to destroy it):

# this was funny
    echo "yo ho a line of text" > junk_file.txt
    echo "another line" >> junk_file.txt

# You want to sort the lines in this file, so you try:

    sort junk_file.txt

# Well that prints the lines in sorted order, but it doesn’t actually change the file. You recall section 7 and try:

    sort junk_file.txt > junk_file.txt

# What happens and why? How can you sort the lines in your file? (Hint: it involves creating a second file and using mv.)
# The unfornutately deleted all of our text!
    sort junk_file.txt > temp.txt
    # move this temp.txt object we made into the txt file we want
    mv temp.txt junk_file.txt


#----
# 8. You want to delete all files ending in .csv, so you type (don’t actually try this):

    rm * .csv

# but as can be seen, your thumb accidentally hit the space bar and you got an extra space in there.
#  What will rm do in this case?
     rm *  .csv

# I am giving a very kind prompt that is asking me if I want to continue or not
 # zsh: sure you want to delete all 15 files in /Users/sofiaingersoll/1/EDS213/dbm/hw [yn]? 
 # um, just kidding, I just double checked and my csv were gone lol. 
 # Maybe I didn't cancel the command correctly
 # Luckily, that data is F.A.I.R.

