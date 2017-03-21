#!/bin/bash

#Sara Silva
#Student Number: 1669329

DIR="output"
if [ -d "$DIR" ]; then
    echo "Removing output folder if it already exists to prevent duplicate data"
    rm -rf "$DIR"
fi

while read line; do

	echo $line

	declare -a "ARRAY=($line)"

	echo "Creating student folders by student id for each student"

	mkdir -p "output/${ARRAY[0]}"

	echo "Creating details.txt file for each student folder with student's details"

	echo "StudentID: ${ARRAY[0]}" > "output/${ARRAY[0]}/details.txt"
        echo "Name: ${ARRAY[1]}" >> "output/${ARRAY[0]}/details.txt"
        echo "Last Name: ${ARRAY[2]}" >> "output/${ARRAY[0]}/details.txt"
        echo "DOB: ${ARRAY[3]}" >> "output/${ARRAY[0]}/details.txt"
        echo "Address: ${ARRAY[4]}" >> "output/${ARRAY[0]}/details.txt"

	DIR=$1

	for SUBDIR in $( ls $DIR ); do

  	 if [ -d "$DIR/$SUBDIR" ]; then

         touch  "output/${ARRAY[0]}/$SUBDIR.txt"

         echo "Creating block files inside student folders."

          notes="output/${ARRAY[0]}/notes.txt"
            if [ ! -e "$notes" ]; then
              echo "Failed: " >> "output/${ARRAY[0]}/notes.txt"
            fi

         echo "Creating notes files for each student folder."

         for FILE in $( ls "$DIR/$SUBDIR" ); do


           while read LINE; do


             if [[ "$LINE" == *"${ARRAY[0]}"* ]]; then


          echo "${FILE%.txt}  ${LINE: -2}" >> "output/${ARRAY[0]}/$SUBDIR.txt"

          echo "Writing module names and grades to each block file"

          if [ "${LINE: -2}" -lt 40 ]; then

           echo "${FILE%.txt}"  >> "output/${ARRAY[0]}/notes.txt"

          echo "Notes about failed modules being sent to notes.txt"
        fi
      fi
      done < "$DIR/$SUBDIR/$FILE"
   done
  fi
done

done < $1/Students.txt





