Function New-Inputbox {

<#
.Synopsis
Display a Visual Basic style inputbox.
.Description
This function will display a graphical Inputbox, like the one from VisualBasic
and VBScript. You must specify a messag prompt. You can specify a title, the 
default is "Input". You can also specify a default value. The inputbox will write
whatever is entered into it to the pipeline. If you click Cancel the inputbox
will still write a string to the pipeline with a length of 0. It is recommended
that you validate input.

.Example
PS C:\> $c = New-Inputbox -prompt "Enter the Netbios name of a domain computer." -title "Enter a computername" -default $env:computername
PS C:\> get-service -computer $c
.Notes
Last Updated:
Version     : 0.9

.Inputs
None

.Outputs
[string]

#>
[cmdletbinding()]

Param (
[Parameter(Position=0,Mandatory,HelpMessage="Enter a message prompt")]
[ValidateNotNullorEmpty()]
[string]$Prompt,
[Parameter(Position=1)]
[string]$Title="Input",
[Parameter(Position=2)]
[string]$Default

)

Try { 
    Add-Type -AssemblyName "microsoft.visualbasic" -ErrorAction Stop 
    [microsoft.visualbasic.interaction]::InputBox($Prompt,$Title,$Default)
}
Catch {
    Write-Warning -Message "There was a problem creating the inputbox"
    Write-Warning -Message $_.Exception.Message
}

} #end New-Inputbox

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'New-InputBox'
    $FuncAlias       = ''
    $FuncDescription = 'Creates a simple input box.'
    $FuncVarName     = ''
    if (-not (test-path -Path Variable:AliasesToExport))
    {
        $AliasesToExport = @()
    }
    if (-not (test-path -Path Variable:VariablesToExport))
    {
        $VariablesToExport = @()
    }
    if ($FuncAlias)
    {
        set-alias -Name $FuncAlias -Value $FuncName
        $AliasesToExport += $FuncAlias
    }
    if ($FuncVarName)
    {
        $VariablesToExport += $FuncVarName
    }
    # Setting the Description property of the function.
    (get-childitem -Path Function:$FuncName).set_Description($FuncDescription)
#endregion Metadata
