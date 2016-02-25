

int V[20]


 V[10] = 47


<<"$V\n"


resize(V,30)


 V[20] = 80


<<"$V\n"


//  should give error --- not dynamic

V[30] = 79


<<"$V\n"


 resize(V,6,6)


<<"$V\n"