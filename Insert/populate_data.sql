\COPY bad_giant_table FROM bad_giant_table.csv csv

INSERT INTO tweets SELECT tweet_id, created_at, text, in_reply_to_screen_name, in_reply_to_status_id, in_reply_to_user_id, retweet_count, tweet_source, retweet_of_tweet_id from bad_giant_table ON CONFLICT(tweet_id) DO NOTHING;

INSERT INTO hashtags (tweet_id, hashtag1, hashtag2, hashtag3, hashtag4, hashtag5, hashtag6) select tweet_id, hashtag1, hashtag2, hashtag3, hashtag4, hashtag5, hashtag6 from bad_giant_table;

INSERT INTO users (user_id, tweet_id, user_name, user_screen_name, user_location, user_utc_offset, user_time_zone, user_followers_count, user_friends_count, user_lang, user_description, user_status_count, user_created_at) SELECT user_id, tweet_id, user_name, user_screen_name, user_location, user_utc_offset, user_time_zone, user_followers_count, user_friends_count, user_lang, user_description, user_status_count, user_created_at from bad_giant_table;