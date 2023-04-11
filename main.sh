#!/bin/bash

echo "Searching for MP3 files in current directory..."
# get a list of all the MP3 files in the folder
mp3_files=$(find . -maxdepth 1 -name '*U*.mp3' -print0)

# check if any MP3 files were found
if [ -z "$mp3_files" ]; then
  echo "No MP3 files found in current directory."
  exit 1
fi

echo "Found the following MP3 files:"
echo "$mp3_files"

# get a list of all the unique book names in the folder
books=$(ls *U*.mp3 | sed 's/U[0-9]*.mp3//' | sort -V | uniq)
echo "NEXT!!!"
# check if any books were found
if [ -z "$books" ]
then
  echo "No books found"
else
  echo "Books found:"
  echo "$books"
  read -p "Proceed to merge? [y/n] " proceed
  if [ "$proceed" = "y" ]
  then
    for book in $books
    do
      echo "Processing book: $book"
      files=$(find . -name "${book}U*.mp3" | sort -V)
      echo "Files found: $files"
      if [ -n "$files" ]
      then
        echo "Merging files for book: $book"
        echo "Files to merge: $files"
        #ffmpeg -i "concat:$files" -acodec copy "$book.mp3"
        cat $files > "${book}.mp3"

      fi
    done

  else
    echo "Aborted"
  fi
fi
