#Josh Feinstein
#This R Script will help create an interactive map using the Tweets.CSV provided in class
# load twitter library - the rtweet library is recommended now over twitteR
library(leaflet)
library(dplyr)
library(ggmap)

# Read the CSV file
tweets <- read.csv("tweetsfromCOMM165.csv", stringsAsFactors = FALSE)

# Filter out tweets without location information
tweets <- tweets %>%
  filter(!is.na(ulocation))
#Filter to only include tweets with #News
tweets <- tweets[grepl("#NEWS", tweets$tweet_text, ignore.case = TRUE), ]

  

# Geocode the location names to obtain latitude and longitude coordinates
geocoded <- geocode(tweets$ulocation)

# Combine the geocoded data with the original tweet data
tweets <- cbind(tweets, geocoded)

# Create a leaflet map
map <- leaflet() %>%
  addTiles()

# Add tweet markers to the map
map <- map %>%
  addMarkers(
    data = tweets,
    lat = ~lat,
    lng = ~lon,
    popup = ~tweet_text
  )

# Display the map
map
