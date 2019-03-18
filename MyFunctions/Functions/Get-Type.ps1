function Get-Type {
    <#
    .SYNOPSIS
        Get exported types in the current session

    .DESCRIPTION
        Get exported types in the current session

    .PARAMETER Module
        Filter on Module.  Accepts wildcard

    .PARAMETER Assembly
        Filter on Assembly.  Accepts wildcard

    .PARAMETER FullName
        Filter on FullName.  Accepts wildcard

    .PARAMETER Namespace
        Filter on Namespace.  Accepts wildcard

    .PARAMETER BaseType
        Filter on BaseType.  Accepts wildcard

    .PARAMETER IsEnum
        Filter on IsEnum.

    .EXAMPLE
        #List the full name of all Enums in the current session
        Get-Type -IsEnum $true | Select -ExpandProperty FullName | Sort -Unique

    .EXAMPLE
        #Connect to a web service and list all the exported types

        #Connect to the web service, give it a namespace we can search on
            $weather = New-WebServiceProxy -uri "http://www.webservicex.net/globalweather.asmx?wsdl" -Namespace GlobalWeather

        #Search for the namespace
            Get-Type -NameSpace GlobalWeather

            IsPublic IsSerial Name                                     BaseType
            -------- -------- ----                                     --------
            True     False    MyClass1ex_net_globalweather_asmx_wsdl   System.Object
            True     False    GlobalWeather                            System.Web.Services.Protocols.SoapHttpClientProtocol
            True     True     GetWeatherCompletedEventHandler          System.MulticastDelegate
            True     False    GetWeatherCompletedEventArgs             System.ComponentModel.AsyncCompletedEventArgs
            True     True     GetCitiesByCountryCompletedEventHandler  System.MulticastDelegate
            True     False    GetCitiesByCountryCompletedEventArgs     System.ComponentModel.AsyncCompletedEventArgs

    .FUNCTIONALITY
        Computers
    #>
    [cmdletbinding()]
    param(
        [string]$Module = '*',
        [string]$Assembly = '*',
        [string]$FullName = '*',
        [string]$Namespace = '*',
        [string]$BaseType = '*',
        [switch]$IsEnum
    )

    #Build up the Where statement
        $WhereArray = @('$_.IsPublic')
        if($Module -ne "*"){$WhereArray += '$_.Module -like $Module'}
        if($Assembly -ne "*"){$WhereArray += '$_.Assembly -like $Assembly'}
        if($FullName -ne "*"){$WhereArray += '$_.FullName -like $FullName'}
        if($Namespace -ne "*"){$WhereArray += '$_.Namespace -like $Namespace'}
        if($BaseType -ne "*"){$WhereArray += '$_.BaseType -like $BaseType'}
        #This clause is only evoked if IsEnum is passed in
        if($PSBoundParameters.ContainsKey("IsEnum")) { $WhereArray += '$_.IsENum -like $IsENum' }

    #Give verbose output, convert where string to scriptblock
        $WhereString = $WhereArray -Join " -and "
        $WhereBlock = [scriptblock]::Create( $WhereString )
        Write-Verbose -message "Where ScriptBlock: { $WhereString }"

    #Invoke the search!
        [AppDomain]::CurrentDomain.GetAssemblies() | ForEach-Object {
            Write-Verbose -message "Getting types from $($_.FullName)"
            Try
            {
                $_.GetExportedTypes()
            }
            Catch
            {
                Write-Verbose -message "$($_.FullName) error getting Exported Types: $_"
                $null
            }

        } | Where-Object -FilterScript $WhereBlock
}

#region Metadata
# These variables are used to set the Description property of the function.

Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue

$FuncName        = 'Get-Type'
$FuncAlias       = ''
$FuncDescription = 'Determines data type'

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

# Setting the Description property of the function.
(get-childitem -Path Function:$FuncName).set_Description($FuncDescription)

#endregion Metadata

#region Metadata
    # These variables are used to set the Description property of the function.
    # and whether they are meant to be exported
    Remove-Variable -Name FuncName        -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncAlias       -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncDescription -ErrorAction SilentlyContinue
    Remove-Variable -Name FuncVarName     -ErrorAction SilentlyContinue
    $FuncName        = 'Get-Type'
    $FuncAlias       = ''
    $FuncDescription = 'Determines data type'
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
