#string functions

#concat(string1,string2.....stringN)
select customername,
concat(city,"",state,"",country,"",postalcode) as customerfulladd 
from customers;

#concat_ws(separator,string1,string2,.....stringN)
#WS:- with separator
#it works on non null values only
select customername,
concat_ws(" ",city,state,country,postalcode) as custfullad 
from customers;

#upper(string) :- converts string to uppercase 
select upper(customername) from customers;

#lower(string):-converts string to lowercase 
select lower(customername) from customers;

#len(string):- counts length of characters 
select length(textdescription),productline from productlines;

#reverse(string)
select reverse("decode");

#trim(string)
#is used for removing unwanted leading and trail white
#spaces from given string 
select trim("   decode   data   ");
select length(trim("   decode   data   "));

#ltrim
select ltrim("   decode   data   ");
select length(ltrim("   decode   data   "));

#rtrim
select rtrim("   decode   data   ");
select length(rtrim("   decode   data   "));