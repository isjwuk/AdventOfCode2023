<#
.SYNOPSIS
    Solving Day 1 of the Festive Tech Calendar
#>
$inputfilepath=".\sampledata-part1.txt"

#Retrieve Input Data
$inputdata=Get-Content $inputfilepath

#Part 1 Solution
$digits="0123456789"
$sum=0
foreach ($line in $inputdata){
    #Find first digit
    $firstdigit= $line[$line.IndexOfAny($digits.ToString())]
    #Find the last digit by reversing the string, joining it back together, 
    $lastdigit= $line[$line.length-(([regex]::Matches($line,'.','RightToLeft') | ForEach-Object {$_.value}) -join '').IndexOfAny(($digits).ToString())-1]
    $sum+=[int]($firstdigit+$lastdigit)
}
"Part 1 Answer: "+$sum

#Part 2 Solution
$inputfilepath=".\sampledata-part2.txt"

#Retrieve Input Data
$inputdata=Get-Content $inputfilepath

#This function swaps out the first occurence of a number-word for a number that it finds
#This version is the wrong way- as discussed in the README file. We would then repeat this function until there were no further changes.
function checkLineForNumbers-original([string]$line){
    #Hash table of digits
    $writtenDigits=[ordered]@{"one"="1";"two"="2";"three"="3";"four"="4";"five"="5";"six"="6";"seven"="7";"eight"="8";"nine"="9"}
    for ($startindex=0;$startindex -lt $line.Length;$startindex++){
        foreach($DigitWord in $writtenDigits.Keys){
            if ($line.Substring($startindex).StartsWith($DigitWord)){
                $line=$line.Substring(0,$startindex)+$writtendigits[$digitword]+$line.Substring($startindex+$DigitWord.Length)
                return $line
            }
        }
    }
    return $line
}
#This function swaps out the first occurence of a number-word for a number that it finds
function checkLineForNumbers([string]$line){
    #Hash table of digits
    $writtenDigits=[ordered]@{"one"="1";"two"="2";"three"="3";"four"="4";"five"="5";"six"="6";"seven"="7";"eight"="8";"nine"="9"}
    for ($startindex=0;$startindex -lt $line.Length;$startindex++){
        foreach($DigitWord in $writtenDigits.Keys){
            if ($line.Substring($startindex).StartsWith($DigitWord)){
                $line=$line.Substring(0,$startindex)+$writtendigits[$digitword]+$line.Substring($startindex+1)
                #return $line
            }
        }
    }
    return $line
}

$sum=0
foreach ($line in $inputdata){
    #Replace written numbers with digits
    $line=checkLineForNumbers -line $line
    #Now do the digit extraction as per part 1.
    $firstdigit= $line[$line.IndexOfAny($digits.ToString())]
    $lastdigit= $line[$line.length-(([regex]::Matches($line,'.','RightToLeft') | ForEach-Object {$_.value}) -join '').IndexOfAny(($digits).ToString())-1]
    $sum+=[int]($firstdigit+$lastdigit)
}
"Part 2 Answer: "+$sum


