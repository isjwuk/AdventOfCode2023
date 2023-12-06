<#
.SYNOPSIS
    Solving Day 3 of the Advent of Code 2023
    https://adventofcode.com/2023/day/3
#>


$inputfilepath=".\sampledata-part1.txt"
#$inputfilepath=".\input.txt"

#Retrieve Input Data
$inputdata=Get-Content $inputfilepath
#We can reference this directly $inputdata[$y][$x]
$maxX=$inputdata[0].Length #All rows are the same length
$maxY=$inputdata.Length

$digits="0123456789"

for($y=0;$y -lt $maxY; $y++){ #Loop through rows
    $line= $inputdata[$y]
    $x= $line.IndexOfAny($digits.ToString())
    while ($x -ge 0 -and $x -lt $maxX){
        #Working on $line.Substring($x)
        # Find the end of this number
        $lastdigit=$maxX-1 # In case we don't find the end!
        $i=$x+1
        while($i -lt $maxX){
            if($line.substring($i,1).IndexOfAny($digits.ToString()) -ge 0){
                #Character i is still a number
                $i++
            } else {
                #Character i is not a number- we reached the end 
                $lastdigit=$i-1
                $i=$maxX #Drop us out of the loop
            }            
        }
        
        #Show the potential part number for debugging purposes
        "number: "+$line.Substring($x, $lastdigit-$x+1)
      
        
        #Check the surrounding cells for symbols
        #TODO
        #Increment X and loop round to check for more part numbers in this line
        #$x++ #TODO- replace this line to increment X by length of potential part number just discovered
        $x=$lastdigit+1
        $firstdigit=$line.substring($x).IndexOfAny($digits.ToString())
        if ($firstdigit -ge 0) {
            $x= $firstdigit+$x
        } else {
            $x=$firstdigit
        }
    }

}