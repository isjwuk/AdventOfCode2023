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

"The answer to Part 1 is "+ `
    [string](($games |`
         Where-Object {!($_.Cubes.Red -gt 12) -and
             !($_.Cubes.Green -gt 13) -and
             !($_.Cubes.Blue -gt 14)}).GameNumber | Measure-Object -sum).Sum


#Part 2
#Find the minimum number of each colour required in each game.
#so in each game we need the largest red number, largest green number, and largest blue number.
#The largest red number in the first game can be found with
# ($games[0].Cubes.Red | Measure-Object -Maximum).Maximum
#Calculate the "MaxRed", "MaxGreen", and "MaxBlue" fields
$games=$games | Select-Object GameNumber, `
         @{Name="MaxRed";Expression={[int]($_.Cubes.Red | Measure-Object -Maximum).Maximum}}, `
         @{Name="MaxGreen";Expression={[int]($_.Cubes.Green | Measure-Object -Maximum).Maximum}}, `
         @{Name="MaxBlue";Expression={[int]($_.Cubes.Blue | Measure-Object -Maximum).Maximum}}

#Calculate the "Power" Field- the three max fields multiplied together
$games=$games | Select-Object GameNumber, @{Name="Power";Expression={$_.MaxRed*$_.MaxGreen*$_.MaxBlue}}
#The answer is the sum of these Power values.
"The answer to Part 2 is "+ `
    [string]($games.Power | Measure-Object -Sum).Sum