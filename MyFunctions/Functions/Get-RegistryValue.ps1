function Get-RegistryValue
{
    param
    (
        [Parameter(Mandatory = $true)]
        $RegistryKey
    )

    Begin {
        Write-Verbose -Message "Starting $($MyInvocation.Mycommand)"
    }

    Process {

        $key = Get-Item -Path "Registry::$RegistryKey"
        $key.GetValueNames() |
        ForEach-Object {
            $name = $_

            $rv = 1 | Select-Object -Property Name, Type, Value
            $rv.Name = $name
            $rv.Type = $key.GetValueKind($name)
            $rv.Value = $key.GetValue($name)
            if (-not $rv.name) { $rv.name = '(Default)' }
            $rv

        }
    }

    End {
        Write-Verbose -Message "Ending $($MyInvocation.Mycommand)"
    }

}
