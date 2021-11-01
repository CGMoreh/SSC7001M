


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


### Cut-outs from 25-interactions.Rmd:

### Transforming data imported from other formats(e.g. SPSS, Stata, Excel, etc.)
# 
# This dataset was imported from a Stata `.dta` dataset using a function from the `haven` package. In the process of importing the data, `haven` creates a special data type called `haven_labelled` to store additional information about variable and value labels that Stata manages by default but `R` doesn't. We can use the imported variables as they are for most analyses, but occasionally we will encounter warning messages such as `Don't know how to automatically pick scale for object of type haven_labelled/vctrs_vctr/double. Defaulting to continuous` or even error messages. To avoid these, it is a good idea to transform the data further to a format more convenient for `R`, although some variables will still benefit from further individual manipulations later.
# We can check whether a variable has a `haven_labelled` format with the command line:
#   ```{r, eval=FALSE}
# is.labelled(osterman$ppltrst) 
# ## or adding haven:: in front of the command if the haven package is not loaded in the library()
# ```
# The command will print either a TRUE or FALSE message (i.e. whether the variable is or isn't `haven_labelled`). In this case the result is: `r is.labelled(osterman$ppltrst)`. It is particularly useful to convert categorical variables into so-called *factor* variables (`R`'s way of denoting categorical variables) using the command:
#   ```{r}
# osterman <- osterman %>% 
#   mutate_if(haven::is.labelled, haven::as_factor)
# ```
# We can check again whether *ppltrst* still has a `haven_labelled` format:
#   ```{r}
# is.labelled(osterman$ppltrst) 
# ```
# 
# We can also generate another 'data dictionary' to check the differences between the original and identify any variables that may need to be transformed further:
#   ```{r}
# data_dictionary2 <- labelled::generate_dictionary(osterman) 
# ```
# 
# ``` {r, eval=FALSE}
# # Let's view the data dictionary:
# View(data_dictionary2)
# ```
