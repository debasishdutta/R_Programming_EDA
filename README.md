# R_Programming_EDA
Exploratory Data Analysis In R Programming

Disclaimer: 
This code snippet is developed with an intension for generic use only. I hereby declare that the code was not part of any of my professional development work. Also, no sensitive or confidential data sources are used for this development. 

Description: 
This is a code for Exploratory Data Analysis (EDA), a must step before any advanced analytics model development. The user defined function takes a R Data frame as an input and produces a final output containing following statistical measures of each variables: 
1. Data Type 
2. No of Missing Values 
3. Fill Rate 
4. No of Unique Values 
5. Minimum Value 
6. Percentile Values (1st-5th Percentile & 95th- 99th Percentile) 
7. Mean Value 
8. Median Value 
9. Dispersion 
10. Mean Absolute Deviation (MAD) 

Note: 
1. This code can handle Integer, Numeric, Factor, Character data types. Any variables which is not numeric or integer is assumed to be character. 
2. For factored or character variables, the frequency of the smallest and largest category will be produced in Min and Max column of the output data frame. 
3. For any factored or character variables Percentile Values, Mean, Median, MAD, Dispersion will be NA. 

Steps For Execution: 
1. Copy the code file to the current working directory of R session. 
2. Import the data in to a R data frame (df_name) 
3. Load the code file using below command: 
source(“Exploratory Data Analysis.R”) 
4. Execute the code using below command: 
eda <- eda_function(df_name) 

Compatibility: 
The code is developed and tested on RStudio (Version 1.0.44) using R-3.3.2

