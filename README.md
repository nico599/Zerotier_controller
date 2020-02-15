Zerotier_controller
---------------------

This applet allows you to control whether Zerotier is running or not, will stop the process, the background service, and the virtual device.

This simple applet will determine if Zerotier is running and can either stop or start it. The applet is a combination of two scripts. The first `Run_ZeroTier` works as a wrapper executing the second. This is to allow users to stay safe and not change their global script execution settings which you'd otherwise be forced to do.

Requirements:
- Windows 10 x64
- PowerShell

How To:

To use this you simply need to place the reference script anywhere you like for example in your Documents folder. Then keep the Run_ZeroTier handy somewhere like the Desktop. Edit and fix the path variable within the `Run_ZeroTier` file to ensure it points to the location of your `Run_ZeroTier` file.

The `Run_ZeroTier.ps1` file should be updated to check/correct the path variable.

Enjoy.
