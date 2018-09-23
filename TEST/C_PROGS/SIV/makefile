# make file of sivtypes

CC=g++
CFLAGS=-I.


SRCS = sivtypes.cpp ds_svar.cpp ds_records.cpp ds_sivmem.cpp ds_sivbounds.cpp ds_sivrange.cpp vector.cpp matrix.cpp array.cpp record.cpp

OBJS = sivtypes.o ds_svar.o ds_records.o ds_sivmem.o ds_sivbounds.o ds_sivrange.o vector.o matrix.o array.o record.o

DEPS = sivtypes.h

%.o: %.cpp $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

install : ${OBJS}
	$(CC) -o sivtypes $(SRCS) $(CFLAGS)

clean:
	rm -f *.o *~ core *~ 
