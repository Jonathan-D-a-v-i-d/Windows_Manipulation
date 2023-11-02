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

