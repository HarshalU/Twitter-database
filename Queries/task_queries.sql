/* 1. Tweets, users and languages. */

select count(*) from tweets;

select user_lang, count(*) as tweet_count from users group by user_lang order by tweet_count DESC;

select count(*) as tweet_count, user_lang, concat(round((count(*) * 100 / SUM(count(*)) OVER ()), 5), '%') as "tweets%" from users group by user_lang;



/* 2. Retweeting habits */

select concat((p1.tweetRetweetCount * 100 /p1.TotalTweets)::varchar(10), '%') from (select (select count(*) from tweets where retweet_count > 0) as tweetRetweetCount, (select count(*) from tweets) as TotalTweets) p1;

select avg(retweet_count) as average_tweets from tweets;

select concat((p1.tweetRetweetCount * 100 /p1.TotalTweets)::Varchar(10), '%') from (select (select count(*) from tweets where retweet_count <= 0) as tweetRetweetCount, (select count(*) from tweets) as TotalTweets) p1;

select concat((p1.shortRetweetsCount * 100 /p1.TotalTweetsCount), '%') from (select (select count(*) from tweets where retweet_count < (select avg(retweet_count) from tweets)) as shortRetweetsCount, (select count(*) from tweets) as TotalTweetsCount) p1;


/* 3. Hashtags. */

select count(distinct(p1.hashTags)) from (select unnest(string_to_array(CONCAT(hashtag1, ',', hashtag2, ',', hashtag3, ',', hashtag4, ',', hashtag5, ',', hashtag6), ',' )) as hashTags from hashtags) p1 where length(p1.hashTags) > 0;

select distinct(p1.hashTags) as distinctHashtags, count(*) from (select unnest(string_to_array(CONCAT(hashtag1, ',', hashtag2, ',', hashtag3, ',', hashtag4, ',', hashtag5, ',', hashtag6), ',' )) as hashTags from hashtags) p1 where length(p1.hashTags) > 0 group by distinctHashtags order by count DESC offset 0 limit 10;

select qu3.* from (select qu2.*, rank() OVER (PARTITION BY qu2.user_lang ORDER BY hashTagCount DESC) from (select qu1.hashTags, qu1.user_lang, count(*) as hashTagCount from 
	(select unnest(string_to_array(CONCAT(b.hashtag1, ',', b.hashtag2, ',', b.hashtag3, ',', b.hashtag4, ',', b.hashtag5, ',', b.hashtag6), ',' )) as hashTags, b.user_lang from
		(select ha.hashtag1, ha.hashtag2, ha.hashtag3, ha.hashtag4, ha.hashtag5, ha.hashtag6, u.user_lang from 
			(select tweet_id, hashtag1, hashtag2, hashtag3, hashtag4, hashtag5, hashtag6 from hashtags) ha INNER JOIN 
					(select tweet_id, user_lang from users) u on ha.tweet_id = u.tweet_id) b) qu1 
	where length(qu1.hashTags) > 0 group by qu1.hashTags, qu1.user_lang order by hashTagCount DESC) qu2) qu3 where qu3.rank <=3;


/* 4. Replies. */

select count(*) from tweets where (in_reply_to_status_id is null or in_reply_to_screen_name is null or  in_reply_to_user_id is null);

select 1/cast(count(distinct(user_lang)) as float) from users;
