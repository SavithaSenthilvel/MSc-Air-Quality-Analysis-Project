# Load libraries
library(readr)
library(dplyr)
library(ggplot2)

# Read the data
air_quality <- read_csv("combined_data.csv", 
                        col_types = cols(`Date.and.Time` = col_datetime(format = "%d-%m-%Y %H:%M"),
                                         `PM.sub.10..sub.` = col_double(),
                                         `PM.sub.2.5..sub.` = col_double(),
                                         Location = col_character()))

colnames(air_quality) <- c("Date_and_Time", "PM10", "PM2.5", "Location")
str(air_quality)
summary(air_quality)
any(is.na(air_quality))
head(air_quality)




#Plot: PM10 Levels Over Time (for Each Location)
#Explanation: This plot shows the trend of PM10 levels over time, with each line representing a different location.
#Inference: From the plot, we observe variations in PM10 levels across different locations over time. For example, Location A consistently exhibits higher PM10 levels compared to Location B, suggesting potential differences in air quality between these areas. Peaks and troughs in the lines indicate fluctuations in pollution levels, which may be influenced by factors such as traffic, industrial activities, or weather conditions.
ggplot(air_quality, aes(x = Date_and_Time)) +
  geom_line(aes(y = PM10, color = Location)) +
  labs(title = "PM10 Levels Over Time", y = "PM10", color = "Location") +
  theme_minimal()


#Plot: PM2.5 Levels Over Time (for Each Location)
#Explanation: Similar to the PM10 plot, this visualization illustrates the trend of PM2.5 levels over time for each location.
#Inference: We analyze the PM2.5 levels across different locations to identify patterns and variations. Comparing with the PM10 plot, we may observe differences in the magnitude of PM2.5 levels and their temporal patterns. PM2.5 levels are often associated with fine particulate matter from various sources like vehicle emissions, industrial processes, and combustion activities. Understanding these trends can provide insights into the sources and dynamics of air pollution in different areas.

ggplot(air_quality, aes(x = Date_and_Time)) +
  geom_line(aes(y = PM2.5, color = Location)) +
  labs(title = "PM2.5 Levels Over Time", y = "PM2.5", color = "Location") +
  theme_minimal()


#Boxplot: PM10 Across Locations
#Explanation: This boxplot compares the distribution of PM10 levels across different locations, allowing for visual comparison of central tendency, spread, and potential outliers.
#Inference: By examining the boxplots, we can identify variations in PM10 levels between locations. Locations with wider interquartile ranges or higher median values may indicate higher pollution levels or different pollution sources compared to others. Outliers in certain locations may signify occasional spikes in pollution, potentially due to localized factors like construction work, wildfires, or events impacting air quality.
ggplot(air_quality, aes(x = Location, y = PM10)) +
  geom_boxplot() +
  labs(title = "Boxplot of PM10 Across Locations", x = "Location", y = "PM10") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))

#Boxplot: PM2.5 Across Locations
#Explanation: Similar to the PM10 boxplot, this visualization compares the distribution of PM2.5 levels across different locations.
#Inference: Comparing the boxplots of PM2.5 levels, we can discern similarities and differences in pollution levels between locations. Locations with consistently higher or lower PM2.5 levels relative to others may suggest underlying environmental or anthropogenic factors influencing air quality. Additionally, examining the spread and variability of PM2.5 levels provides insights into the spatial heterogeneity of air pollution and potential hotspots requiring targeted interventions.

ggplot(air_quality, aes(x = Location, y = PM2.5)) +
  geom_boxplot() +
  labs(title = "Boxplot of PM2.5 Across Locations", x = "Location", y = "PM2.5") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))


#Correlation Matrix
#Explanation: The correlation matrix quantifies the strength and direction of linear relationships between PM10 and PM2.5 levels.
#Inference: A positive correlation coefficient indicates a direct relationship between PM10 and PM2.5 levels, suggesting that increases in one pollutant are associated with increases in the other. Understanding the correlation between these pollutants helps identify common emission sources or atmospheric processes driving their concentrations. Additionally, a high correlation coefficient may imply shared health impacts associated with exposure to both pollutants, emphasizing the importance of comprehensive air quality management strategies.

correlation_matrix <- cor(select(air_quality, PM10, PM2.5))

# Print correlation matrix
print(correlation_matrix)


