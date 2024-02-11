use ig_clone;

/*A) Marketing Analysis:
1.Loyal User Reward:*/
SELECT * FROM users
ORDER BY created_at
LIMIT 5;

/*
2.Inactive User Engagement: */
SELECT username
FROM users
LEFT JOIN photos ON users.id = photos.user_id
WHERE photos.id IS NULL;

/*
3.Contest Winner Declaration: */
SELECT username,p.id,p.image_url, COUNT(*) AS total
FROM photos p
INNER JOIN likes l
    ON l.photo_id = p.id
INNER JOIN users u
    ON p.user_id = u.id
GROUP BY p.id
ORDER BY total DESC
LIMIT 1;

/*
4.Hashtag Research: */
SELECT tag_name, COUNT(tag_name) AS total
FROM tags
JOIN `photo tags` t ON tags.id = t.tag_id
GROUP BY tags.id
ORDER BY total DESC
Limit 5;

/*
5.Ad Campaign Launch:*/
SELECT 
    DAYNAME(created_at) AS day,
    COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC
LIMIT 1;

/*B) Investor Metrics:
1.User Engagement:*/
SELECT ROUND((SELECT COUNT(*)FROM photos)/(SELECT COUNT(*) FROM users),2) as average_Posts;

/*
2.Bots & Fake Accounts: */
SELECT u.id,username, COUNT(u.id) As total_likes_by_user
FROM users u
JOIN likes l ON u.id = l.user_id
GROUP BY u.id
HAVING total_likes_by_user = (SELECT COUNT(*) FROM photos);