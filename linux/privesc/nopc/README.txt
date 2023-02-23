NOPC

What is it?
-----------

NOPC (Nessus-based Offline Patch Checker) is a patch-checker for primarily Linux distribution and UNIX-based systems.
It is a shell script that utilises Nessus’ nasls and gives instructions on what data is needed to be obtained from the system to perform to derive a list of missing security patches. This was developed for situations when network connectivity to the systems under review is not possible.


Latest Version
--------------

Details of the latest version can be found at the following URL:
https://labs.portcullis.co.uk/tools/nopc/


Notes
-----
Should be able to run nopc.sh under Linux/Unix where Nessus has been installed.
If non-standard installation of Nessus or Mac OS X, need to define location of:
* nasl command line (option n)
* nasl plugins directory (option d)
Please see examples for more details.

Interactive mode where no options supplied with nopc.sh is self-explanatory.
It also gives a command line in case you want to repeat without interactive mode.
Examples of these shortcuts can be see under examples.


Usage
-----
/opt/bin/nopc.sh [Options]
OPTIONS:
  -?: This usage page
  -d: Location of Nessus Plugins directory
  -n: Location of nasl program directory
  -s: System Type (with optional arguments)
  -l: Output Type
  -v: Version of NOPC

Where system type is one of:
 1 - AIX
 2 - HP-UX
 3 - MacOS X *
 4 - Solaris (!11) *
 5 - Debian
 6 - FreeBSD
 7 - Gentoo
 8 - Mandrake
 9 - Redhat
 10 - Redhat (Centos)
 11 - Redhat (Fedora)
 12 - Slackware
 13 - SuSE *
 14 - Ubuntu
 15 - Cisco IOS/ASA *

 * EXPERIMENTAL!!

Where output type is one of:
 0 - Displays Outdated Packages only
 1 - Displays NASL name and Outdated Packages
 2 - CSV output of CVE, KB and description (comma)
 3 - CSV output of CVE, CVSSv2, Severity, KB, Description (comma)
 4 - CSV output of CVE, KB and description (tab)
 5 - CSV output of CVE, CVSSv2, Severity, KB, Description (tab)


Examples
--------
# Use following if path to nasl command line and plugin directory not default
# Note: This is "interactive mode"
$ nopc.sh -d '/tmp/local-plugins'
$ nopc.sh -n '/local/bin/nasl'
$ nopc.sh -d '/tmp/local-plugins' -n '/local/bin/nasl'

# Use this to output Ubuntu missing patches in raw format (quick).
$ nopc.sh -l '0' -s '14' 'patch-ubuntu-krb5-1.txt' '10.04' 'x86_64'

# Use this to output Ubuntu missing patches in a csv format with CVE/Description.
$ nopc.sh -l '2' -s '14' 'patch-ubuntu-krb5-1.txt' '10.04' 'x86_64'

# Use this to output Ubuntu missing patches in a detailed csv format
$ nopc.sh -l '3' -s '14' 'patch-ubuntu-krb5-1.txt' '10.04' 'x86_64'

# To search plugins from current directory
# Use this to output Ubuntu missing patches in a csv format with CVE/Description.
$ nopc.sh -l '2' -s '14' -d '.' -n '/opt/nessus/bin/nasl' 'patch-ubuntu-1.txt' '10.04' 'i686'

# Use this to output Ubuntu missing patches in a detailed csv format
$ nopc.sh -l '3' -s '14' -d '.' -n '/opt/nessus/bin/nasl' 'patch-ubuntu-1.txt' '10.04' 'i686'

