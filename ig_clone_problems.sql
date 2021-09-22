-- Finding 5 oldest users

select username, created_at from users order by created_at limit 5;

 -- What day of the week do most users register on?

select dayname(created_at) as day, count(*) as total from users group by day order by total desc limit 2 ;

-- find users who have never posted a photo

select username 
from users
left join photos
on users.id = photos.user_id
where photos.id is NULL;

SET @@sql_mode='';
SET @old_sql_mode=@@sql_mode; 

-- what is the single most liked photo in the database
select username, photos.id, photos.image_url, count(*) as total from photos
join likes
on likes.photo_id = photos.id 
join users
on photos.user_id = users.id
group by photos.id
order by total desc
limit 1;

-- How many times does the average user post?

SELECT (SELECT Count(*) 
        FROM   photos) / (SELECT Count(*) 
                          FROM   users) AS avg; 

-- What are the top 5 most commonly used hashtags?
select tags.tag_name, count(*) as total from photo_tags
join tags
on photo_tags.tag_id = tags.id
group by tags.id
order by total desc limit 5;

-- Find users who have liked every single photo on the site
select username, count(*) as num_likes from users
join likes
on users.id = likes.user_id
group by likes.user_id
having num_likes = (select count(*) from photos);