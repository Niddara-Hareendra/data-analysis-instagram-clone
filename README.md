# <p align="center">User Analysis-Instagram </p>

# <p align="center">![image](https://github.com/Niddara-Hareendra/data-analysis-instagram-clone/assets/154535567/0a5f9215-40a3-488b-9445-150d29cc3509)</p>

**Tools used:**
MySQL , Excel and Tableau 

[SQL Analysis (code)](https://github.com/Niddara-Hareendra/data-analysis-instagram-clone/blob/main/Instagram%20clone.sql)

**Business Problem:** In today's digital landscape, personalized user experiences and targeted advertising are key drivers of engagement and revenue for social media platforms like 
                   Instagram. Understanding user behavior, preferences, and demographics allows platforms to deliver tailored content and advertisements that resonate with individual 
                   users. However, effectively analyzing and leveraging user data while respecting privacy concerns presents a significant challenge.They need a robust and scalable data 
                   analytics solution to handle the vast amount of data and uncover valuable patterns and trends.

**My Approach to Problem:** I'll use SQL with a tool like Tableau to find important information from Instagram's big collection of user and post data. With SQL, I'll discover important 
                         things like how much people like posts, what's trending, and which hashtags or bots are used.
                         This project could address the business problem by developing sophisticated user data identification and analysis capabilities. By implementing features such as user profiling, behavior tracking, and sentiment analysis, My analysis could gain insights into users' interests, preferences, and interactions on the platform. Leveraging  data analytics techniques, We could segment users into distinct audience groups based on factors such as demographics, content consumption patterns, and engagement levels.

**Here are the tasks I need to accomplish to solve the problem:**

A) Marketing Analysis: 

  1)The marketing team wants to reward the most loyal users, those who have been using the platform for the longest time.
- The five oldest users on Instagram

```mysql
SELECT * FROM users 
ORDER BY created_at
LIMIT 5;
```
**Result:**


![Q1](https://github.com/Niddara-Hareendra/data-analysis-instagram-clone/blob/main/5%20oldest.PNG)


 2)The team wants to encourage inactive users to start posting by sending them promotional emails.
  -Users who have never posted a single photo

```mysql
SELECT username
FROM users
LEFT JOIN photos ON users.id = photos.user_id
WHERE photos.id IS NULL;
```
**Result:**

![Q2](https://raw.githubusercontent.com/Niddara-Hareendra/data-analysis-instagram-clone/main/0%20posts.PNG)


 3)The team has organized a contest where the user with the most likes on a single photo wins.
  -User with most likes on single image

  ```mysql
  SELECT username,p.id,p.image_url, COUNT(*) AS total
FROM photos p
INNER JOIN likes l
    ON l.photo_id = p.id
INNER JOIN users u
    ON p.user_id = u.id
GROUP BY p.id
ORDER BY total DESC
LIMIT 1;
```

**Result:**

![Q3](https://raw.githubusercontent.com/Niddara-Hareendra/data-analysis-instagram-clone/main/Top%20Likes.PNG)


 4)A partner brand wants to know the most popular hashtags to use in their posts to reach the most people.
  -Top five most commonly used hashtags

  ```mysql
  SELECT tag_name, COUNT(tag_name) AS total
FROM tags
JOIN `photo tags` t ON tags.id = t.tag_id
GROUP BY tags.id
ORDER BY total DESC
Limit 5;
```

**Result:**

![Q4](https://raw.githubusercontent.com/Niddara-Hareendra/data-analysis-instagram-clone/main/Total%20tags.PNG)


5)The team wants to know the best day of the week to launch ads.
 -Day of the week when most users register

 ```mysql
with cte as (
SELECT 
    DAYNAME(created_at) AS day,COUNT(*) as total, rank() over (order by COUNT(*) desc ) as rank_total
    from users
    group by day)
select day , total, rank_total
FROM cte 
where rank_total = 1
GROUP BY day
ORDER BY rank_total desc;
 ```

**Results**

![Q5](https://raw.githubusercontent.com/Niddara-Hareendra/data-analysis-instagram-clone/main/Best%20day.PNG)


 
**B)Investor Metrics:**

1) Investors want to know if users are still active and posting on Instagram or if they are making fewer posts.
   -The average number of posts per user

```mysql
 SELECT ROUND((SELECT COUNT(*)
                FROM photos)/
                (SELECT COUNT(*) FROM users),2) as average_Posts;
```

**Result**

![Q1](https://raw.githubusercontent.com/Niddara-Hareendra/data-analysis-instagram-clone/main/average%20posts.PNG)

2)Investors want to know if the platform is crowded with fake and dummy accounts.
 -Users who has liked all the photos on site

 ```mysql
SELECT u.id,username, COUNT(u.id) As total_likes_by_user
FROM users u
JOIN likes l ON u.id = l.user_id
GROUP BY u.id
HAVING total_likes_by_user = (SELECT COUNT(*) FROM photos);
```

**Result**

![Q2](https://raw.githubusercontent.com/Niddara-Hareendra/data-analysis-instagram-clone/main/Bots%26Dummies.PNG)

Identify users (potential bots) who have liked every single photo on the site, as this is not typically possible for a normal user.


## Summary

Through comprehensive analysis of Instagram's user data, we have addressed various marketing and investor-related concerns to enhance platform performance and user engagement. For the marketing team.Firstly, regarding marketing initiatives, we successfully identified the five oldest users on the platform, allowing the marketing team to implement a loyal user reward system to recognize and retain these long-standing users. we have pinpointed inactive users who have never posted, enabling targeted promotional strategies to boost engagement.For ad campaign optimization, we identified the best day of the week to launch ads by analyzing user registration trends, ensuring maximum reach and effectiveness of marketing efforts.Addressing investor metrics, we calculated user engagement levels by averaging the number of posts per user and provided insights into platform integrity by identifying potential bot accounts based on unusual activity patterns.
Overall, our analysis equips Instagram with actionable insights to drive marketing strategies, enhance user engagement, and maintain investor confidence in the platform's integrity and growth potential.These insights will not only drive growth and success for Instagram but also contribute to the overall satisfaction and loyalty of its user base. 

 


