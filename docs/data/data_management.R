


# Data import and management --------------------------------

dta <- haven::read_dta("https://cgmoreh.github.io/SSC7001M/data/ess9.dta")
sav <- haven::read_sav("https://cgmoreh.github.io/SSC7001M/data/ess9.sav")              

## Check variable names and position ------------------------
names(dta)     # 'ppltrst' is in position 10

## Check labelled variable attributes -----------------------
attributes(dta$ppltrst)$label   # prints variable label
attributes(dta$ppltrst)$labels  # prints value labels
attributes(dta[[10]])$labels    # same as previous using position extraction 

## Check if variable is of type `haven_labelled`
haven::is.labelled(dta$ppltrst) # check if it's labelled
typeof(dta$ppltrst)   # check data type in base R


## Create a searchable data dictionary -----------------------
dta_dictionary <- labelled::generate_dictionary(dta)

dta_dictionary |> 
  dplyr::filter(variable %in% "ppltrst")

## A simple vertical frequency table --------------------------
data.frame(table(dta$cntry))

## A function for a more complex frequency table for single variable ----
my_freqtab <- function( my ){
  freq <- table( my,  useNA = "ifany" )
  size <- length( my )
  df <- data.frame( freq )
  values <- as.numeric( freq )
  df$percentage <- round(100 * (values / size), 2)
  df$cumul_freq <- cumsum( values )
  df$cumul_percentage <- round(100 * (cumsum( values ) / size), 2)
  names( df ) <- c("Levels","N", "%", "Cumulative N", "Cumulative %")
  df
  }

my_freqtab(dta2$ppltrst)


# Working with labelled variables -----------------------
# https://www.pipinghotdata.com/posts/2020-12-23-leveraging-labelled-data-in-r/


## Reduce dataset --------------------------------------
mini_dta <- dta |>
  dplyr::filter(cntry == "GB") |> 
  dplyr::select(starts_with("ppl"))
  
  
# bar plot 1 ----
mini_dta %>% 
  pivot_longer(
    cols = 1:4,
    names_to = "variable",
    values_to = "score"
  ) %>% 
  count(variable, score) %>% 
  # include factor(score) to correctly show value codes in ggplot ----
ggplot(aes(x = n, y = factor(score))) +
  facet_wrap(. ~ variable) +
  geom_col() 
  
  
mini_dta %>% 
# --------------------------------------------------------------
# change 1: convert haven_labelled variables to factors ----
mutate_if(haven::is.labelled, haven::as_factor) %>% 
# change 2: convert variable labels to variable names ----
# sjlabelled::label_to_colnames() %>% 
# --------------------------------------------------------------
pivot_longer(      
  cols = 4,
  names_to = "variable",
  values_to = "score"
) %>% 
  count(variable, score) %>% 
  # unnecessary to include factor(score) here as was already converted in change 1 ----
ggplot(aes(x = n, y = score)) +
  facet_wrap(. ~ variable) +
  geom_col() 

## Convert to factor
dta2 <- dta %>% 
  mutate_if(haven::is.labelled, haven::as_factor)
 ## some variables are mis-recognised as factors (e.g. those measuring responses in minutes)
