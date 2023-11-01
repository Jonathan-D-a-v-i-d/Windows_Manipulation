# Windows_Manipulation
This repo was created whilst having to find ways to manipulate ancient Windows applications in closed network environments where modern high level languages were off the table.

For example, imagine not only not having an API (Let alone not being able to build one with Postman since the app isn't Web based), but not being able to use modern 
languages with their rich libraries like Python, Node JS, Go, etc.

# What does it consist of? 
Essentially, this repo uses C# and type assemblies to create .Net classes which we then use in Powershell Cmdlets. 
More specifically, I create easily readable/usable Cmdlets using these obscure low level references 
so that the end user can benefit through easy implementation.
In other words, I want basic PowerShell users to have fun with this.
*  Get-MouseCoordinates
*  Click-MouseLeft
*  Click-MouseRight
*  DoubleClick-Mouse
*  Send-Key
*  Copy-Text




# For Linkedin

Shalom Everyone. As we endure these tough times, and many of 
us are called to arms as reservists, it's on us to share with eachother
things we learn along the way.

In my platoon, we are tech focused. A need arose for many reports
due to the national security situation known as Swords of Steel.

As a result, many of these reports came to fruition through 
automations created by the mass impact of reservists coming 
from the civilan high tech realms.

--------
Problem:
--------
Many programs used in the IDF aren't designed
to be manipulated by high level languages like Python, Nodejs and Go.
--------
Solution: 
--------
Having unwillingly dived into C# to create .Net classes, finally 
wrapping the functionality in simple PowerShell Cmdlets, I found ways 
to interact with archaic applications through the GUI when API's
aren't an option...it worked!

I'm sharing this PowerShell Module for any who wish to 
interact with all windows .exe applications straight through 
the GUI through mouseclicks, key-sends and clipboard copies 
so that basic PowerShell goers can enjoy the same efficiency and
contribute to their units. 

All that's needed is Powershell 5.1 with no third party modules.

#AmIsraelChai
#Beyachad Nenatsech



