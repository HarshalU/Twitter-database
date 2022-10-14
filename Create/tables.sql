CREATE TABLE bad_giant_table (
    created_at timestamp with time zone,
    text varchar(255),
    tweet_id bigint PRIMARY KEY,
    in_reply_to_screen_name  varchar(255),
    in_reply_to_status_id    bigint,
    in_reply_to_user_id      bigint,
    retweet_count int,
    tweet_source  varchar(255),
    retweet_of_tweet_id bigint,

    hashtag1 varchar(144),
    hashtag2 varchar(144),
    hashtag3 varchar(144),
    hashtag4 varchar(144),
    hashtag5 varchar(144),
    hashtag6 varchar(144),

    user_id bigint,
    user_name character varying(255),
    user_screen_name  character varying(255),
    user_location character varying(255), 
    user_utc_offset integer,
    user_time_zone character varying(127),
    user_followers_count integer,
    user_friends_count integer,
    user_lang character varying(10),
    user_description varchar(255),
    user_status_count varchar(255),
    user_created_at timestamp with time zone
);


CREATE TABLE if not exists tweets (
    tweet_id bigint PRIMARY KEY,
    created_at timestamp with time zone,
    text varchar(255),
    in_reply_to_screen_name  varchar(255),
    in_reply_to_status_id    bigint,
    in_reply_to_user_id      bigint,
    retweet_count int,
    tweet_source  varchar(255),
    retweet_of_tweet_id bigint);



CREATE TABLE if not exists hashtags (
    tweet_id bigint,
    hashtag1 varchar(144),
    hashtag2 varchar(144),
    hashtag3 varchar(144),
    hashtag4 varchar(144),
    hashtag5 varchar(144),
    hashtag6 varchar(144),
    CONSTRAINT foreignKeyHash FOREIGN KEY(tweet_id) REFERENCES tweets(tweet_id));



CREATE TABLE if not exists users (
    user_id bigint,
    tweet_id bigint,
    user_name character varying(255),
    user_screen_name  character varying(255),
    user_location character varying(255), 
    user_utc_offset integer,
    user_time_zone character varying(127),
    user_followers_count integer,
    user_friends_count integer,
    user_lang character varying(10),
    user_description varchar(255),
    user_status_count varchar(255),
    user_created_at timestamp with time zone,
    CONSTRAINT foreignKeyUser FOREIGN KEY(tweet_id) REFERENCES tweets(tweet_id));