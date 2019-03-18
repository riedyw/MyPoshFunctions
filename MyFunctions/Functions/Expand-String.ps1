function Expand-String 
{ 
   param( 
       [Parameter(Mandatory=$true,Position=0,ValueFromPipeline=$true)] 
       [System.String]$Value,

       [switch]$EnvironmentVariable 
   )

   if($EnvironmentVariable) { 
      [System.Environment]::ExpandEnvironmentVariables($Value) 
   } 
   else 
   { 
      $ExecutionContext.InvokeCommand.ExpandString($Value) 
   } 
} 

<# 
## Usage ## 

# expand single quote strings 
PS > $ps = Get-Process -Id $PID 
PS > Expand-String -Value 'Process name: $($ps.name)'
Process name: powershell

# expand DOS Environment Variables 
PS > Expand-String -Value "%USERNAME%\%USERDOMAIN%" -EnvironmentVariable 
User1\Domain.com

# piping values 
PS > '%USERNAME%\%USERDOMAIN%'| Expand-String -EnvironmentVariable 
User1\Domain.com

PS > 'Process name: $($p.name)' | Expand-String 
Process name: powershell

 #>

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Expand-String'
    $FuncAlias       = ''
    $FuncDescription = 'Writes variable out to INI file'
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
