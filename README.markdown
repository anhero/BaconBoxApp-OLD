RedBox Application Project
==========================
*Version: Development snapshot*

This project is a template project to make a game using the RedBox Engine.

For any help, you can go to [the website](http://redboxengine.com), which is
the documentation website or you can use [our forums](http://anhero.net/forum/)
and make your mark in the community.

When you find a bug with our engine or anything we do, you should post a bug
report on [our bug tracker](http://bugs.anhero.net/).

License information
===================
For license details about RedBox, see the wiki or the license.txt file.

The example main.cpp file is released as either Public Domain or MIT License,
whichever better fits your needs.

More details
============

How to use
----------
A release of this project should include the pre-built RedBox library and all
the necessary components.

To use the RedBox Engine with this project, you only need to find a project
matching your favorite IDE in the ide folder. From there, you should only need
to start coding and compiling using your IDE, nothing more.

If you are using linux or another unix-like platform, you can make use of cmake
to compile using a Makefile.

Folder structure
----------------
	/application/    -> Your game code goes there.
	    main.cpp     -> Startup point of the program and configurations for
	                    RedBox are made there.

	/resources/      -> Your resources goes there. (e.g Sounds, Art, etc.)

	/ide/            -> The project templates are found there. You should only
	                    have to open them with your IDE and start coding.
	                    The folders are named following this convention:
	                                  [IDE NAME]-[PLATFORM]
	                    When a project file is platform agnostic (works on
	                    windows, linux and osx, for example) it will only be
	                    named after the IDE.

	/libraries/      -> This is where the local libraries are.
	                    (generally this means RedBox and sigly)
