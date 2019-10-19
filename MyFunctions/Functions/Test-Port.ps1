# inspired by https://gallery.technet.microsoft.com/scriptcenter/97119ed6-6fb2-446d-98d8-32d823867131

Function Test-Port {
<#
.SYNOPSIS
    Tests a Port or a range of ports on a specific ComputerName(s).
.DESCRIPTION
    Tests a Port or a range of ports on a specific ComputerName(s). Creates a custom object with the properties: ComputerName, Protocol, Port, Open, Notes.
.PARAMETER ComputerName
    A single ComputerName or array of ComputerName to test the port connection on.
.PARAMETER Port
    Port number to test ([int16] 0 - 65535), an array can also be passed
.PARAMETER TCP
    Use TCP as the transport protocol
.PARAMETER UDP
    Use UDP as the transport protocol
.PARAMETER TimeOut
    Sets a timeout for TCP or UDP port query. (In milliseconds, Default is 1000)
.NOTES
    Author:     Bill Riedy
    Version:    1.0
    Date:       2018/03/13
    To Do:      UDP port testing not currently working
.EXAMPLE
    Test-Port -ComputerName 'server' -port 80
    Checks port 80 on server 'server' to see if it is listening
.EXAMPLE
    'server' | Test-Port -Port 80
    Checks port 80 on server 'server' to see if it is listening
.EXAMPLE
    Test-Port -ComputerName @("server1","server2") -Port 80
    Checks port 80 on server1 and server2 to see if it is listening
.EXAMPLE
    @("server1","server2") | Test-Port -Port 80
    Checks port 80 on server1 and server2 to see if it is listening
.EXAMPLE
    (Get-Content hosts.txt) | Test-Port -Port 80
    Checks port 80 on servers in host file to see if it is listening
.EXAMPLE
    Test-Port -ComputerName (Get-Content hosts.txt) -Port 80
    Checks port 80 on servers in host file to see if it is listening
.EXAMPLE
    Test-Port -ComputerName (Get-Content hosts.txt) -Port @(1..59)
    Checks a range of ports from 1-59 on all servers in the hosts.txt file
.OUTPUTS
    [psobject]
    An array of objects containing the fields:
    ComputerName    A string containing the computer name or ip address that was passed to the function
    Protocol        A string being either 'TCP' or 'UDP'
    Port            An integer in the range 1 - 65535
    Open            A boolean
    Notes           Any notes when attempting to make a connection
.LINK
    about_Properties
#>

    #region Parameter
    [cmdletbinding(
        DefaultParameterSetName = '',
        ConfirmImpact = 'low'
    )]
    [OutputType([psobject])]
    Param(
        [Parameter(
            Mandatory = $True,
            HelpMessage = 'Enter a ComputerName or IP address',
            Position = 0,
            ParameterSetName = '',
            ValueFromPipeline = $True)
            ]
            [string[]] $ComputerName,
        [Parameter(
            Position = 1,
            Mandatory = $True,
            HelpMessage = 'Enter an integer port number (1-65535)',
            ParameterSetName = '')]
            [uint16[]] $Port,
        [Parameter(
            ParameterSetName = '')]
            [int] $Timeout=1000,
        [Parameter(
            ParameterSetName = '')]
            [switch] $TCP,
        [Parameter(
            ParameterSetName = '')]
            [switch] $UDP
        )
    #endregion Parameter
    Begin
    {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
        If (!$tcp -AND !$udp)
        {
            $tcp = $True
        }
        #Typically you never do this, but in this case I felt it was for the benefit of the function
        #as any errors will be noted in the output of the report
        $oldEA = $ErrorActionPreference
        $ErrorActionPreference = 'SilentlyContinue'
        write-verbose -Message "Saving current value of `$ErrorActionPreference [$($oldEa)] and setting it to 'Stop'"
        $report = @()
    }
    Process
    {
        ForEach ($c in $ComputerName)
        {
            ForEach ($p in $port)
            {
                If ($tcp)
                {
                    #Create temporary holder
                    $temp = '' | Select-Object -Property ComputerName, Protocol, Port, Open, Notes
                    #Create object for connecting to port on computer
                    $tcpobject = new-Object -TypeName system.Net.Sockets.TcpClient
                    #Connect to remote machine's port
                    $connect = $tcpobject.BeginConnect($c,$p,$null,$null)
                    #Configure a timeout before quitting
                    $wait = $connect.AsyncWaitHandle.WaitOne($Timeout,$false)
                    #If timeout
                    If(!$wait)
                    {
                        #Close connection
                        $tcpobject.Close()
                        Write-Verbose -Message 'Connection Timeout'
                        #Build report
                        $temp.ComputerName = $c
                        $temp.Port = $p
                        $temp.Protocol = 'TCP'
                        $temp.Open = 'False'
                        $temp.Notes = 'Connection to Port Timed Out'
                    }
                    Else
                    {
                        $error.Clear()
                        $tcpobject.EndConnect($connect) | out-Null
                        #If error
                        If($error[0])
                        {
                            #Begin making error more readable in report
                            [string] $string = ($error[0].exception).message
                            $message = (($string.split(':')[1]).replace('"','')).TrimStart()
                            $failed = $true
                        }
                        #Close connection
                        $tcpobject.Close()
                        #If unable to query port to due failure
                        If($failed)
                        {
                            #Build report
                            $temp.ComputerName = $c
                            $temp.Port = $p
                            $temp.Protocol = 'TCP'
                            $temp.Open = $false
                            $temp.Notes = "$message"
                        }
                        Else
                        {
                            #Build report
                            $temp.ComputerName = $c
                            $temp.Port = $p
                            $temp.Protocol = 'TCP'
                            $temp.Open = $true
                            $temp.Notes = "Successful link to $c $($temp.Protocol) port $p"
                        }
                    }
                    #Reset failed value
                    $failed = $Null
                    #Merge temp array with report
                    $report += $temp
                }
                If ($udp)
                {
                    $temp = '' | Select-Object -Property ComputerName, Protocol, Port, Open, Notes
                    write-verbose -Message 'Making UDP connection to remote server'
                    $Socket = New-Object -TypeName Net.Sockets.Socket( 'InterNetwork', 'Dgram', 'Udp' )
                    $Socket.SendTimeOut    = $Timeout  # ms
                    $Socket.ReceiveTimeOut = $Timeout  # ms
                    try
                    {
                        $Socket.Connect( $C, $p )
                        $Buffer    = New-Object byte[] 48
                        $Buffer[0] = 27
                        write-verbose -Message 'Sending message to remote host'
                        $Socket.Send(    $Buffer ) | Out-Null
                        $Socket.Receive( $Buffer ) | Out-Null
                        $temp.ComputerName = $c
                        $temp.Port = $p
                        $temp.Protocol = 'UDP'
                        $temp.Open = $true
                        $temp.Notes = ''
                    }
                    catch
                    {
                        write-verbose -Message 'Communication failed'
                        write-error -Message $error[0]
                        $temp.ComputerName = $c
                        $temp.Port = $p
                        $temp.Protocol = 'UDP'
                        $temp.Open = $false
                        $temp.Notes = $error[0].exception
                    }
                    $socket.dispose()
                    remove-variable -Name socket
                    #Merge temp array with report
                    $report += $temp
                }
            }
        }
    } End
    {
        #Generate Report
        write-output -InputObject $report
        write-verbose -Message "Resetting value of `$ErrorActionPreference back to [$($oldEa)]"
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
        $ErrorActionPreference = $oldEA
    }
} #EndFunction Test-Port
