---
external help file: MyFunctions-help.xml
Module Name: MyFunctions
online version:
schema: 2.0.0
---

# ConvertTo-BinaryIPv4

## SYNOPSIS
Converts a Decimal IP address into a binary format.

## SYNTAX

```
ConvertTo-BinaryIPv4 [-IPAddress] <IPAddress[]> [-IncludeOriginal] [<CommonParameters>]
```

## DESCRIPTION
ConvertTo-BinaryIP uses System.Convert to switch between decimal and binary format.
The output from this function is dotted binary string.

## EXAMPLES

### EXAMPLE 1
```
ConvertTo-BinaryIPv4 -IPAddress 24.3.1.1
```

Would return
00011000.00000011.00000001.00000001

### EXAMPLE 2
```
ConvertTo-BinaryIPv4 -IPAddress 10.1.1.1,192.168.1.1  -verbose -IncludeOriginal
```

Would return
VERBOSE: IPv4Address entered \[10.1.1.1,192.168.1.1\]
VERBOSE: You selected to include original value in output
VERBOSE: Processing \[10.1.1.1\]
VERBOSE: Binary representation \[00001010.00000001.00000001.00000001\]

VERBOSE: Processing \[192.168.1.1\]
VERBOSE: Binary representation \[11000000.10101000.00000001.00000001\]
IPv4        Binary
----        ------
10.1.1.1    00001010.00000001.00000001.00000001
192.168.1.1 11000000.10101000.00000001.00000001

### EXAMPLE 3
```
"10.1.1.1","192.168.1.1" | ConvertTo-BinaryIPv4
```

Would return
00001010.00000001.00000001.00000001
11000000.10101000.00000001.00000001

## PARAMETERS

### -IPAddress
An IPv4 Address to convert.

```yaml
Type: IPAddress[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -IncludeOriginal
A switch indicating if you want to display original IPv4 address.
If true then it will output a PsObject with the property fields of IPv4 and Binary

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### An IPv4Address or array of IPV4Address'es

## OUTPUTS

### [pscustomboject]
[string]

## NOTES
NAME: ConvertTo-BinaryIPv4
AUTHOR: Bill Riedy
LASTEDIT: 06/13/2018

## RELATED LINKS

[[System.Net.IPAddress]]()

