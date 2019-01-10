**The Question: What does `Rack::Timeout::RequestTimeoutException: Request waited 4ms, then ran for longer than 20000ms` mean and how do we solve it?**

This I found it is a loaded question:

1. What is a timeout?
1. How does a timeout happen?
1. What is a db connection?
1. When do connections happen?
1. How do we create more connections?
1. What is a process vs a thread?
1. What is an operating system?
1. And with in all ^, what is a web server?
1. Why choose Puma vs Mongrel vs Webrick vs NGinx vs Apache vs. Makara vs Rack 
1. How to test this in Ruby or wait, JRuby?
1. IPSocket vs TCPSocket and UDPSocket (IPSocket is the super class of TCPSocket and UDPSocket)
1. What is an image, Heroku stack, serialization

## Operating System
	* [https://en.wikipedia.org/wiki/Operating_system](https://en.wikipedia.org/wiki/Operating_system)
	* Microsoft Windows
	* Unix-based
		* Max OS X (BSD)
		* Linux
	* Android
	* iOS
	* Symbian

## Heroku
	Overview: `app`=( buildpack )=>`slug`=( procfile )=>`container`
	* all run on a virtual machine on an e2 instance

 `Your App - Deploy`

 `app=( buildpack/ruby )=>slug=>`

 	```
 	* preboot is already enabled.
	* Deploying master to production
	* Counting objects: 17, done.
	* Delta compression using up to 8 threads.
	* Compressing objects: 100% (12/12), done.
	* Writing objects: 100% (16/16), 2.14 KiB | 2.14 MiB/s, done.
	* Total 16 (delta 13), reused 4 (delta 4)
	* remote: Compressing source files... done.
	* remote: Building source:
	* remote: -----> Deleting 1 files matching .slugignore patterns.
	* remote: -----> Node.js app detected
	* remote:
	* remote: -----> Creating runtime environment
	* remote:
	* remote:        FOO_CONFIG_LOGLEVEL=error
	* remote:        BAR_VERBOSE=false
	* remote:
	* remote: -----> Installing binaries       
	* remote: -----> Restoring cache   
	* remote: -----> Building dependencies
	* remote: -----> Caching build
	* remote: -----> Pruning devDependencies
	* remote: -----> Build succeeded!
	* remote: -----> PhantomJS app detected
	* remote: -----> Extracting PhantomJS 2.1.1 binaries to /tmp/build_foo/vendor/* phantomjs
	* remote: -----> exporting PATH and LIBRARY_PATH
	* remote: -----> Ruby app detected
	* remote: -----> Compiling Ruby/Rails
	* remote: -----> Using Ruby version: ruby-2.3.2
	* remote: -----> Installing dependencies using bundler 1.15.2
	* remote: -----> Detecting rake tasks
	* remote: -----> Preparing app for Rails asset pipeline
	* remote: -----> Detecting rails configuration
	* remote: -----> Discovering process types
	* remote:        Procfile declares types     -> foo, bar, web, worker
	* remote:        Default types for buildpack -> console, rake
	* remote: -----> Compressing...
	* remote:        Done: 100.M
	* remote: -----> Launching...
	* remote:        https://foo.herokuapp.com/ deployed to Heroku
	* remote: Verifying deploy... done.
	```

 `Slug`:
 	* `.slugignore` & limited ot 15 minutes & maximum of 500 MB.
	* app + dependencies + language runtime;
 	* compressed and pre-packaged copy of your application (i.e., images). 

 `Container` (isolated environments)
 	* Not a virtual machine!
 	* Has many dynos, i.e., processes that are running (Procfile)

 `Dyno`
 	* https://www.heroku.com/dynos
  * lightweight, *Linux* isolated environments that provide compute, memory, an OS, and an ephemeral filesystem
 	* (?i.e., JAR file in Java to execute on JVM) builds a _Virtual Machine_ *Image*?)

 `=( Procfile command )=>` to specify the Dynos needed for the application:

 Slug.new (i.e., Dyno w/ 1 process)
 	- Dyno is a virtualized Unix container
 	- Think of a running dyno as a lightweight, secure, virtualized Unix container that contains your application slug in its file system.

## Heroku II
	Heroku maintains a stack (i.e., an operating system) for applications.
	* It uses a buildpack for allowing an application to be executed on a certain stack. A _stack_ is an operating system _image_ that is curated and maintained by Heroku. Stacks are typically based on an existing open-source Linux distribution, such as Ubuntu. Heroku applications target a specific stack, and _buildpacks_ are responsible for transforming an app’s source code into an _executable package_ that is compatible with that stack.
		* Images
			- In computing, a system image is a serialized copy of the entire state of a computer system stored in some non-volatile form such as a file. A system is said to be capable of using system images if it can be shut down and later restored to exactly the same state. In such cases, system images can be used for backup.
				- serialization: The process of translating data structures or object state into a format that can be stored (for example, in a file or memory buffer) or transmitted (for example, across a network connection link) and reconstructed later (possibly in a different computer environment).
			- *Hibernation* is an example that uses an image of the entire machine's RAM.
			- A process image is a copy of its state at a given point in time. It is often used for persistence. A common example is a database management system (DBMS). Most DBMS can store the state of its database or databases to a file before being closed down (see database dump). The DBMS can then be restarted later with the information in the database intact and proceed as though the software had never stopped.

### Roles

#### Abstraction (simplies hardware)
	* Process
	* Threads
	* Memory Management
		* Memory Page (i.e., virtual page/memory)
		* Memory Frame (i.e., physical page/memory)
	* File
	* Socket (network requests)

	* supports different types of speakers
	* interchangeable access of hard disk or SSD
	* Maintains a higher level of abstraction
	* Hides hardware complexity from application and application developer
	* Read/write files
	* Send/receive socket networks
	* Resouce management
		- Has privileged access to hardward
		- Memory management (protect data and isolation of memory)
		- CPU scheduling
		- Storage
		- hide hardward compexity

#### Mechanisms
	* Allocate memory to a process - map it via memory page (virtual memory to a DRAM)
	* Create (i.e., start an application)
	* Schedule (i.e., schedule a process to run on a CPU)
	* Open (give access to a devise)
	* Write (i.e, to a device)

#### Policies
	* SWAPing: Determine how mechanisms will be used to manage hardware such as memory (i.e., determine where should something be stored)
	* _Control how many sockets an individual process has access to._
	* Least-recent userd (LRU)
	* Earliest deadline first (EDF)

#### Arbitration
	* Manages hardware (i.e., distribute memory between multiple processes)

## Diagram

======== User ========

======== Application Software ========

* iTunes
* iCalendar
* Chrome
* Heroku slug (buildpacks are used to build/compile a slug that is then executed on a dyno)

	+------------------+ 
	| System Softwares | 
	+------------------+ 

======== Operating System =========================================
	* Unix
	* Linux/Ubuntu
		- Heroku calls this a *stack* - a operating system image
			- Cedar-14 (Ubuntu 14.04)
			- Heroku-16 (Ubuntu 16.04)
			- Heroku-18 (Ubuntu 18.04)
			- Container (Docker)
	* Microsoft Windows
	* Android

======== Hardware =========================================
		
	+-----
	| CPU 
	| * multiple (multiple processing elements)

	+-----
	| Memory
	| * RAM
	|	* DRAM
	| * Disk

	+-----
	| Ethernet/Wifi Card 

	+-----
	| Graphics Processing Card (GPU)

	+---
	| USB

	+-
	| Thunderbolt 3 

	+------
	| I/O

## Threads and Ruby

## Process

`ps -a`

`-a`: Display information about other users' processes as well as your own.  This will skip any processes which do not have a controlling terminal, unless the -x option is also specified.

`-x`: When displaying processes matched by other options, include processes which do not have a controlling terminal.  This is the opposite of the -X option.  If both -X and -x are specified in the same command, then ps will use the one which was specified last.

### What is process?

### What does a process look like

### Memory

Both RAM and hard drive memory are referred to as memory, which often causes confusion. RAM stands for Random Access Memory. Physically, it is a series of chips in your computer. When your computer is turned on, it loads data into RAM. Programs that are currently running, and open files, are stored in RAM; anything you are using is running in RAM somewhere. As soon as the electricity to the RAM is cut, it forgets everything; that's why an unsaved document is lost if the computer locks up or there is a power failure. When you save a document it goes on a hard drive, or another type of media storage device. Typically, this type of storage is magnetic, and does not depend on electricity to remember what is written on it. However, it's much slower than RAM. The computer can access anything stored in RAM nearly instantly. Things on the hard drive need to be located, read and sent to RAM before they can be processed. If your computer says you are low on disk space you have too many programs or files on your computer. To correct this, you will need a new hard drive, or will need to uninstall unused programs or delete unneeded files off the computer. If your computer says you are low on memory, you have too many programs running, or your computer does not have the RAM needed to run the software you want to. Restarting your computer will clear the RAM and usually clears up 90% of low memory errors. If your computer has more RAM than the programs minimum requirements, and restarting the computer does not solve the problem, the error could be caused by a buffer overflow, or another technical issue that is outside the scope of this tutorial. [https://www.lehigh.edu/~inimr/computer-basics-tutorial/ramvsdiskspacehtm.htm]

#### Virtual Memory vs Memory

### DRAM vs RAM

DRAM: Dynamic RAM
SDRAM: Synchronous DRAM
Dual Data Rate DRAM
Single Data Rate DRAM

### History of HTTP
1. CERN httpd (later also known as W3C httpd)
2. NCSA HTTPd: among the earliest web servers developed, following Tim Berners-Lee's CERN httpd, Tony Sanders' Plexus server, and some others. It was for some time the natural counterpart to the *Mosaic* web browser (popularized internet protocols such as FTP) in the client–server World Wide Web. 
3. Apache HTTP Server: Originally based on the NCSA HTTPd server

```
 curl -I http://www.google.com | grep Set-Cookie
```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:--  0:00:01 --:--:--     0
Set-Cookie: 1P_JAR=2019-01-02-15; expires=Fri, 01-Feb-2019 15:06:26 GMT; path=/; domain=.google.com
Set-Cookie: NID=152=gzR5qnWyMIxP2N9wNm99HM4HKxVPRE8CkG_g5vYGOpyQVA_iHDxhRkmFmf3SXjGDIQd1GlFxQ-Qi922ruuu1EI-enFOvHT3l3EyLIqe5SHTGJFCCVJ4Z50dMOAYAjqoKgFcq49icU-iGRqMrOBT659nE2XQ0cJr3TVGSEzcwMvM; expires=Thu, 04-Jul-2019 15:06:26 GMT; path=/; domain=.google.com; HttpOnly

## Not Virtual Memory or Memory Addresses - IDs

`$ irb`
`2.6.0 :001 > class Foo; end; foo = Foo.new; foo`
` => #<Foo:0x00007ff11d085190>`
`2.6.0 :002 > foo.object_id`
` => 70336775465160`
`2.6.0 :003 > "00007ff11d085190".to_i(16)`
` => 140673550930320`
`2.6.0 :004 > foo.object_id * 2`
` => 140673550930320`
