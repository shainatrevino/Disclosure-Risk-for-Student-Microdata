#Randomly generated demographics from Wakefield package

library(wakefield)
library(tidyverse)


set.seed(1312021)
wake_sim_data <- r_data_frame(n = 25000,
                              id,
                              grade_level(x = c("Pre-K", "Kindergarten", "1st Grade", "2nd Grade", "3rd Grade", "4th Grade", "5th Grade", "6th Grade",
                                                "7th Grade", "8th Grade", "9th Grade", "10th Grade", "11th Grade", "12th Grade"),
                                          prob = c(.7, rep(1, 10), .9, .85, .8)),
                              sex(x = c("Male", "Female"), prob = c(.49, .50)),
                              race(x = c("White", "Black", "Hispanic", "Asian", "Multi-racial", "Native", "Pacific Islander", "Other"),
                                   prob = c(.63, .1395, .16, .04, .02, .007, .0015, .002)),
                              gpa(mean = 82, sd = 4.5),
                              answer(x = c("No", "Yes"), prob = c(.5, .5), name = "econ_dis"),
                              answer(x = c("No", "Yes"), prob = c(.85, .15), name = "disability"),
                              level(x = c("Autism", "Emotional Disturbance", "Intellectual Disability", "Developmental Delay", 
                                          "Speech/Language Impairments", "Specific Learning Disability", "Other"), 
                                    prob = c(.11, .05, .06, .07, .20, .33, .18), name = "dis_cat"),
                              level(x = c("English", "Spanish", "Chinese", "Vietnamese", "Arabic", "Swahili", "Russian", "German", "Other"),
                                    prob = c(239, 41, 3.5, 1.5, 1.2, .22, .94, .92, 30), name = "lang")) %>% 
  r_na(cols = 3:4, prob = .01) %>% 
  janitor::clean_names() %>% 
  mutate(id = as.numeric(id))

#generating additional admin variables based on distributions

#days absent
set.seed(1302021)
days_absent_old <- round(rlnorm(25000, .6, 1.15)) 
hist(days_absent)
range(days_absent)
summary(as.factor(days_absent))

# days_absent
set.seed(1302021)
days_absent <- c(rep(0, 4516),
              sample(1:5, 17000, prob = c(.25, .18, .13, .11, .05), replace = TRUE),
              sample(6:15, 2900, prob = c(.26, .20, .12, .07, .07, .05, .05, .04, .04, .03), replace = TRUE),
              sample(16:60, 575, prob = c(.3, .3, .25, .15, .15, .13, .13, .13, .13, .13, .08, .12, .08, .12, .12, .12, .12, .08, .12, .12, .12, .12, .06, .06, .06, .06, .06, .06, .06, .06, .06, .06, .03, .03, .03, .03, .03, .03, .03, .03, .03, .03, .03, .03, .03), replace = TRUE),
              63, 69, 75, 79, 83, 95, 101, 111, 116) #9 tail values

subj_off1 <- sample(subj_off) #randomize

# n. of subj offenses
set.seed(1302021)
subj_off <- c(rep(0, 20130),
              sample(1:2, 2500, prob = c(.75, .25), replace = TRUE),
              sample(3:5, 750, prob = c(.6, .2, .2), replace = TRUE),
              sample(6:20, 500, prob = c(10, 10, 6, 7, 6, 5, 3, 2, .3, 1, 2, 1, .3, .2, 1), replace = TRUE),
              rep(NA, 1120))

subj_off1 <- sample(subj_off) #randomize

# n. of ISS offenses
set.seed(1302021)
iss_off <- c(rep(0, 21500),
             sample(1:10, 2300, prob = c(.5, .2, .1, .07, .04, .04, .02, .01, .01, .005), replace = TRUE),
             sample(11:25, 80, prob = c(.19, .15, .1, .09, .06, .06, .05, .05, .05, .04, .025, .05, .025, .05, .03), replace = TRUE),
             rep(NA, 1120))

iss_off1 <- sample(iss_off)

#total iss days
set.seed(1302021)  
iss_days <- c(rep(0, 21500), 
              sample(1:5, 2030, prob = c(.5, .3, .2, .08, .05), replace = TRUE),
              sample(6:14, 300, prob = c(.4, .3, .15, .15, .1, .1, .05, .05, .025), replace = TRUE),
              rep(15, 11), rep(16, 9), rep(17, 7), rep(18, 6), rep(19, 3), rep(20, 4), rep(21, 3), 23, 24, 27, 28, 28, 30, 31,
              rep(NA, 1120))#1220 NA values after combining mutate NA for all iss_count NAs

iss_days1 <- sample(iss_days)

#dependent variables (iss count & days)
set.seed(1312021)
id <- sample(25000)

issdf <- data.frame(id, iss_off, iss_days, subj_off, days_absent)

#merge datasets

sim_data <- left_join(wake_sim_data, issdf)

#tidy

sim_df <- sim_data %>% 
  mutate_if(is.character, as.factor) %>% 
  mutate(dis_cat = ifelse(disability == "No", "Not Applicable", as.character(dis_cat))) %>% #if disability = N category = not applicable 
  mutate_if(is.character, as.factor)

str(sim_df)

#rio::export(sim_df, file = "sim_df.csv")
