---
external help file: MyFunctions-help.xml
Module Name: MyFunctions
online version:
schema: 2.0.0
---

# Get-Share

## SYNOPSIS
To get information about shares on the local computer

## SYNTAX

```
Get-Share [[-ShareName] <String>] [-IgnoreAdmin] [[-Types] <Array>] [<CommonParameters>]
```

## DESCRIPTION
To get information about shares on the local computer

## EXAMPLES

### EXAMPLE 1
```
Get-Share
```

Would return:
A listing of all of the shares

### EXAMPLE 2
```
Get-Share -ShareName "My"
```

Would return:
A listing of all of the shares that contain the string "My"

### EXAMPLE 3
```
Get-Share -ShareName -IgnoreAdmin
```

Would return:
A listing of all of the shares minus the automatic Admin shares

## PARAMETERS

### -ShareName
The name or partial name of the share.
No wildcards are needed.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: *
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -IgnoreAdmin
To ignore any default admin shares such as Admin$, C$, IPC$

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

### -Types
A string, or an array of the types of shares you want to view.
Valid types include: Disk, Print, DiskAdmin, PrintAdmin, IPCAdmin, Device, DeviceAdmin

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### An array of objects containing the fields ComputerName, ShareName, Path, Type, Status

## NOTES
Author:     Bill Riedy
Version:    1.0
Date:       2018/03/15
Notes:      Added functionality to test if Powershell version 2 as that does not have -in or -notin operators

## RELATED LINKS
