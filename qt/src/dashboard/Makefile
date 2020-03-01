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

release:

debug:
# ( https://stackoverflow.com/a/6132843 )
	pushd .
	cd ./debug
	make
	popd

debug-clean:
	rm -f ./debug/*.o ./debug/*.cpp
# ( https://stackoverflow.com/a/6132843 )
	@#pushd .
	@#cd ./debug
	@#make clean
	@#popd

release-clean:
	rm -f ./release/*.o ./release/*.cpp

profile-clean:
	rm -f ./profile/*.o ./profile/*.cpp

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

clean: ctags-clean profile-clean release-clean debug-clean
	rm -f ./debug/dashboard ./debug/dashboard.debug
	rm -f ./release/dashboard

install:
	scp -p ./debug/dashboard racev@vtc6210bk:/home/racev/dashboard
	scp -p ./debug/dashboard.debug racev@vtc6210bk:/home/racev/dashboard.debug
	@# scp -p ./debug/dashboard_qmlcache.qrc racev@vtc6210bk:/home/racev/dashboard_qmlcache.qrc
