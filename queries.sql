

show tables ;

create database CHAT_STORE;

create table organization (
id int auto_increment primary key,
name text);

create table channel (
id int auto_increment primary key,
name text);

ALTER TABLE channel
ADD COLUMN organization_id INT;

alter table channel
add foreign key (organization_id) references organization(id);

create table user (
id int auto_increment primary key,
name text);

create table Channel_Users (
   user_id INT,
   channel_id INT,
   PRIMARY KEY (user_id, channel_id),
   FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
   FOREIGN KEY (channel_id) REFERENCES channel(id) ON DELETE CASCADE
);

create table message (
id int auto_increment primary key,
post_time datetime,
user_id int,
channel_id int,
content text ,
FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
   FOREIGN KEY (channel_id) REFERENCES channel(id) ON DELETE CASCADE
);



insert into organization(name) values('Lambda School');
insert into user(name) values('Alice'),('Bob'),('Chris');
insert into channel(name) values('#general'),('#random');

update  channel
set organization_id=1;

INSERT INTO message
       (post_time,user_id, channel_id, content)
        VALUES
(now(),(SELECT id FROM user WHERE name = 'Alice'), (SELECT id FROM channel WHERE name = '#general'), "Hey guys! I'm Alice"),
  (NOW(), (SELECT id FROM user WHERE name = 'Alice'), (SELECT id FROM channel WHERE name = '#random'), "Hello buddies! I'm Alice"),
  (NOW(), (SELECT id FROM user WHERE name = 'Bob'), (SELECT id FROM channel WHERE name = '#general'), "Hey guys! I'm Bob"),
  (NOW(), (SELECT id FROM user WHERE name = 'Alice'), (SELECT id FROM channel WHERE name = '#general'), "Hello Bob!"),
  (NOW(), (SELECT id FROM user WHERE name = 'Chris'), (SELECT id FROM channel WHERE name = '#random'), "Hey guys! I'm Chris"),
  (NOW(), (SELECT id FROM user WHERE name = 'Bob'), (SELECT id FROM channel WHERE name = '#general'), "That's Great!"),
  (NOW(), (SELECT id FROM user WHERE name = 'Chris'), (SELECT id FROM channel WHERE name = '#random'), "Let's play a game"),
  (NOW(), (SELECT id FROM user WHERE name = 'Alice'), (SELECT id FROM channel WHERE name = '#random'), "I think playing online games is boring"),
  (NOW(), (SELECT id FROM user WHERE name = 'Alice'), (SELECT id FROM channel WHERE name = '#general'), "Yeah! we shall meet today at Cafe Coffee Day"),
  (NOW(), (SELECT id FROM user WHERE name = 'Bob'), (SELECT id FROM channel WHERE name = '#general'), "Okay!");


INSERT INTO Channel_Users (user_id,channel_id)
VALUES 
  ((SELECT id FROM user WHERE name = 'Alice'),(SELECT id FROM channel WHERE name = '#general')),
  ((SELECT id FROM user WHERE name = 'Alice'),(SELECT id FROM channel WHERE name = '#random')),
  ((SELECT id FROM user WHERE name = 'Bob'),(SELECT id FROM channel WHERE name = '#general')),
  ((SELECT id FROM user WHERE name = 'Chris'),(SELECT id FROM channel WHERE name = '#random'));
  
--   List all organization names.
select * from organization;

-- List all channel names.
select * from channel;

-- List all channels in a specific organization by organization name
select * from channel 
inner join organization 
on channel.organization_id=organization.id 
where organization.name like 'Lambda%';

-- List all messages in a specific channel by channel name #general in order of post_time, descending
select message.content,channel.name,message.post_time from message
 inner join 
 channel 
 on message.channel_id=channel.id
 where channel.name='#general' 
 order by message.post_time desc;

-- List all channels to which user Alice belongs.
select channel.name from channel 
inner join 
(
select Channel_Users.channel_id as id from Channel_Users 
inner join user on user.id=Channel_Users.user_id where user.name like 'Alice%'
) 
as temp 
on temp.id=channel.id ;

-- List all users that belong to channel #general
select * from user 
join 
Channel_Users 
on Channel_Users.user_id=user.id 
join 
channel 
on Channel_Users.channel_id=channel.id
 where channel.name like '#general%';

-- List all messages in all channels by user Alice
select message.channel_id,message.content,user.name from message 
join 
user on user.id=message.user_id 
where user.name like 'Alice';

-- List all messages in #random by user Bob.
select message.channel_id,message.content,user.name from message 
join 
user 
on user.id=message.user_id  
join 
channel 
on channel.id=message.channel_id 
where channel.name like '#random%' 
AND user.name like 'Bob%';

-- List the count of messages across all channels per user. (Hint: COUNT, GROUP BY.)
select user.name as 'User Name',count(*) as 'Message Count' from message 
join 
user 
on user.id=message.user_id  
join 
channel 
on channel.id=message.channel_id 
group by user.name ;

-- List the count of messages per user per channel.
select user.name as 'User',channel.name as 'Channel',count(*) as 'Message Count' from message 
join 
user 
on user.id=message.user_id  
join 
channel 
on channel.id=message.channel_id 
group by user.name,channel.name;

-- What SQL keywords or concept would you use if you wanted to automatically delete all messages by a user if that user were deleted from the user table?
-- ANS: To automatically delete all messages associated with a user when that user is deleted from the user table,
--  you would use foreign key constraints with the "ON DELETE CASCADE" option.

select * from user;
select * from message;


select * from Channel_Users;