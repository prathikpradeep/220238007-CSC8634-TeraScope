# setwd("/Volumes/Prathik/MSc Data Science/Semester 1/Block 3/Cloud Computing - CSC8634/Assignment/Assignment/220238007-CSC8634-TeraScope/Cloud_Computing_TeraScope_Assignment/data")
# application_checkpoints <- read.csv("application_checkpoints.csv")

#Setting seed so results are reproducible
set.seed(220238007)

####### Question 1
## Pre-processing for application_checkpoints data
#Converting the timestamp in application_checkpoints to the correct format and datatype
options(digits.secs=3)
application_checkpoints$timestamp <- ymd_hms(application_checkpoints %>%
                                               mutate(time_clean = lubridate::ymd_hms(timestamp)) %>%
                                               mutate(date = format(time_clean,format =  '%F %H:%M:%OS')) %>%
                                               dplyr::pull(date))

## Pre-processing for gpu data
#Converting the timestamp in gpu to the correct format and datatype
gpu$timestamp <- ymd_hms(gpu %>%
                           mutate(time_clean = lubridate::ymd_hms(timestamp)) %>%
                           mutate(date = format(time_clean,format =  '%F %H:%M:%OS')) %>%
                           dplyr::pull(date))

#Converting gpuSerial from factor to character
gpu$gpuSerial = as.character(gpu$gpuSerial)


# #Taking a sample of code
# application_checkpoints <- application_checkpoints %>%
#   setorder(-jobId)
# 
# application_checkpoints_filtered <- data.frame()
# 
# for (j in 1:300)
#   {
#   taskid <- unique(application_checkpoints$taskId)[j]
#   temp <- application_checkpoints %>%
#     filter(taskId == taskid)
#   application_checkpoints_filtered <- rbind(application_checkpoints_filtered,temp)
# }
# application_checkpoints <- application_checkpoints_filtered





## Merging Application Checkpoints and GPU on hostname and similar timestamps
# Sample data
setDT(application_checkpoints)
setDT(gpu)

# Create time column by which to do a rolling join
application_checkpoints[, time := timestamp]
gpu[, time := timestamp]
setkey(application_checkpoints, time)
setkey(gpu, time)

# Rolling join by nearest time
gpu_checkpoints <- gpu[application_checkpoints, on = .(hostname, time), roll = "nearest"]


##Converting gpu_checkpoints to a dataframe
gpu_checkpoints <- data.frame(gpu_checkpoints)

#Removing timestamp and time columns from gpu_checkpoints
gpu_checkpoints <- gpu_checkpoints[,!names(gpu_checkpoints) %in% c("timestamp", "time")]

#Changing the name of the 8th column to timestamp
names(gpu_checkpoints)[8]<-paste("timestamp")

#Adding grouped_id for each Event Name in per Task Id
gpu_checkpoints <- gpu_checkpoints %>%
 setorder(taskId,eventName,eventType) %>%
 group_by(eventType) %>%
 mutate(grouped_id = row_number())

#Grouping the values of Power draw, Gpu Temp, Gpu Utilization Percentage and Gpu Memory Utilization Percentage
gpu_checkpoints <- gpu_checkpoints %>%
  group_by(grouped_id) %>%
  mutate(powerDrawWatt = mean(powerDrawWatt)) %>%
  mutate(gpuTempC = mean(gpuTempC)) %>%
  mutate(gpuUtilPerc = mean(gpuUtilPerc)) %>%
  mutate(gpuMemUtilPerc = mean(gpuMemUtilPerc))

#Spreading Event Type to Columns using Event Type as the Key and Timestamp as the values
gpu_checkpoints <- gpu_checkpoints %>%
 spread(eventType,timestamp)

#Computing Event Time in milliseconds
gpu_checkpoints$eventTime_in_ms <- round(as.numeric(difftime(gpu_checkpoints$STOP, gpu_checkpoints$START,units ="secs"))*1000, 3)

#Removing the columns grouped_id, Start and Stop
gpu_checkpoints <- gpu_checkpoints[,!names(gpu_checkpoints) %in% c("grouped_id", "START", "STOP")]



####### Question 2
#Joining task_x_y to gpu_checkpoints table
gpu_checkpoints_task <- gpu_checkpoints %>%
                          left_join(task_x_y,by=c("taskId","jobId"))

#Filtering out only TotalRender
gpu_checkpoints_task <- gpu_checkpoints_task %>%
  filter(eventName == "TotalRender")
