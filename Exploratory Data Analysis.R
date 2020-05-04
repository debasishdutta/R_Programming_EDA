################################################################################################
############################ Enhanced Data Dictionary Function      ############################
#########################    Developer:   Debasish Dutta            ############################
#########################    Date:   	  December 2017             ############################
######                       Input:       1. Name of Data Frame (Mixed Data Type Allowed) ######
######                       Output:      1. Data Frame Will Be Returned By The Function  ######
################################################################################################

eda_function <- function(df_name) {
  ################### Installing & Loading mlr Package ###################
  if (!require("mlr", character.only = TRUE))
  {
    install.packages("mlr", dep = TRUE)
    if (!require("mlr", character.only = TRUE))
      stop("mlr Package not found")
  }
  
  ################### Basic Descriptive Statistics ###################
  options(scipen = 999, "digits" = 0)
  summary_table_all <- summarizeColumns(df_name)
  names(summary_table_all) <- c(
    "Column_Name",
    "Data_Type",
    "No_Missing",
    "Mean",
    "Dispersion",
    "Median",
    "Mean Absolute Deviation",
    "Min",
    "Max",
    "No_Unique_Values"
  )
  
  ################### Special Descriptive Statistics For Numeric Variables ###################
  if (any(
    summary_table_all$Data_Type == "numeric" |
    summary_table_all$Data_Type == "integer"
  )) {
    num_data_summary_1 <-
      summary_table_all[which(
        summary_table_all$Data_Type == "numeric" |
          summary_table_all$Data_Type == "integer"
      ),]
    num_data_summary_2 <- as.data.frame(t(apply(
      as.data.frame(df_name[, num_data_summary_1$Column_Name]),
      2,
      quantile,
      probs = c(seq(0.01, 0.05, by = 0.01),
                seq(0.95, 0.99, by = 0.01)),
      na.rm = TRUE
    )))
    num_data_summary_2$Column_Name <- row.names(num_data_summary_2)
    num_data_summary_3 <- merge(num_data_summary_1,
                                num_data_summary_2,
                                by = "Column_Name",
                                all.x = T)
    temp_df <-
      as.data.frame(apply(as.data.frame(df_name[, num_data_summary_1$Column_Name]), 2,
                          function(x)
                            length(unique(x))))
    temp_df$Column_Name <- row.names(temp_df)
    names(temp_df)[1] <- "Unique_Values"
    row.names(temp_df) <- NULL
    num_final <-  merge(num_data_summary_3,
                        temp_df,
                        by = "Column_Name",
                        all.x = T)
    num_final$No_Unique_Values <- num_final$Unique_Values
    num_final <- num_final[, -ncol(num_final)]
    num_final$Fill_Rate <-
      ((nrow(df_name) - num_final$No_Missing) / nrow(df_name)) * 100
    num_final <-
      num_final[, c(1, 2, 3, 21, 10, 8, 11, 12, 13, 14, 15, 4, 6, 16, 17, 18, 19, 20, 9, 5, 7)]
  } else{
    num_final <-  NULL
  }
  
  ################ Special Descriptive Statistics For Non Numeric Variables #################
  if (any(!summary_table_all$Data_Type %in% c("numeric", "integer"))) {
    non_num_data_summary_1 <-
      summary_table_all[-which(
        summary_table_all$Data_Type == "numeric" |
          summary_table_all$Data_Type == "integer"
      ),]
    non_num_data_summary_1$Fill_Rate <-
      ((nrow(df_name) - non_num_data_summary_1$No_Missing) / nrow(df_name)) *
      100
    
    non_num_data_summary_2 <-
      data.frame(
        Column_Name = non_num_data_summary_1$Column_Name,
        Data_Type = non_num_data_summary_1$Data_Type,
        No_Missing = non_num_data_summary_1$No_Missing,
        Fill_Rate = non_num_data_summary_1$Fill_Rate,
        No_Unique_Values = non_num_data_summary_1$No_Unique_Values,
        Min = non_num_data_summary_1$Min
      )
    non_num_data_summary_2[, 7:18] <- NA
    non_num_data_summary_3 <-
      cbind(non_num_data_summary_2, non_num_data_summary_1$Max)
    non_num_data_summary_3[, 20:21] <- NA
    non_num_final <- non_num_data_summary_3
    names(non_num_final) <- names(num_final)
  } else {
    non_num_final <- NULL
  }
  
  final_eda <- rbind(num_final, non_num_final)
  return(final_eda)
}
