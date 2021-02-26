

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



##INFO TAKEN OUT OF RISK DOC TO USE SDCMICRO FUNCTIONS

#kanon violations
#vector of categorical variable names
catvars <- sim_df %>% 
  select_if(is.factor) %>% 
  colnames()
#dataset with only categorical variables
catdf <- sim_df %>% 
  select_if(is.factor)

#sdcMicro function
freq_keys <- freqCalc(sim_df, keyVars = catvars) #creates sdcMicro class object #uses one set of key vars - may need to test with many

#vio k-anon violations
freq_keys

##SAMPLE FREQ

#number of unique rows
freq_keys$n1

#number of rows with freq = 2
freq_keys$n2

#extract frequency counts for each row
counts <- freq_keys$fk

#combine dataframe with frequencies counts for each row
freq_counts <- cbind(sim_df, counts)
head(freq_counts[, c(colnames(sim_df), "counts")])


#aggregate to get frequencies for each key/combination
agg_counts <- aggregate(counts ~ ., catdf, mean)
nrow(agg_counts) #number of possible keys/combinations

sum(agg_counts$counts == 1) #unique keys/combinations

sum(agg_counts$counts == 2) #keys/combinations with freq = 2 (half of n2 above since that shows rows and this is the combo)

##above is same info in different ways (maybe dont need aggregate unless youw ant to know number of possible keys - can get another way I am sure)

#filter dataframe by counts = 1 and 2 and view freq tables (compare %s with full data to see which responses are leading to most unique cases) - do it with key dataframe (not rows)

##INDIVIDUAL RISK CALCULATION 
indivf <- indivRisk(freq_keys)
inriskvec <- indivf$rk

freq_risk <- cbind(freq_counts, inriskvec) #- higher is worse. 1 = unique? indiv risk based on counts 15 = .066 risk

## global risk
#need sdc object
#fk <- 

glrisk <- mean(inriskvec)

glrisk



# ```{r cont-vars-OLD}
# #do after recoding to see if enough? 
# calcRisks(sdcobj_final)
# 
# ```
# 
# ```{r interval-measure-OLD}
# dRisk(sdcobj_final) #compares manip to raw data cont vars
# 
# dRisk(sdcobj_final, k = .005)
# 
# dRisk(obj = sdcobj_final@origData[,c('iss_off', 'iss_days')], xm = sdcobj_final@manipNumVars[,c('iss_off', 'iss_days')], k = 0.1)
# ```

####manually check cont variables? 

# group by all cat vars and summarize min n (count, min value) for each cont var - e.g., cross tab by all cat vars and 
# 
# ```{r group-by}
# 
# anon_df <- extractManipData(sdcobj_final)
# 
# anon_df %>%
#   group_by(grade_level, sex, race, econ_dis, disability, dis_cat, iss_days) %>%
#   count() %>% 
#   arrange(n)
# 
# ```

#huh <- dRiskRMD(df_sdcobj) #all risk values were 0 - think this needs to compare original and transformed data 


####data utility - same results with raw data
