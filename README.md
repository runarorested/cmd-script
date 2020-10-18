# Useful batch/scripts library for Cmd.exe
A collection of scripts for MS DOS\Windows' cmd.exe interpreter.

These command line scripts have been gleaned and collected from the internet, or built to satisfy my needs for an external command / script. The main reason for these scripts is that they can work with the system as-is, **requiring the least amount of installed files, or even none**, and therefore useful for installation / network scripts, or in business environments, where installation capabilities may be restricted. The majority of these scripts are under the [MIT license](LICENSE.md).



## Command list

### which

Script that replaces the Unix command which, which prints the full path of an executable file present in the *%PATH%*. It is useful to find the path of installed files, or detect if a different version of an expected command is executed when called.

[Help file](doc\which.md)



## Compatibility table



|               **Command** | **version** | command.com<br /><small>DOS / Win16 / Win32s</small><br /><small>Win9x / Win32c</small> | cmd.exe<br /><small>Win9x / Win32c</small> | cmd.exe<br /><small>NT&nbsp;4.0</small> | cmd.exe<br /><small>NT&nbsp;5.x (Windows 2000/XP)</small> | cmd.exe<br /><small>NT 6.x~10.x (Vista/7/8/8.1/10)</small> | powershell.exe<br /><small>NT 6.x~10.x (Vista/7/8/8.1/10)</small> |
| ------------------------: | :---------: | :----------------------------------------------------------: | :----------------------------------------: | :-------------------------------------: | :-------------------------------------------------------: | :--------------------------------------------------------: | :----------------------------------------------------------: |
| [which.cmd](doc\which.md) |     0.2     |                              ✗                               |                   &nbsp;                   |                 &nbsp;                  |                             ?                             |                             ✓                              |                              ✗                               |

