$Mouse_Class = @'
using System;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Windows.Forms;
public class Click_Stuff
{
//https://msdn.microsoft.com/en-us/library/windows/desktop/ms646270(v=vs.85).aspx
[StructLayout(LayoutKind.Sequential)]
struct INPUT
{ 
    public int        type; // 0 = INPUT_MOUSE,
                            // 1 = INPUT_KEYBOARD
                            // 2 = INPUT_HARDWARE
    public MOUSEINPUT mi;
}

//https://msdn.microsoft.com/en-us/library/windows/desktop/ms646273(v=vs.85).aspx
[StructLayout(LayoutKind.Sequential)]
struct MOUSEINPUT
{
    public int    dx ;
    public int    dy ;
    public int    mouseData ;
    public int    dwFlags;
    public int    time;
    public IntPtr dwExtraInfo;
}

//This covers most use cases although complex mice may have additional buttons
//There are additional constants you can use for those cases, see the msdn page
const int MOUSEEVENTF_MOVED      = 0x0001 ;
const int MOUSEEVENTF_LEFTDOWN   = 0x0002 ;
const int MOUSEEVENTF_LEFTUP     = 0x0004 ;
const int MOUSEEVENTF_RIGHTDOWN  = 0x0008 ;
const int MOUSEEVENTF_RIGHTUP    = 0x0010 ;
const int MOUSEEVENTF_MIDDLEDOWN = 0x0020 ;
const int MOUSEEVENTF_MIDDLEUP   = 0x0040 ;
const int MOUSEEVENTF_WHEEL      = 0x0080 ;
const int MOUSEEVENTF_XDOWN      = 0x0100 ;
const int MOUSEEVENTF_XUP        = 0x0200 ;
const int MOUSEEVENTF_ABSOLUTE   = 0x8000 ;

const int screen_length = 0x10000 ;

//https://msdn.microsoft.com/en-us/library/windows/desktop/ms646310(v=vs.85).aspx
[System.Runtime.InteropServices.DllImport("user32.dll")]
extern static uint SendInput(uint nInputs, INPUT[] pInputs, int cbSize);

public static void LeftClickAtPoint(int x, int y)
{
    //Move the mouse
    INPUT[] input = new INPUT[3];
    input[0].mi.dx = x*(65535/System.Windows.Forms.Screen.PrimaryScreen.Bounds.Width);
    input[0].mi.dy = y*(65535/System.Windows.Forms.Screen.PrimaryScreen.Bounds.Height);
    input[0].mi.dwFlags = MOUSEEVENTF_MOVED | MOUSEEVENTF_ABSOLUTE;
    //Left mouse button down
    input[1].mi.dwFlags = MOUSEEVENTF_LEFTDOWN;
    //Left mouse button up
    input[2].mi.dwFlags = MOUSEEVENTF_LEFTUP;
    SendInput(3, input, Marshal.SizeOf(input[0]));
}

public static void RightClickAtPoint(int x, int y)
{
    //Move the mouse
    INPUT[] input = new INPUT[3];
    input[0].mi.dx = x*(65535/System.Windows.Forms.Screen.PrimaryScreen.Bounds.Width);
    input[0].mi.dy = y*(65535/System.Windows.Forms.Screen.PrimaryScreen.Bounds.Height);
    input[0].mi.dwFlags = MOUSEEVENTF_MOVED | MOUSEEVENTF_ABSOLUTE;
    //Left mouse button down
    input[1].mi.dwFlags = MOUSEEVENTF_RIGHTDOWN;
    //Left mouse button up
    input[2].mi.dwFlags = MOUSEEVENTF_RIGHTUP;
    SendInput(3, input, Marshal.SizeOf(input[0]));
}

}
'@
Add-Type -TypeDefinition $Mouse_Class -ReferencedAssemblies System.Windows.Forms,System.Drawing





###############################
    # FUNCTIONS TO EXPORT #
###############################
# - Get-MouseCoordinates
# - Click-MouseLeft
# - Click-MouseRight
# - DoubleClick-Mouse
# - Send-Key
# - Copy-Text



function Get-MouseCoordinates { # -- Works
    [CmdletBinding()]
    param()

    $mousePosition = [System.Windows.Forms.Cursor]::Position
    $coordinates = @{
        "Mouse X Coordinate" = $mousePosition.X
        "Mouse Y Coordinate" = $mousePosition.Y
    }
    return $coordinates
}


function Click-MouseLeft { # -- Works
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [int]$x,
        [Parameter(Mandatory=$true)]
        [int]$y
    )
    try {
        [Click_Stuff]::LeftClickAtPoint($x, $y)
        Write-Host "[*] Left-Clicked at point ($x,$y)" -ForegroundColor Green -BackgroundColor Black
    }
    catch {
        Write-Host "[!] Left Mouse click failed at points $x , $y" -ForegroundColor Red -BackgroundColor Black
        Write-Host $_.Exception.Message
    }
}


function Click-MouseRight { # -- Works
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [int]$x,
        [Parameter(Mandatory=$true)]
        [int]$y
    )
    try {
        [Click_Stuff]::RightClickAtPoint($x, $y)
        Write-Host "[*] Right-Clicked at point ($x,$y)" -ForegroundColor Green -BackgroundColor Black
    }
    catch {
        Write-Host "[!] Right Mouse click failed at points $x , $y" -ForegroundColor Red -BackgroundColor Black
        Write-Host $_.Exception.Message
    }
}



function DoubleClick-Mouse { # -- Works
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [int]$x,
        [Parameter(Mandatory=$true)]
        [int]$y
    )
    try {
        [Click_Stuff]::LeftClickAtPoint($x, $y)
        Start-Sleep -Milliseconds 100
        [Click_Stuff]::LeftClickAtPoint($x, $y)
        Write-Host "[*] Double-Clicked at point ($x,$y)" -ForegroundColor Green -BackgroundColor Black
    }
    catch {
        Write-Host "[!] Double Mouse click failed at points $x , $y" -ForegroundColor Red -BackgroundColor Black
        Write-Host $_.Exception.Message
    }
}



function Send-Key { # -- Works
    param(
        [Parameter(Mandatory=$true)]
        [string]$key
    )
    try {
        # Load the System.Windows.Forms assembly
        Add-Type -AssemblyName System.Windows.Forms
        # Send the key to the active application
        [System.Windows.Forms.SendKeys]::SendWait($key)
        Write-Host "[*] Sent key '$key'" -ForegroundColor Green -BackgroundColor Black
    }
    catch {
        Write-Host "[!] Failed to send key '$key'" -ForegroundColor Red -BackgroundColor Black
        Write-Host $_.Exception.Message
    }
}



function Copy-Text { # -- Works
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [int]$x,
        [Parameter(Mandatory=$true)]
        [int]$y
    )

    try {
        # Call the DoubleClick-Mouse function to perform a double-click at the specified point
        DoubleClick-Mouse -x $x -y $y

        # Call the Send-Key function to send the Ctrl+C key combination
        Send-Key '^c'

        # Wait for a moment to allow the text to be copied to the clipboard
        Start-Sleep -Milliseconds 500

        # Retrieve the text from the clipboard and store it in a variable
        $copiedText = Get-Clipboard

        # Return the copied text as a PowerShell object
        Write-Output "Copied this text: $copiedText"
    }
    catch {
        Write-Host "[!] Failed to copy text" -ForegroundColor Red -BackgroundColor Black
        Write-Host $_.Exception.Message
    }
}
