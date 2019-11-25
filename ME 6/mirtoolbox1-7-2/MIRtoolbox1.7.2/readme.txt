Congratulations! You have downloaded MIRtoolbox 1.7.2
��������������������������

The list of new features and bug fixes offered by this new version is shown in the ReleaseNotes text file located in the toolbox folder, and also available from our website. New versions of the toolbox will also be released at the same address:
http://www.jyu.fi/hum/laitokset/musiikki/en/research/coe/materials/mirtoolbox

Please inform me if you find any bug when using the toolbox.

**

Conditions of Use
-----------------





**

Please register to the MIRtoolbox announcement list.�
--------------------------------------------
http://www.freelists.org/list/mirtoolboxnews
--------------------------------------------
This will allow us to estimate the number of users, and this will allow you in return to get informed on the new major releases (including critical bug fixes).

**

MIRtoolbox requires Matlab version 7 and Mathworks' Signal Processing toolbox.

**

This distribution actually includes four different toolboxes:

- the MIRtoolbox itself, version 1.7.2,

- the Auditory toolbox, version 2, by Malcolm Slaney
(also available directly at http://cobweb.ecn.purdue.edu/~malcolm/interval/1998-010/),

- the Netlab toolbox, version 3.3, by Ian Nabney
(also available directly at http://www.ncrg.aston.ac.uk/netlab/)

- the SOM toolbox, version 2.0, by Esa Alhoniemi, Johan Himberg, Jukka Parviainen and Juha Vesanto
(also available directly at http://www.cis.hut.fi/projects/somtoolbox/)

**

MIRtoolbox license is based on GPL 2.0. As such, it can integrate codes from other GPL 2.0 projects, as long as their origins are explicitly stated.


- openbdf and readbdf script by T.S. Lorig to read BDF files, based on openedf and readedf by Alois Schloegl

- implementation of Earth Mover Distance written by Yossi Rubner and wrapped for Matlab by Simon Dixon

Code integrated with BSD license:

- aiffread by Kenneth Eaton
- convolve2 by David Young

**

To install MIRtoolbox in your Matlab environment, copy all the toolboxes folders (or only those that are not installed yet in your computer) into your Matlab "toolbox" folder. Then add each folder in your Matlab path.

**

NOTICE: If you replace an older version of MIRtoolbox with a new one, please update your Matlab path using the following command:
rehash toolboxcache
Update also the class structure of the toolbox, either by restarting Matlab, or by typing the following command:
clear classes

**

To get an overview of the functions available in the toolbox, type:
help mirtoolbox

A complete documentation in PDF is provided in the main toolbox folder. For absolute Matlab beginners, we suggest to read MIRtoolboxPrimer.

A short documentation for each function is available directly in Matlab using the help command. For instance: help miraudio

Examples of use of the toolbox are shown in the MIRToolboxDemos folder:
mirdemo
demo1basics
demo2timbre
demo3segmentation
demo4tempo
demo5export
demo6curves
demo7tonality
demo8classification
demo9retrieval