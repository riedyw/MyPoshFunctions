# source: https://www.powershellgallery.com/packages/RemoteRegistry/1.0.3/Content/Public%5CGet-RegExpandString.ps1

function Get-RegExpandString
{

    <# 
 .SYNOPSIS 
        Retrieves a null-terminated string that contains unexpanded references to environment variables (REG_EXPAND_SZ) from local or remote computers. 
 
 .DESCRIPTION 
        Use Get-RegExpandString to retrieve a null-terminated string that contains unexpanded references to environment variables (REG_EXPAND_SZ) from local or remote computers. 
         
 .PARAMETER ComputerName 
      An array of computer names. The default is the local computer. 
 
 .PARAMETER Hive 
     The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'. 
     Possible values: 
      
  - ClassesRoot 
  - CurrentUser 
  - LocalMachine 
  - Users 
  - PerformanceData 
  - CurrentConfig 
  - DynData          
 
 .PARAMETER Key 
        The path of the registry key to open. 
 
 .PARAMETER Value 
        The name of the registry value. 
 
 .PARAMETER ExpandEnvironmentNames 
       Expands values containing references to environment variables using data from the local environment. 
 
 .PARAMETER Ping 
        Use ping to test if the machine is available before connecting to it. 
        If the machine is not responding to the test a warning message is output. 
 
 .EXAMPLE 
  $Key = "SOFTWARE\Microsoft\Windows\CurrentVersion" 
  Get-RegExpandString -Key $Key -Value ProgramFilesPath 
 
  ComputerName Hive Key Value Data Type 
  ------------ ---- --- ----- ---- ---- 
  COMPUTER1 LocalMachine SOFTWARE\Microsof... ProgramFilesPath %ProgramFiles% ExpandString 
   
 
  Description 
  ----------- 
  The command gets the registry ProgramFilesPath ExpandString value from the local computer. 
  The returned value contains unexpanded references to environment variables. 
   
 .EXAMPLE 
  Get-RegExpandString -Key $Key -Value ProgramFilesPath -ComputerName SERVER1,SERVER2,SERVER3 -ExpandEnvironmentNames -Ping 
 
  ComputerName Hive Key Value Data Type 
  ------------ ---- --- ----- ---- ---- 
  SERVER1 LocalMachine SOFTWARE\Microsof... ProgramFilesPath C:\Program Files ExpandString 
  SERVER2 LocalMachine SOFTWARE\Microsof... ProgramFilesPath C:\Program Files ExpandString 
  SERVER3 LocalMachine SOFTWARE\Microsof... ProgramFilesPath C:\Program Files ExpandString 
   
   
  Description 
  ----------- 
  The command gets the registry ProgramFilesPath ExpandString value from three remote computers. 
  When the ExpandEnvironmentNames Switch parameter is used, the data of the value is expnaded based on the environment variables data from the local environment. 
  When the Switch parameter Ping is specified the command issues a ping test to each computer. 
  If the computer is not responding to the ping request a warning message is written to the console and the computer is not processed. 
 
 .OUTPUTS 
  PSFanatic.Registry.RegistryValue (PSCustomObject) 
 
 .NOTES 
  Author: Shay Levy 
  Blog : http://blogs.microsoft.co.il/blogs/ScriptFanatic/ 
 
 .LINK 
  http://code.msdn.microsoft.com/PSRemoteRegistry 
 
 .LINK 
  Set-RegExpandString 
  Get-RegValue 
  Remove-RegValue 
  Test-RegValue 
 
 #>
    
    
    [OutputType('PSFanatic.Registry.RegistryValue')]
    [CmdletBinding(DefaultParameterSetName="__AllParameterSets")]
    
    param( 
        [Parameter(
            Position=0,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            HelpMessage="An array of computer names. The default is the local computer."
        )]        
        [Alias("CN","__SERVER","IPAddress")]
        [string[]]$ComputerName="",        
        
        [Parameter(
            Position=1,
            ValueFromPipelineByPropertyName=$true,
            HelpMessage="The HKEY to open, from the RegistryHive enumeration. The default is 'LocalMachine'."
        )]
        [ValidateSet("ClassesRoot","CurrentUser","LocalMachine","Users","PerformanceData","CurrentConfig","DynData")]
        [string]$Hive="LocalMachine",
        
        [Parameter(
            Mandatory=$true,
            Position=2,
            ValueFromPipelineByPropertyName=$true,
            HelpMessage="The path of the subkey to open."
        )]
        [string]$Key,

        [Parameter(
            Mandatory=$true,
            Position=3,
            ValueFromPipelineByPropertyName=$true,
            HelpMessage="The name of the value to get."
        )]
        [string]$Value,
        
        [switch]$ExpandEnvironmentNames,
        
        [switch]$Ping
    ) 
    

    process
    {
            
            Write-Verbose "Enter process block..."
        
        foreach($c in $ComputerName)
        {    
            try
            {                
                if($c -eq "")
                {
                    $c=$env:COMPUTERNAME
                    Write-Verbose "Parameter [ComputerName] is not presnet, setting its value to local computer name: [$c]."                    
                }
                
                if($Ping)
                {
                    Write-Verbose "Parameter [Ping] is presnet, initiating Ping test"
                    
                    if( !(Test-Connection -ComputerName $c -Count 1 -Quiet))
                    {
                        Write-Warning "[$c] doesn't respond to ping."
                        return
                    }
                }

                
                Write-Verbose "Starting remote registry connection against: [$c]."
                Write-Verbose "Registry Hive is: [$Hive]."
                $reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]$Hive,$c)        
                
                Write-Verbose "Open remote subkey: [$Key]"
                $subKey = $reg.OpenSubKey($Key)    

                if(!$subKey)
                {
                    Throw "Key '$Key' doesn't exist."
                }
                
                if($ExpandEnvironmentNames)
                {
                    Write-Verbose "Parameter [ExpandEnvironmentNames] is presnet, expanding value of environamnt strings."
                    Write-Verbose "Get value name : [$Value]"
                    $rv = $subKey.GetValue($Value,-1)
                }
                else
                {
                    Write-Verbose "Parameter [ExpandEnvironmentNames] is not presnet, environamnt strings are not expanded."
                    Write-Verbose "Get value name : [$Value]"
                    $rv = $subKey.GetValue($Value,-1,[Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames)
                }
                
                if($rv -eq -1)
                {
                    Write-Error "Cannot find value [$Value] because it does not exist."
                }
                else
                {
                    Write-Verbose "Create PSFanatic registry value custom object."
                    $pso = New-Object PSObject -Property @{
                        ComputerName=$c
                        Hive=$Hive
                        Value=$Value
                        Key=$Key
                        Data=$rv
                        Type=$subKey.GetValueKind($Value)
                    }

                    Write-Verbose "Adding format type name to custom object."
                    $pso.PSTypeNames.Clear()
                    $pso.PSTypeNames.Add('PSFanatic.Registry.RegistryValue')
                    $pso
                }

                Write-Verbose "Closing remote registry connection on: [$c]."
                $subKey.close()
            }
            catch
            {
                Write-Error $_
            }
        } 
        
        Write-Verbose "Exit process block..."
    }
}

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Get-RegExpandString'
    $FuncAlias       = ''
    $FuncDescription = 'Get an ExpandString value from the registry.'
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
