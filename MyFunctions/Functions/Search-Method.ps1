
function Search-Method([Type] $parameterType, $namespace) {
<#
.SYNOPSIS
    Search method
.DESCRIPTION
    Search method
.NOTES
    Author:     Bill Riedy
#>
    Get-Type |
    Where-Object { $_.Namespace -like "*$namespace*" } |
    Where-Object {
        $_.GetMethods() |
        Foreach-Object {
            $_.GetParameters() |
                Where-Object {
                    $_.ParameterType -eq $parameterType
                }
        }
    }
}

<#

There's a simple yet powerful function that nearly everyone on the PowerShell
team has written a version of.  My version is called Get-Type.  It's only a one-liner,
but it's an amazing way to explore .NET and it's also an amazing example of some of
the things you can do with the object pipeline.  What my version does is get all of
the existing .NET types loaded in the current program.  In this post, I'll introduce
the basic function, and I'll build upon it in order to show some cool things you can
do with .NET reflection.  I first introduced this function in the 2nd post of my series
on WPF, but I didn't really show that much .NET fun with it.

Here's a simple version:

function Get-Type() {
     [AppDomain]::CurrentDomain.GetAssemblies() |  Foreach-Object { $_.GetTypes() }
}

Go ahead and run it.  Running it on CTP2 of Graphical PowerShell on my home box, I got 19303 .NET types.
That's over 19000 things you can build upon.  19000 potential solutions sitting right there at your
fingertips.  A remarkable amount of information can be gleaned just looking directly at the types,
and it's a lot faster than looking it up on MSDN (although MSDN is a great companion to this knowledge).

How I figured out there were 19303 .NET types is a great example of the object pipeline:

Get-Type | Measure-Object

But that's only scratching the surface of what we can do with the rich data of .NET and
PowerShell's powerful object pipeline.

Let's suppose that I want to find every Xml-related type:

Get-Type | ? { $_.Name -like "*Xml*" }

Now suppose I want to find the constructors of the constructors of the objects:

Get-Type | ? { $_.Name -like "*Xml*" } | % { $_.GetConstructors() }  | %  { "$_" }

Now suppose I want to check out what each constructor can do:

Get-Type | ? { $_.Name -like "*Xml*" } | % { $_.GetConstructors() } | Get-Member

Looking at this, I can see that constructors contain a GetParameters() method.
Let's put that together with Get-Type to build something that will find all of
the types that I can build using that type.

function Search-Constructor([Type] $parameterType, $namespace) {
    Get-Type |
    Where-Object { $_.Namespace -like "*$namespace*" } |
    Where-Object {
        $_.GetConstructors() |
        Foreach-Object {
            $_.GetParameters() |
                Where-Object {
                    $_.ParameterType -eq $parameterType
                }
        }
    }
}

It will probably take a little bit to run (on my machine, it took about 30 seconds
to find anything that used XmlDocument in its constructor, with no namespace specified),
but you can easily use this to start discovering how .NET types interact.

Similar functions will let you find Properties, Events, and Methods:

function Search-Method([Type] $parameterType, $namespace) {
    Get-Type |
    Where-Object { $_.Namespace -like "*$namespace*" } |
    Where-Object {
        $_.GetMethods() |
        Foreach-Object {
            $_.GetParameters() |
                Where-Object {
                    $_.ParameterType -eq $parameterType
                }
        }
    }
}

If you want to check out any property, just use Select-Object to view the type.
(You can also summarize the object by adding hashtables, for instance, this expression
will output each type's fullname and all of their methods:

Get-Type | Select-Object FullName, @{Name='Methods';Expression={$_.GetMethods() | % {$_.ToString()}}}

This is a great example of the usefulness of the Object pipeline.  Instead of getting
a list of all of the typenames, you can delve deep into the what a type can do for
you.  The more you explore .NET.  These little snippets should help get you
started, but the sky's the limit.  Try writing a few of your own. The more you
explore .NET, the more you'll be amazed at the variety of code that exists to
solve your everyday programming problems.

Hope this helps,

James Brundage [MSFT]

Pasted from <https://blogs.msdn.microsoft.com/mediaandmicrocode/2008/10/23/microcode-powershell-scripting-tricks-exploring-net-types-with-a-get-type-function-and-reflection/>
 #>
