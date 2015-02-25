files in this directory:
test-amoeba.c: test program for Amoeba optimizer in GSL.
amoeba.vcproj: instructions to compile on Windows
Makefile: instructions to compile on Linux
readme.txt: this file

Instructions to install GSL on Linux:
http://www.gnu.org/software/gsl/

Instructions to install GSL on Windows:
1. Install from:
http://gnuwin32.sourceforge.net/packages/gsl.htm
Run the two setup files under the description: 
'Complete package, except sources' and  'Sources'
Your browser may block the setup files from running. Unblock them.
Look for a blocking notification bar at the top of the page.

If you want to create your own project you need to include the directory
"C:\Program Files\GnuWin32\include\" - this is the default location where it
installs. You also need to include the libraries  - 'libgsl.a' and
'libgslcblas.a' under additional dependencies and include  the library
directory path - ""C:\Program Files\GnuWin32\lib" .
