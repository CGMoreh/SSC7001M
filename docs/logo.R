library(tidyverse)

a <- c("S", "S", "C", "7", "0", "0", "1", "M", 
       "A", "D", "V", "A", "N", "C", "E", "D", 
       "R", "E", "S", "E", "A", "R", "C", "H", 
       "M", "E", "T", "H", "O", "D", "S", "1")

y <- c(5,5,5,5,5,5,5,5,
       4,4,4,4,4,4,4,4,
       3,3,3,3,3,3,3,3,
       2,2,2,2,2,2,2,2       )

x <- c(2,3,4,5,6,7,8,9,
       2,3,4,5,6,7,8,9,
       2,3,4,5,6,7,8,9,
       2,3,4,5,6,7,8,9)

group <- c("a","a","a","b","b","b","b","a","c","c","c","c","c","c","c","c","d","d","d","d","d","d","d","d","e","e","e","e","e","e","e","b")

group2 <- c(1,1,1,2,2,2,2,1,
            3,3,3,3,3,3,3,3,
            4,4,4,4,4,4,4,4,
            5,5,5,5,5,5,5,2)



logo_data <- tibble(a, y, x, group)

cols <- c("1" = "#333300", "2" = "#990000", "3" = "#003300", "4" = "#003333", "5" = "#000033")


## Logo plots

ggplot(logo_data, aes(x, y, label=a))  +
    geom_point(aes(color = group, fill = group),
    shape = 22,
    size = 30) +
  geom_text(aes(label=a), size=20) +   
  scale_color_manual(values = c("#C4961A", "#FC4E07", "#D16103", "#52854C", "#293352"))


# + expand_limits(x=1, y=1)


ggplot(logo_data, aes(x, y)) +
  theme(axis.title.x = element_blank(), axis.title.y = element_blank()) +
  geom_point(aes(color = group), shape = 15, size = 25, show.legend = F) +
  scale_color_manual(values = c("#C4961A", "#FC4E07", "#D16103", "#52854C", "#293352")) +
  geom_text(aes(label=a), size=20, 
            colour = ifelse(logo_data$group=="c" | logo_data$group=="e", "white", "black"),
            fontface = 2) + 
  expand_limits(x=c(1.8,9.2), y=c(1.6, 5.4)) +
  scale_x_continuous(breaks=seq(1.5, 9.5, 0.5)) +
  scale_y_continuous(breaks=seq(1.5, 5.5, 0.5))

### Front slide logo

ggplot(logo_data, aes(x, y)) +
  theme(axis.title.x = element_blank(), axis.title.y = element_blank()) +
  geom_point(aes(color = group), shape = 15, size = 15, show.legend = F) +
  scale_color_manual(values = c("#C4961A", "#FC4E07", "#D16103", "#52854C", "#293352")) +
  geom_text(aes(label=a), size=12, 
            colour = ifelse(logo_data$group=="c" | logo_data$group=="e", "white", "black"),
            fontface = 2) + 
  expand_limits(x=c(-10.1, 9.1), y=c(-5, 5.2)) +
  scale_x_continuous(breaks=seq(-10, 10, 1)) +
  scale_y_continuous(breaks=seq(-10, 6, 1))

### Front slide logo2

ggplot(logo_data, aes(x, y)) +
  theme(axis.title.x = element_blank(), 
        axis.title.y = element_blank(),
        axis.text=element_blank(),
        axis.ticks=element_blank()) +
  geom_point(aes(color = group), shape = 15, size = 11, show.legend = F) +
  scale_color_manual(values = c("#C4961A", "#FC4E07", "#D16103", "#52854C", "#293352")) +
  geom_text(aes(label=a), size=9, 
            colour = ifelse(logo_data$group=="c" | logo_data$group=="e", "white", "black"),
            fontface = 2) + 
  expand_limits(x=c(-11, 9), y=c(-10, 5.2)) +
  scale_x_continuous(breaks=seq(-11, 9, 2)) +
  scale_y_continuous(breaks=seq(-10, 6, 2))


ggsave("logo2.png")


#### NEW TITLE LOGO ------------------------------------------------------------

a <- c("?", "!", "|", ">", "A", "P", "P", "L", "I", "E", "D", "(", 
       "S", "O", "C", "I", "O", "L", "O", "G", "I", "C", "A", "L", 
       "M", "E", "T", "H", "O", "D", "O", "L", "O", "G", "Y", ")",
       "_", "|", ">", "T", "O", "(", "T", "R", "U", "S", "T", ")")

y <- c(5,5,5,5,5,5,5,5,5,5,5,5, 
       4,4,4,4,4,4,4,4,4,4,4,4,
       3,3,3,3,3,3,3,3,3,3,3,3,
       2,2,2,2,2,2,2,2,2,2,2,2)

x <- c(1,2,3,4,5,6,7,8,9,10,11,12,
       1,2,3,4,5,6,7,8,9,10,11,12,
       1,2,3,4,5,6,7,8,9,10,11,12,
       1,2,3,4,5,6,7,8,9,10,11,12)

group <- c("y", "y", "z", "z", "a", "a", "a", "a", "a", "a", "a", "q",
           "b", "b", "b", "b", "b", "b", "b", "b", "b", "b", "b", "b",
           "b", "b", "b", "b", "b", "b", "b", "b", "b", "b", "b", "q",
           "", "z", "z", "a", "a", "q", "c", "c", "c", "c", "c", "q")

group2 <- c(9,9,8,8,1,1,1,1,1,1,1,7,
            2,2,2,2,2,2,2,2,2,2,2,2,
            2,2,2,2,2,2,2,2,2,2,2,7,
            0,8,8,1,1,7,3,3,3,3,3,7)


logo_data <- tibble(a, y, x, group)

colours <- c( "9" = "#a90606",
              "8" = "#638cb3",
              "1" = "#8c8279",
              "7" = "#cf9930",
              "2" = "#160202",
              "0" = "#cf9930",
              "3" = "#aaaaaa")
  
  
ggplot(logo_data, aes(x, y)) +
  theme(axis.title.x = element_blank(), 
        axis.title.y = element_blank(),
        axis.text=element_blank(),
        axis.ticks=element_blank()) +
  geom_point(aes(color = group), shape = 15, size = 20, show.legend = F) +
  scale_color_manual(values = c("#a90606", "#638cb3", "#8c8279", "#cf9930", "#160202", "#cf9930", "#aaaaaa")) +
  geom_text(aes(label=a), size=9, 
            colour = ifelse(logo_data$group=="c" | logo_data$group=="e", "white", "black"),
            fontface = 2) 



  expand_limits(x=c(-11, 9), y=c(-10, 5.2)) +
  scale_x_continuous(breaks=seq(-11, 9, 2)) +
  scale_y_continuous(breaks=seq(-10, 6, 2))
