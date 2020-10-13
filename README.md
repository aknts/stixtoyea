# stixtoyea
A bash script to convert the Elastix phonebook to a Yealink compatible one.

1) First install incron
yum install incron
chkconfig incrond on
/etc/init.d/incrond start

2) Edit incrotab to monitor the elastix address book sqlite

incrontab -e

add the following line

/var/www/db/address_book.db IN_MODIFY ./var/www/db/contactstoyealink.sh /var/www/db/address_book.db

3) We copy the script in /var/www/db and change permissions

chmod +x /var/www/db/contactstoyealink.sh

4) Create the following folder and apply the included apache conf to disable https for this folder

/var/www/html/phonebook

5) The file should have the file yealink_phonebook.xml and the corresponding option that the yealink phones have the following url must be used

http://elastix-ip-address/phonebook/yealink_phonebook.xml

A final note, the first name and last name of the contacts on Elastix must have the same value. This is due to a bug of Elastix and cannot be avoided.
