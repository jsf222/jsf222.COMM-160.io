# Install and load the rtweet package
install.packages("rtweet")
library(rtweet)

# Set up your Twitter API credentials
create_token(
  app = "your_app_name",
  consumer_key = "your_consumer_key",
  consumer_secret = "your_consumer_secret",
  access_token = "your_access_token",
  access_secret = "your_access_secret"
)

# Search for tweets with the specified criteria
tweets <- search_tweets(
  "#Ukraine",
  n = 100,  # Number of tweets to retrieve (max: 100)
  result_type = "recent",
  include_rts = FALSE,
  retryonratelimit = TRUE
)

# Filter tweets with at least 1000 likes and retweets from the last 5 weeks
filtered_tweets <- subset(tweets, favorites + retweets >= 1000 & created_at >= as.POSIXct(Sys.Date() - (5 * 7)))

# Create a data frame with the required fields
data <- data.frame(
  Text = filtered_tweets$text,
  Likes = filtered_tweets$favorites,
  Retweets = filtered_tweets$retweets,
  Username = filtered_tweets$user_name,
  Date = filtered_tweets$created_at,
  FollowerCount = filtered_tweets$user_followers_count,
  Location = filtered_tweets$location
)

# Save the data frame to a CSV file
write.csv(data, "parsed_tweets.csv", row.names = FALSE)
