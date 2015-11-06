# Remediation point calculation

Codeclimate uses a relative metric called remediation points to calculate the GPA. 
This document shows the thoughts behind the remediation points that codeclimate-clog spits out. 

As far as I can tell, the remediation point to GPA mapping is about follows:

remediation points | GPA
500'000 | A 
5'000'000 | C
10'000'000 | D

## File length

lines of code | perception | target GPA
100-300 | totally acceptable | A
500 | starting to get painful | B 
1'000 | is definitely too much | C
2'000 | is really wrong | D

Threshold: 300
Formula: ```lines over threshold * 4'500```

## Function length

lines of code | perception | target GPA
10-15 | totally acceptable | A
20 | starting to get painful | B 
60 | is definitely too much | C
100 | is really wrong | D

Can occur multiple times per file.

Threshold: 15
Formula: ```lines over threshold * 100'000``` 

## Cyclomatic complexity

score | perception | target GPA
5 | totally acceptable | A
10 | starting to get painful | B 
20 | is definitely too much | C

Can occur multiple times per file. codeclimate-coffeelint uses a fixed value of 5'000'000 per occurrence.

Threshold: 5
Formula: ```score over threshold * 500'000```

## Token complexity

This one is really hard to pin down. Scores range from 100-125, but their expressiveness is quite mixed.
Let's start with a low penalty until we figure it out. 

Threshold: 100
Formula: ```score over threshold * 50'000```
