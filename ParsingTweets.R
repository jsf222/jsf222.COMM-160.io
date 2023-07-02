# Install and load required packages
install.packages("rtweet")
install.packages("httr")
library(rtweet)
library(httr)


# whatever name you assigned to your created app
appname <- "y1675182855398227973jsf9162"

## api key 
key <- "dy2ck1HSxjFpt4FxYThMgMgSF"

## api secret 
secret <- "yourSecretKeyHere"



# create token named "twitter_token"
twitter_token <- create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret,
  access_token = "1675175262919569408-Az4MuAKrSeJ4WDF6DKfKO4H1HuVrXs",
  access_secret = access_secret)



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
