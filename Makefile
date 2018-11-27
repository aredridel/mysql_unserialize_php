BASE =
CC = g++
STRIP = strip
CFLAGS = -Wall -g -fPIC `php-config --includes` `mysql_config --include`
LFLAGS = -lphp5 `mysql_config --libs`

.cc.o:
	$(CC) $(CFLAGS) -c $< -o $*.o

unserialize_php.so: unserialize_php.o pfc.o
	$(CC) $(LFLAGS) -Wall -fPIC -shared -o $@ unserialize_php.o pfc.o
	$(STRIP) unserialize_php.so

test: test.o pfc.o
	$(CC) $(LFLAGS) test.o pfc.o -o $@

clean:
	@rm -f *.so test *.o
