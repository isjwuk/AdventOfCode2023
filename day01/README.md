# Day 1: Trebuchet?!

Solving the [Day 1](https://adventofcode.com/2023/day/1) puzzle with PowerShell.

* [day1.ps1](day1.ps1)


## Interesting Bits
As with real-life problems, these puzzles always throw up gotcha's and challenges. Here are a couple I came across today.

### Number Replacement
In the part 2 solution we can't just replace like this:
```powershell
$newinputdata=$inputdata.Replace("one","1").Replace("two","2").Replace("three","3").Replace("four","4").Replace("five","5").Replace("six","6").Replace("seven","7").Replace("eight","8").Replace("nine","9")
```
Because, line two in the sample data is
```
eightwothree
```
And this would turn into the input string ``eigh23`` rather than ``8wo3`` as is intended- giving the result 23 instead of 83.

We can't just do this replace the other way round, because that would fail if we had the line
```
threeighttwo
```
Which would resolve into 82 rather than 32.

Therefore we need to step character-by-character to check if the beginning of string matches one of the digit-words.

## Short Entry
There's an entry in *my* input file which reads just ``4r``. In this case the first digit and last digit are the same character. It appears that in this situation 
(confirmed by the test result in part 1) the answer for that row is 44- so the character is counted twice.

## Tricky Part 2
My Part 2 value was initially too high- passes the sample data fine, but not the real data. I found the cause [on Reddit](https://www.reddit.com/r/adventofcode/comments/1884fpl/2023_day_1for_those_who_stuck_on_part_2/)
thanks to the user Zefick:
> The right calibration values for string "eighthree" is 83 and for "sevenine" is 79.
> 
> The examples do not cover such cases.

I, along with many other users, was initially moving along the string too far, so ``eighthree2`` was being translated to ``8hree2`` and resolving to 82. None of the entries
in the [sample data](./sampledata-part2.txt) provided would distinguish what to do in this case. My answer doing it the wrong way was only 2 out so this can't be a common scenario in the dataset! I've included the original (incorrect) function I first wrote for reference only - ``checkLineForNumbers-original`` in [day1.ps1](day1.ps1).
