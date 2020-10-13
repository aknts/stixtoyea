#!/bin/bash
SFILE="$1"
[ ! -f "$SFILE" ] && echo "$SFILE doesn't exist" 2>&1 && exit 2
echo -e ".mode csv\nselect name,last_name,telefono from contact where status='isPublic' and directory='external';" | sqlite3 $SFILE > contacts.csv

file_in="contacts.csv"
file_out="/var/www/html/phonebook/yealink_phonebook.xml"
echo '<?xml version="1.0"?>' > $file_out
echo '<IPPhoneDirectory clearlight="true">' >> $file_out
echo '<Title>Phonelist</Title>' >> $file_out
echo '<Prompt>Prompt</Prompt>' >> $file_out
while IFS=$',' read -r -a arry
do
  echo '  <DirectoryEntry>' >> $file_out
  echo '    <Name>'${arry[0]}'</Name>' >> $file_out
  echo '    <Telephone>'${arry[2]}'</Telephone>' >> $file_out
  echo '  </DirectoryEntry>' >> $file_out
done < $file_in
echo '</IPPhoneDirectory>' >> $file_out
