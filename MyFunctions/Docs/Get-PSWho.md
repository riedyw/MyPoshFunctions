---
external help file: MyFunctions-help.xml
Module Name: MyFunctions
online version:
schema: 2.0.0
---

# Get-PSWho

## SYNOPSIS
Get PowerShell user summary information

## SYNTAX

```
Get-PSWho [-AsString] [<CommonParameters>]
```

## DESCRIPTION
This command will provide a summary of relevant information for the current user in a PowerShell session.
You might use this to troubleshoot an end-user
problem running a script or command.
The default behavior is to write an object to the pipeline, but you can use the -AsString parameter to force the
command to write a string.
This makes it easier to use in your scripts with Write-Verbose.

## EXAMPLES

### EXAMPLE 1
```
Get-PSWho
```

User            : BOVINE320\Jeff
Elevated        : True
Computername    : BOVINE320
OperatingSystem : Microsoft Windows 10 Pro \[64-bit\]
OSVersion       : 10.0.16299
PSVersion       : 5.1.16299.64
Edition         : Desktop
PSHost          : ConsoleHost
WSMan           : 3.0
ExecutionPolicy : RemoteSigned
Culture         : en-US

### EXAMPLE 2
```
get-pswho
```

User            : jhicks
Elevated        : NA
Computername    : Bovine320
OperatingSystem : Linux 4.4.0-43-Microsoft #1-Microsoft Wed Dec 31 14:42:53 PST 2014
OSVersion       : Ubuntu 16.04.3 LTS
PSVersion       : 6.0.0-rc
Edition         : Core
PSHost          : ConsoleHost
WSMan           : 3.0
ExecutionPolicy : Unrestricted
Culture         : en-US

### EXAMPLE 3
```
get-pswho
```

User            : BOVINE320\Jeff
Elevated        : True
Computername    : BOVINE320
OperatingSystem : Microsoft Windows 10 Pro \[64-bit\]
OSVersion       : 10.0.16299
PSVersion       : 6.0.0-rc
Edition         : Core
PSHost          : ConsoleHost
WSMan           : 3.0
ExecutionPolicy : RemoteSigned
Culture         : en-US

### EXAMPLE 4
```
Get-PSWho -asString | Set-Content c:\test\who.txt
```

## PARAMETERS

### -AsString
Write the summary object as a string.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### none

## OUTPUTS

### [pscustomboject]
[string]

## NOTES
Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-CimInstance]()

[Get-ExecutionPolicy]()

[$PSVersionTable]()

[$Host]()

