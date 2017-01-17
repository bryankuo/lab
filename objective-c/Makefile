all: classInit

HelloWorld:
	# gnustep
	# sudo apt-get install gobjc gnustep-devel
	# gcc HelloWorld.m `gnustep-config --objc-flags` `gnustep-config --base-libs` -o HelloWorld
	gcc -o HelloWorld -Wall -std=c99 HelloWorld.m -framework Foundation -lobjc

classInit:
	# gcc -framework Foundation classInit.m -o classInit
	gcc -o classInit -Wall -std=c99 classInit.m -framework Foundation -lobjc

clean:
