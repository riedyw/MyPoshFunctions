#source: https://powershell.org/2013/04/29/powershell-popup/

Function New-Popup {
<#
.SYNOPSIS
    New-Popup will display a popup message
.DESCRIPTION
    The New-Popup command uses the Wscript.Shell PopUp method to display a graphical message
    box. You can customize its appearance of icons and buttons. By default the user
    must click a button to dismiss but you can set a timeout value in seconds to
    automatically dismiss the popup.

    The command will write the return value of the clicked button to the pipeline:
    OK     = 1
    Cancel = 2
    Abort  = 3
    Retry  = 4
    Ignore = 5
    Yes    = 6
    No     = 7

    If no button is clicked, the return value is -1.
.EXAMPLE
    new-popup -message "The update script has completed" -title "Finished" -time 5

    This will display a popup message using the default OK button and default
    Information icon. The popup will automatically dismiss after 5 seconds.
.EXAMPLE
    $answer = new-popup -Message "Please pick" -Title "form" -buttons "OKCancel" -icon "information"

    If the user clicks "OK" the $answer variable will be equal to 1. If the user clicks "Cancel" the
    $answer variable will be equal to 2.
.NOTES
    Last Updated: 6/17/2018
    Version     : 3.1
.PARAMETER Message
    The message you want displayed
.PARAMETER Title
    The text to appear in title bar of dialog box
.PARAMETER Time
    The time to display the message. Defaults to 0 (zero) which will keep dialog open until a button is clicked
.PARAMETER  Buttons
    Valid values for -Buttons include:
    "OK"
    "OKCancel"
    "AbortRetryIgnore"
    "YesNo"
    "YesNoCancel"
    "RetryCancel"
.PARAMETER  Icon
    Valid values for -Icon include:
    "Stop"
    "Question"
    "Exclamation"
    "Information"
    "None"
.INPUTS
    None
.OUTPUTS
    An integer with the following value depending upon the button pushed.

    Null   = -1    # Value when timer finishes countdown.
    OK     =  1
    Cancel =  2
    Abort  =  3
    Retry  =  4
    Ignore =  5
    Yes    =  6
    No     =  7
.LINK
    Wscript.Shell
#>

#region Parameters
    [CmdletBinding()]
    [OutputType([int])]
    Param (
        [Parameter(Position=0,Mandatory=$True,HelpMessage="Enter a message for the popup")]
        [ValidateNotNullorEmpty()]
        [string] $Message,

        [Parameter(Position=1,Mandatory=$True,HelpMessage="Enter a title for the popup")]
        [ValidateNotNullorEmpty()]
        [string] $Title,

        [Parameter(Position=2)]
        [ValidateScript({$_ -ge 0})]
        [int] $Time=0,

        [Parameter(Position=3)]
        [ValidateNotNullorEmpty()]
        [ValidateSet("OK","OKCancel","AbortRetryIgnore","YesNo","YesNoCancel","RetryCancel")]
        [string]$Buttons="OK",

        [Parameter(Position=4)]
        [ValidateNotNullorEmpty()]
        [ValidateSet("Stop","Question","Exclamation","Information","None" )]
        [string]$Icon="Information"
    )
#endregion Parameters

    #convert buttons to their integer equivalents
    Switch ($Buttons) {
        "OK"               {$ButtonValue = 0}
        "OKCancel"         {$ButtonValue = 1}
        "AbortRetryIgnore" {$ButtonValue = 2}
        "YesNo"            {$ButtonValue = 4}
        "YesNoCancel"      {$ButtonValue = 3}
        "RetryCancel"      {$ButtonValue = 5}
    }
    #set an integer value for Icon type
    Switch ($Icon) {
        "Stop"        {$iconValue = 16}
        "Question"    {$iconValue = 32}
        "Exclamation" {$iconValue = 48}
        "Information" {$iconValue = 64}
        "None"        {$iconValue = 0}
    }
    #create the COM Object
    Try {
        $wshell = New-Object -ComObject Wscript.Shell -ErrorAction Stop
        #Button and icon type values are added together to create an integer value
        $wshell.Popup($Message,$Time,$Title,$ButtonValue+$iconValue)
    }
    Catch {
        #You should never really run into an exception in normal usage
        Write-Warning -Message "Failed to create Wscript.Shell COM object"
        Write-Warning -Message ($_.exception.message)
    }
} #EndFunction New-Popup

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'New-Popup'
    $FuncAlias       = ''
    $FuncDescription = 'Creates a new message dialog box'
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
