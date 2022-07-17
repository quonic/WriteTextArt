# Taken with love from https://raw.githubusercontent.com/poshbotio/PoshBot/master/Tests/Meta.tests.ps1
Set-StrictMode -Version latest

# Make sure MetaFixers.psm1 is loaded - it contains Get-TextFilesList
Import-Module -Name (Join-Path -Path $PSScriptRoot -ChildPath 'MetaFixers.psm1') -Verbose:$false -Force

# Bug: $ENV:BuildRoot isn't being populated: https://github.com/ModuleBuild/ModuleBuild/issues/25
$projectRoot = $ENV:BuildRoot

if (-not $projectRoot -or $null -eq $projectRoot) {
    $projectRoot = $PSScriptRoot
}

Describe 'Text files formatting' -Tags @('MetaTest') {
    $allTextFiles = Get-TextFilesList -root $projectRoot -Extension @('.gitignore', '.gitattributes', '.ps1', '.psm1', '.psd1', '.cmd', '.mof')
    $allTextFiles = $allTextFiles | Where-Object {
        $_.FullName -notlike '*\release\*' -and
        $_.FullName -notlike '*\plugins\*' -and
        $_.FullName -notlike '*\build\*'
    }
    Context 'Files encoding' {
        It "Doesn't use Unicode encoding" {
            $unicodeFilesCount = 0
            $allTextFiles | Foreach-Object {
                if ($_ -and $(Test-FileUnicode $_)) {
                    $unicodeFilesCount += 1
                    Write-Warning "File $($_.FullName) contains 0x00 bytes. It's probably uses Unicode and need to be converted to UTF-8."
                }
            }
            $unicodeFilesCount | Should -Be 0
        }
    }

    Context 'Indentations' {
        It 'Uses spaces for indentation, not tabs' {
            $totalTabsCount = 0
            $allTextFiles | Foreach-Object {
                if ($_) {
                    $fileName = $_.FullName
                    $(Get-Content $_.FullName -Raw) | Select-String "`t" | Foreach-Object {
                        Write-Warning "There are tabs in $fileName."
                        $totalTabsCount++
                    }
                }

            }
            $totalTabsCount | Should -Be 0
        }
    }
}