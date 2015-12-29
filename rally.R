## Processing miletones and features from Rally to a form suitable for display in Tableau
## Milestone data needs to be stored in CSV file (excel file presents difficulties with dates)
milestoneData <- read.table("./data/milestones.csv", sep = ",", header = TRUE, comment.char = "")
milestoneData <- mutate(milestoneData, correctDate = as.Date(as.character(Target.Date), "%m/%d/%y"))

## Read in milestones from Excel - DON'T use this approach - messes up dates
#milestoneData <- read.xlsx2("./data/milestones.xlsx", sheetIndex = 1, header = TRUE)

## Read in features
library(xlsx)
featureData <- read.xlsx("./data/features.xlsx", sheetIndex = 1, header = TRUE)

##something is not correct here ************* Doesn't get all rows
#featureData <- read.table("./data/features.csv", sep = ",", header = TRUE, comment.char = "", quote = "", fill = TRUE)

## process feature milestones - multiple milestones are stored in the same cell, separated bu ";".
## need to extract each milestone in its own line
library(splitstackshape)
denormFeatureData <- cSplit(featureData, "Milestones", sep = ";", direction = "long")

#extract milestone IDs
firstElement <- function(x){x[1]}
milestoneIDs <- strsplit(as.character(denormFeatureData$Milestones), ":")
#extract initiative names (w/o their IDs)
secondElement <- function(x){x[2]}
initiativeNames <- strsplit(as.character(denormFeatureData$Parent), ": ")
denormFeatureData <- mutate(denormFeatureData, 
                            milestoneID = sapply(milestoneIDs, firstElement),
                            Parent = sapply(initiativeNames, secondElement)) 
## Merge the feature and milestone data frames. We need to get all features independent on whether or not they have milestones
## Merge by milestone ID
mergedData <- merge(denormFeatureData, milestoneData, by.x = "milestoneID", by.y = "Formatted.ID", all.x = TRUE )
mergedData <- rename(mergedData, FeatureID = Formatted.ID, MilestoneID = milestoneID, 
                     FeatureName = Name.x, MilestoneName = Name.y, MilestoneDate = correctDate, 
                     MilestoneColor = Display.Color,
                     BusinessArea = Parent)
plotData <- select(mergedData, MilestoneID, MilestoneName, FeatureID, FeatureName, BusinessArea, MilestoneColor, MilestoneDate, State, Tags)
## TODO - is there a better way to do a switch-like operation?
adjustedPlotData <- mutate(plotData, Status = Tags, 
                  # MilestoneDate = ifelse(is.na(MilestoneDate), as.Date(mdy("4/1/2016")), as.Date(MilestoneDate)),
                  # MilestoneName = ifelse(is.na(MilestoneName), "TBD", as.character(MilestoneName)),
                   MilestoneType = ifelse(is.na(MilestoneColor), "TBD",
                                                                      ifelse(MilestoneColor == "#ee6c19", "Client Deliverable", 
                                                                      ifelse(MilestoneColor == "#df1a7b", "External Dependency", "NA"))),
                   State = ifelse(is.na(State), "Not Started",
                                  ifelse(State == "Discovering" , "In Tech Discovery",
                                  ifelse(State == "Developing", "In Development", 
                                  ifelse(State == "Done", "Complete", "NA" )))))
write.xlsx(adjustedPlotData, file = "./data/rally1.xlsx", row.names = FALSE, showNA = FALSE)

