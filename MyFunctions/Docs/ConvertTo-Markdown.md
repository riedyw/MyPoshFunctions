---
external help file: MyFunctions-help.xml
Module Name: MyFunctions
online version:
schema: 2.0.0
---

# ConvertTo-Markdown

## SYNOPSIS
Convert pipeline output to a markdown document.

## SYNTAX

```
ConvertTo-Markdown [[-Inputobject] <Object>] [-Title <String>] [-PreContent <String[]>]
 [-PostContent <String[]>] [-Width <Int32>] [<CommonParameters>]
```

## DESCRIPTION
This command is designed to accept pipelined output and create a markdown document.
The pipeline output will formatted as a text block.
You can optionally define a title, content to appear before the output and content to appear after the output.
The command does not create a text file.
You need to pipe results from this command to a cmdlet like Out-File or Set-Content.
See examples.

## EXAMPLES

### EXAMPLE 1
```
Get-Service Bits,Winrm | Convertto-Markdown -title "Service Check" -precontent "## $($env:computername)" -postcontent "_report $(Get-Date)_"
```

# Service Check
## THINK51
\`\`\`text
 Status   Name               DisplayName
 ------   ----               -----------
 Running  Bits               Background Intelligent Transfer Ser...
 Running  Winrm              Windows Remote Management (WS-Manag...
\`\`\`
_report 07/20/2018 18:40:52_

### EXAMPLE 2
```
Get-Service Bits,Winrm | Convertto-Markdown -title "Service Check" -precontent "## $($env:computername)" -postcontent "_report $(Get-Date)_" | Out-File c:\work\svc.md
```

Re-run the previous command and save output to a file.

### EXAMPLE 3
```
$computers = "srv1","srv2","srv4"
```

PS C:\\\> $Title = "System Report"
PS C:\\\> $footer = "_report run $(Get-Date) by $($env:USERDOMAIN)\$($env:USERNAME)_"
PS C:\\\> $sb =  {
\>\> $os = get-ciminstance -classname win32_operatingsystem -property caption,lastbootUptime
\>\> \[PSCustomObject\]@{
\>\> PSVersion = $PSVersionTable.PSVersion
\>\> OS = $os.caption
\>\> Uptime = (Get-Date) - $os.lastbootUpTime
\>\> SizeFreeGB = (Get-Volume -DriveLetter C).SizeRemaining /1GB
\>\> }
\>\> }
PS C:\\\> $out = Convertto-Markdown -title $Title
PS C:\\\> foreach ($computer in $computers) {
\>\>  $out+= Invoke-command -scriptblock $sb -ComputerName $computer -HideComputerName |
\>\>  Select-Object -Property * -ExcludeProperty RunspaceID |
\>\>  ConvertTo-Markdown -PreContent "## $($computer.toUpper())"
\>\> }
PS C:\\\>$out += ConvertTo-Markdown -PostContent $footer
PS C:\\\>$out | set-content c:\work\report.md
Here is an example that create a series of markdown fragments for each computer and at the end creates a markdown document.

## PARAMETERS

### -Inputobject
{{Fill Inputobject Description}}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Title
Specify a top level title.
You do not need to include any markdown.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PreContent
Enter whatever content you want to appear before converted input.
You can use whatever markdown you wish.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PostContent
Enter whatever content you want to appear after converted input.
You can use whatever markdown you wish.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Width
Specify the document width.
Depending on what you intend to do with the markdown from this command you may want to adjust this value.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 80
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### [object]

## OUTPUTS

### System.String[]

## NOTES
Learn more about PowerShell: https://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Convertto-HTML]()

[Out-File]()

