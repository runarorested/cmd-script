# which command line tool

"which" is a command line tool (scriptlet) that locates the EXECUTABLE file that would have been called by exploring the directories in the PATH.
This function is usually OS dependant, usually due tho the native file sistem used:

Depending of the OS used, the files are marked as executables either with:
* adding a known file extensions to its name (like Microsoft's does in MS-DOS/Windows) 
* associating an execution file attribute/permission/metadata at the file (done in UNIX-variants like Linux/Android/BSD/others).

The equivalent in different OS are:
1. **'which' for GNU Unix variants**: the executables are marked by an execution permission/attribute, so you the tool need only to look for the file named, exactly as specified, in any of the parts of the PATH. 'which' returns the pathnames of the files (or links) which would be executed in the current environment, had it been given as commands. It does search the current directory and other PATH directories for an executable file matching the name of the argument. It does NOT canonicalize path names (resolving symlinks).
2. **'where.exe' for Windows**: It is Win32 equivalent, available from Windows 2003 Server and its succesors. 2000/XP does not have it available by default but can be installed from the Windows 2003 Resource Kit. Availability and working status on previous Windows NT versiones (NT 3.1, NT 4.0) is unknown. Windows 95/98/Me does not have it, probably unneded due the hardcoded limitations still inherited from DOS and COMMAND.COM command line interpreter, and the lack of "cmd.exe" port for the OS.
3. **TRUENAME for MS-DOS**: TRUENAME does not find the file, only translates virtual paths (subst/join) into real ones. So if you call "TRUEPATH FC", from C:\USER, it will return C:\USER\FC.EXE because you can execute it from the current directory due to it beingh in the PATH, instead of the expected answer of C:\DOS\FC.EXE. In other words, it will not locate it but it will show if it is available in the path without executing it.


### Self-reminder notes:
* Do not mix-up with Unix' [whereis](http://man7.org/linux/man-pages/man1/whereis.1.html) with [which](https://manpages.debian.org/stretch/debianutils/which.1.en.html) or where.exe.

### Documentation:
1. [which equivalents](https://stackoverflow.com/questions/304319/is-there-an-equivalent-of-which-on-the-windows-command-line).
2. [which tool](https://en.wikipedia.org/wiki/Which_%28Unix%29)
3. [which man page](https://manpages.debian.org/stretch/debianutils/which.1.en.html)
4. [GNU which for Win32](http://gnuwin32.sourceforge.net/packages/which.htm)
5. [How does %%PATH%% works on DOS\Windows](https://stackoverflow.com/questions/1653472/whats-the-relative-order-with-which-windows-search-for-executable-files-in-path)
6. [TRUENAME undocumented command for MS-DOS](https://en.wikipedia.org/wiki/List_of_DOS_commands#TRUENAME)
