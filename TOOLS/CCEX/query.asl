setdebug(0)
opendll("sql")

// SQL interface
//svar res

// open connection to server and database

SetDebug(1)
// get db handle
dbh=SQLconnect("calcarb")

<<"%i $dbh \n"
// make a query


res=SQLquery(dbh,"show tables")
sz= Caz(res)
<<"%v $sz \n"
<<"%i $res \n"




//<<"%1r $res[0:sz-1] \n"

res=SQLquery(dbh,"describe food")
sz= Caz(res)

<<"%v $sz \n"
<<"%i $res \n"
STOP!

<<"%1r $res[0:sz-1] \n"



res=SQLquery(dbh,"select * from food where cals < 30 AND carbs < 7")

// insert

// delete
sz= Caz(res)
<<"%1r $res[0:sz-1] \n"

res=SQLquery(dbh,"select name,cals,carbs from food where cals < 30 AND carbs < 7")

// insert

// delete
sz= Caz(res)
<<"%1r $res[0:sz-1] \n"

<<" ////////////// \n"

res=SQLquery(dbh,"select name,cals,carbs from food where name REGEXP '^eggs.*fried' ")

// insert

// delete
sz= Caz(res)
<<"%1r $res[0:sz-1] \n"

STOP!


////////////////////////////////////// TBD ////////////////////////////
// connect to server
// create database
// use database
// show tables
// make query



