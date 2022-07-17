function Write-Box {
    <#
    .SYNOPSIS
    Writes text inside a box.

    .DESCRIPTION
    Writes text inside a box with either a thin(│), thin with two layers(║), or thick(█) boarder.

    .PARAMETER Text
    The text to output

    .PARAMETER Style
    The style of boarder

    .EXAMPLE
    "An example text" | Write-Box

    .NOTES
    General notes
    #>
    [CmdletBinding()]
    [OutputType([string[]])]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string[]]
        $Text,
        [Parameter(Position = 1, ValueFromPipelineByPropertyName)]
        [ValidateSet("Thick", "Thin", "ThinDouble")]
        [string]
        $Style = "ThinDouble"
    )

    begin {
        $ThickStyle = "█▀███▄█"
        $ThinStyle = "┌─┐│└─┘"
        $ThinDoubleStyle = "╔═╗║╚═╝"
        switch ($Style) {
            "Thick" {
                $Top = "$($ThickStyle[1])"
                $LeftTop = "$($ThickStyle[0])$Top"
                $RightTop = "$Top$($ThickStyle[2])"
                $LeftSide = "$($ThickStyle[3]) "
                $RightSide = " $($ThickStyle[3])"
                $Bottom = "$($ThickStyle[5])"
                $LeftBottom = "$($ThickStyle[4])$Bottom"
                $RightBottom = "$Bottom$($ThickStyle[6])"
            }
            "Thin" {
                $Top = "$($ThinStyle[1])"
                $LeftTop = "$($ThinStyle[0])$Top"
                $RightTop = "$Top$($ThinStyle[2])"
                $LeftSide = "$($ThinStyle[3]) "
                $RightSide = " $($ThinStyle[3])"
                $Bottom = "$($ThinStyle[5])"
                $LeftBottom = "$($ThinStyle[4])$Top"
                $RightBottom = "$Top$($ThinStyle[6])"
            }
            "ThinDouble" {
                $Top = "$($ThinDoubleStyle[1])"
                $LeftTop = "$($ThinDoubleStyle[0])$Top"
                $RightTop = "$Top$($ThinDoubleStyle[2])"
                $LeftSide = "$($ThinDoubleStyle[3]) "
                $RightSide = " $($ThinDoubleStyle[3])"
                $Bottom = "$($ThinDoubleStyle[5])"
                $LeftBottom = "$($ThinDoubleStyle[4])$Top"
                $RightBottom = "$Top$($ThinDoubleStyle[6])"
            }
            Default {
                # Do nothing, as this should never happen
            }
        }
    }
    process {
        $Text | ForEach-Object {
            $Len = $_.Length
            $Output = ""
            $Output = "$Output$LeftTop$($Top * $Len)$RightTop`n"
            $Output = "$Output$LeftSide$Text$RightSide`n"
            $Output = "$Output$LeftBottom$($Bottom * $Len)$RightBottom`n"
            Write-Host $Output -NoNewline
        }
    }
    end {}
}