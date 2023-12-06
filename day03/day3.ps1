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

$rollingTotal=0

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
        #"number: "+$line.Substring($x, $lastdigit-$x+1)
        #Check the surrounding cells for symbols
        #TODO
        
        $symbolFound=$false
        if($y -gt 0){
            #Check row above
            if ($x -gt 0){
                #Check top left corner is not a . or a number
                if($inputdata[$y-1][$x-1] -ne "." -and !($inputdata[$y-1][$x-1] -in $digits.ToCharArray() )){
                    $symbolFound=$true
                }
             }
             #Check row directly above
             for($i=$x;$i -le $lastdigit; $i++){
                if($inputdata[$y-1][$i] -ne "." -and !($inputdata[$y-1][$i] -in $digits.ToCharArray() )){
                    $symbolFound=$true
                }
             }
             if ($lastdigit -lt $MaxX){
                #Check top right corner
                if($inputdata[$y-1][$lastdigit+1] -ne "." -and !($inputdata[$y-1][$lastdigit+1] -in $digits.ToCharArray() )){
                    $symbolFound=$true
                }
             }
        }
        if($y -lt $maxY-1){
            #Check row below
            if ($x -gt 0){
                #Check bottom left corner is not a . or a number
                if($inputdata[$y+1][$x-1] -ne "." -and !($inputdata[$y+1][$x-1] -in $digits.ToCharArray() )){
                    $symbolFound=$true
                }
             }
             #Check row directly below
             for($i=$x;$i -le $lastdigit; $i++){
                if($inputdata[$y+1][$i] -ne "." -and !($inputdata[$y+1][$i] -in $digits.ToCharArray() )){
                    $symbolFound=$true
                }
             }
             if ($lastdigit -lt $MaxX){
                #Check bottom right corner
                if($inputdata[$y+1][$lastdigit+1] -ne "." -and !($inputdata[$y+1][$lastdigit+1] -in $digits.ToCharArray() )){
                    $symbolFound=$true
                }
             }
        }
        #Check Left and right ends
        if ($x -gt 0){
            #Check left is not a . or a number
            if($inputdata[$y][$x-1] -ne "." -and !($inputdata[$y][$x-1] -in $digits.ToCharArray() )){
                $symbolFound=$true
            }
         }
        if ($lastdigit -lt $MaxX){
            #Check  right 
            if($inputdata[$y][$lastdigit+1] -ne "." -and !($inputdata[$y][$lastdigit+1] -in $digits.ToCharArray() )){
                $symbolFound=$true
            }
         }


        if($symbolFound){
            $rollingTotal+=[int]$line.Substring($x, $lastdigit-$x+1)
            #Display for debug purposes
            "Part Number Confirmed "+$line.Substring($x, $lastdigit-$x+1)
        }


        #Increment X and loop round to check for more part numbers in this line
        $x=$lastdigit+1
        $firstdigit=$line.substring($x).IndexOfAny($digits.ToString())
        if ($firstdigit -ge 0) {
            $x= $firstdigit+$x
        } else {
            $x=$firstdigit
        }
    }

}

"Total "+[string]$rollingTotal
