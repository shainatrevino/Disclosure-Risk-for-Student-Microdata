

#vector of categorical variable names
catvars <- sim_df %>% 
  select_if(is.factor) %>% 
  colnames()
#dataset with only categorical variables
catdf <- sim_df %>% 
  select_if(is.factor)

#sdcMicro function
freq_keys <- freqCalc(sim_df, keyVars = catvars) #creates sdcMicro object

#vio k-anon violations
freq_keys

#number of unique rows
freq_keys$n1
#number of rows with freq = 2
freq_keys$n2
#frequency counts for each row
counts <- freq_keys$fk
#combine dataframe with frequencies counts for each row
freq_counts <- cbind(sim_df, counts)
head(freq_counts[, c(colnames(sim_df), "counts")])

#aggregate to get frequencies for each key/combination
agg_counts <- aggregate(counts ~ ., catdf, mean)
nrow(agg_counts) #number of possible keys/combinations

sum(agg_counts$counts == 1) #unique keys/combinations

sum(agg_counts$counts == 2) #keys/combinations with freq = 2

##above is same info in different ways (maybe dont need aggregate unless youw ant to know number of possible keys - can get another way I am sure)


##INDIVIDUAL RISK CALCULATION 
indivf <- indivRisk(freq_keys)
inriskvec <- indivf$rk

freq_risk <- cbind(freq_counts, inriskvec) #- higher is worse. 1 = unique? indiv risk based on counts 15 = .066 risk