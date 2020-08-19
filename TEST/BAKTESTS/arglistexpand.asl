#! /usr/local/GASP/bin/asl

// test arg expansion

a= 1
b = 0.2


foota("mark",a,b)


foota("mark,$a,$b")

foota({a,b})

// should always promote to highest
foota({b,a})

// want this to split the one svar arg
// into comma del separate args type via str-to-number
// array expansion has to into comma del fields
foota(<"mark,$a,$b">)







STOP!