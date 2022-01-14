
## Your code was:

# widow_data <- widow_data %>% mutate_at(c("worry", "sleepprobs" , "breathlessness" , "agitated" , "depression" , "nowakeup" , "panic" , "nothingness" , "pain" , "hopelessness" , "worrysleep" , "nointerests" , "anxious" , "suicide" ), funs(recode(., `0`=0, `1`=1, `2`=1, `3`=1)))


## I'll produce some random data to reproduce a version of your example but with only three variables, for simplicity
worry <- sample(x = 0:3, size  = 100, replace = TRUE)
sleepprobs <- sample(x = 0:3, size  = 100, replace = TRUE)
breathlessness <- sample(x = 0:3, size  = 100, replace = TRUE)
example <- data.frame(worry, sleepprobs, breathlessness)

## The name of the toy dataset is 'example'; open it up, check out how it looks like

## Now I'll use your code to see if it works
library(dplyr)
example2 <- example %>% 
  mutate_at(c("worry", "sleepprobs" , "breathlessness"), funs(recode(., `0`=0, `1`=1, `2`=1, `3`=1)))

## The code seems to work, all values higher or equal to 1 were recoded to 1 and all 0s were kept as 0
## So it if doesn't work on the widow-data dataset, there's something else wrong; 
## maybe some previous step was left out, or maybe just RStudio needs a restart

# But, another option, using the 'rec()' function from the 'sjmisc' package:
# 'sjmisc' probably needs installing
# either by install.packages(sjmisc)
# or adding to pacman command p_load(sjmisc)

library(sjmisc) 
example3 <- example %>%                 
  rec(worry, sleepprobs, breathlessness, # step 1 (optional)
      rec = "0=0; 1:3=1",                # step 2 
      suffix = "")                       # step 3 (optional)

# step 1: here select the variables to be recoded; can add more
# step 2: here do the recoding; x:y selects all numbers between x and y
# step 3: overwrite the default suffix; "" adds no suffix, i.e. overwrites original variables

# This one above is probably more straighforward than the other option  