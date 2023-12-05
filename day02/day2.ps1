<#
.SYNOPSIS
    Solving Day 2 of the Advent of Code 2023
#>


$inputfilepath=".\sampledata-part1.txt"
#$inputfilepath=".\input.txt"

#Retrieve Input Data
$inputdata=Get-Content $inputfilepath

#Translate inputdata into object
#Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
$games=$inputdata | `
    Select-Object @{Name="GameName";Expression={$_.Split(":")[0]}}, `
    @{Name="GameNumber";Expression={[int](($_.Split(":")[0]).Split(" ")[1])}}, `
    @{Name="Sets"; Expression={($_.Split(":")[1]).Split(";").Trim(" ")}}
#Now we can retrieve data like this
# $games[0].Sets       
# 3 blue, 4 red
# 1 red, 2 green, 6 blue
# 2 green
#OR
# $games[0].Sets[1]
# 1 red, 2 green, 6 blue

#Now translate that into actual numbers for Red, Green, Blue
# For example "1 red, 2 green, 6 blue"  becomes Red=1, Green=2, Blue=6
$games=$games | Select-Object GameNumber,@{Name="Cubes";Expression={ $_.Sets | `
         Select-Object @{Name="Red"; Expression={[int](($_.Split(",")| Where-Object {$_ -like "*red"}).replace("red",""))}} , `
         @{Name="Green"; Expression={[int](($_.Split(",")| Where-Object {$_ -like "*green"}).replace("green",""))}}, `
        @{Name="Blue"; Expression={[int](($_.Split(",")| Where-Object {$_ -like "*blue"}).replace("blue",""))}}}}    

#Now we are ready to answer the question
#which games would have been possible if the bag contained only 12 red cubes, 13 green cubes, and 14 blue cubes
#What is the sum of the IDs of these games?

"The answer is "+ `
    [string](($games |`
         Where-Object {!($_.Cubes.Red -gt 12) -and
             !($_.Cubes.Green -gt 13) -and
             !($_.Cubes.Blue -gt 14)}).GameNumber | Measure-Object -sum).Sum