################  Script Purpose ########################
# Uses milestones.csv and features.csv to process data for Tableau vizualization.
# milestones.csv is extarcted out or Rally: Plan -> Timeboxes
# features.csv is extracted from Rally's Portfolio -> Portfolio Items

## WHEN RUNNING FROM WORK with proxy 
#  Make sure to run Sys.setenv(http_proxy= "http://proxy.inbcu.com/:8080") 
#  Must be run FIRST - at start of session. Otherwise it does not take.
library(dplyr) # used for easier data frame manipulation
library(splitstackshape) # used to split multiple values in a cell into separate rows


## Process milestones
#  Milestone data needs to be stored in CSV file (excel file presents difficulties with dates)
milestoneData <- read.table("./data/milestones.csv", sep = ",", header = TRUE, comment.char = "")
milestoneData <- rename(milestoneData, MilestoneID = Formatted.ID, 
                        MilestoneName = Name, MilestoneColor = Display.Color)
#extract milestones status from milestone Notes
extractStatus <- function(x) {ifelse(grepl("Status", x),  sub("\\].*", "", sub(".*\\[", "", x)), "On Track")}
Sys.setlocale('LC_ALL', 'C') #handle warning messages input string 1 is invalid in this locale
milestoneData <- mutate(milestoneData, MilestoneDate = as.Date(as.character(Target.Date), "%m/%d/%y"),
                        MilestoneStatus = sapply(Notes, extractStatus),
                        MilestoneType = ifelse(is.na(MilestoneColor), "TBD",
                                               ifelse(MilestoneColor == "#ee6c19", "Client Deliverable", 
                                                      ifelse(MilestoneColor == "#df1a7b", "External Dependency", "NA"))))

## Process features
#  Note that using quote = "\"" is important here so that we could read in correctly any records that have commas in their values
featureData <- read.table("./data/features.csv", sep = ",", header = TRUE, comment.char = "", quote = "\"", fill = FALSE)
featureData <- rename(featureData, FeatureID = Formatted.ID, FeatureName = Name, BusinessArea = Parent, 
                      FeatureState = State, FeatureStatus = Tags)


## Process feature milestones - multiple milestones are stored in the same cell, separated bu ";".
#  Need to extract each milestone into its own line
denormFeatureData <- cSplit(featureData, "Milestones", sep = ";", direction = "long")
#extract milestone IDs
firstElement <- function(x){x[1]}
milestoneIDs <- strsplit(as.character(denormFeatureData$Milestones), ":")
#extract initiative names (w/o their IDs)
secondElement <- function(x){x[2]}
initiativeNames <- strsplit(as.character(denormFeatureData$BusinessArea), ": ")
denormFeatureData <- mutate(denormFeatureData, 
                            MilestoneID = sapply(milestoneIDs, firstElement),
                            BusinessArea = sapply(initiativeNames, secondElement), 
                            FeatureState = ifelse(FeatureState == "", "Not Started",
                                           ifelse(FeatureState == "Discovering" , "In Tech Discovery",
                                                  ifelse(FeatureState == "Developing", "In Development", 
                                                         ifelse(FeatureState == "Done", "Complete", "NA" )))))

## Merge the feature and milestone data frames. We need to get all features independent of whether or not they have milestones.
#  Merge by milestone ID
mergedData <- merge(denormFeatureData, milestoneData, by.x = "MilestoneID", by.y = "MilestoneID", all.x = TRUE )
plotData <- select(mergedData, MilestoneID, MilestoneName, FeatureID, FeatureName, BusinessArea, MilestoneType, MilestoneDate, 
                   FeatureState, FeatureStatus, MilestoneStatus)

## write the resulting data to an excel file. This will be used for visualization in Tableau.
write.xlsx(plotData, file = "./data/features_end_milestones.xlsx", row.names = FALSE, showNA = FALSE)



