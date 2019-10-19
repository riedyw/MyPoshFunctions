# source http://community.idera.com/powershell/powertips/b/tips/posts/finding-executable-for-file
# requires explicit path NOT relative

function Get-ExecutableForFile {
    param
    (
        [Parameter(Mandatory)]
        [string]
        $Path
    )

    $Source = @"

using System;
using System.Text;
using System.Runtime.InteropServices;
public class Win32API
    {
        [DllImport("shell32.dll", EntryPoint="FindExecutable")]

        public static extern long FindExecutableA(string lpFile, string lpDirectory, StringBuilder lpResult);

        public static string FindExecutable(string pv_strFilename)
        {
            StringBuilder objResultBuffer = new StringBuilder(1024);
            long lngResult = 0;

            lngResult = FindExecutableA(pv_strFilename, string.Empty, objResultBuffer);

            if(lngResult >= 32)
            {
                return objResultBuffer.ToString();
            }

            return string.Format("Error: ({0})", lngResult);
        }
    }

"@

    Add-Type -TypeDefinition $Source -ErrorAction SilentlyContinue
    [Win32API]::FindExecutable($Path)
}
