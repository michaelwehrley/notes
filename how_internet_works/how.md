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
