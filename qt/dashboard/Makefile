all:
	qmake -project
	qmake
	make
	# make: Command not found
# Q: how to build Qt project from command line linux?
# A: QT-Creator actually takes the first two steps silently.
# ( http://tinyw.in/s9DB )

# qmake -project is only run once. It is basically just to
# create a skeleton .pro file. ( http://tinyw.in/ReDp )
clean:

install:
	scp ./debug/dashboard racev@vtc6210bk:/home/racev/dashboard
	scp ./debug/dashboard.debug racev@vtc6210bk:/home/racev/dashboard.debug

release:

debug:
# ( https://stackoverflow.com/a/6132843 )
	pushd .
	cd ./debug
	make
	popd

debug-clean:
# ( https://stackoverflow.com/a/6132843 )
	pushd .
	cd ./debug
	make clean
	popd

# // FIXME: it takes long to build whole directory
# // include as little as possible
ctags-qt:
	ctags -R --verbose==yes --languages=C,C++ --c++-kinds=+p \
	    --fields=+iaS --extra=+q --sort=1 --exclude=\*.qml \
	    --exclude=\*.swp /home/racev/Qt/5.12.0/Src/qtbase \
	    /home/racev/Qt/5.12.0/Src/qtserialport \

ctags-clean-qt:
	rm -vf /home/racev/Qt/5.12.0/Src/ctags

ctags:
	# @ctags -R --c++-kinds=+p --fields=+iaS --extra=+q . /usr/include
	ctags -R --languages=C,C++ --c++-kinds=+p --fields=+iaS \
	    --extra=+q --sort=1 --exclude=\*.qml --exclude=\*.swp

ctags-clean:
	rm -f ctags

handlers-clean:
	rm -f can/handlers/dynamic/release/*.o
	rm -f can/handlers/dynamic/debug/*.o
	rm -f can/handlers/static/release/*.o
	rm -f can/handlers/static/debug/*.o
