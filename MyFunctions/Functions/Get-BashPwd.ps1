function Get-BashPwd {
    write-output ('/' + $pwd.path.replace('\','/').replace(':',''))
}