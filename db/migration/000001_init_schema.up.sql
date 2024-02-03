-- this table defines users in the messenger app
create table users (
    id bigserial primary key,
    username varchar(128) unique,
    password varchar(64),
    image varchar,
    bio varchar(128),
    display_profile_picture boolean default true
);

-- this table defines contacts
-- -> if a user deletes account, his/her contacts will be deleted
-- -> if a user deletes account, he/she will be removed from other user's contacts
create table contacts (
    user_id bigint references users(id) on delete cascade,
    contact_id bigint references users(id) on delete cascade,
    contact_name varchar(64),
    primary key (user_id, contact_id)
);

-- this table defines chats,
-- -> is_dead is true if a participant of a chat deletes account and other
--    and messages cannot be sent to that chat anymore
create table chats (
    id bigserial primary key,
    is_dead boolean default false,
    created_at timestamp default now()
);

-- this tables defines relationship between users and chats
-- -> if a chat is deleted, all records related to the chat is also deleted
-- -> if a user's account is deleted, his/her membership to all his chats are deleted,
--    although his/her messages will remain in the chat
create table chat_participants (
    chat_id bigint references chats(id) on delete cascade,
    user_id bigint references users(id) on delete cascade,
    primary key (chat_id, user_id)
);

-- this table defines chat messages
-- -> if the chat is deleted, its messages will also be deleted (done by db constraints)
-- -> if the sender deletes his/her account. message sender_id will be null
--    which indicates sender's account is deleted (done by db constraints)
-- -> users cannot leave chats, they can only delete chats, and chats are deleted
--    for both sides of the chat
-- -> this table does not check if sender_id is in the chat or not (must be checked in server)
create table chat_messages (
    id bigserial primary key,
    chat_id bigint references chats(id) on delete cascade,
    sender_id bigint references users(id) on delete set null,
    content varchar(512),
    created_at timestamp default now()
);

-- this tables defines groups
-- -> if group owner deletes account. group will remain but without an owner
--    and messages cannot be sent to that group. but users can use older messages
--    because those will not be deleted (server must check if group owner_id = null
--    no messages must be sent to the group)
-- -> only owner can add new group participants (groups are private in this app)
create table groups (
    id bigserial primary key,
    name varchar(64) not null,
    image varchar,
    description varchar(128),
    owner_id bigint references users(id) on delete set null,
    created_at timestamp default now()
);

-- this tables defines relationship between users and groups
-- -> if a group is deleted, all records related to the group are also deleted
-- -> if a user's account is deleted, his/her membership to all his group are deleted,
--    although his/her messages will remain in the group
create table group_participants (
    group_id bigint references groups(id) on delete cascade,
    user_id bigint references users(id) on delete cascade,
    primary key (group_id, user_id)
);

-- this table defines group messages
-- -> if the group is deleted, its messages will also be deleted (done by db constraints)
-- -> if the sender deletes his/her account. message sender_id will be null
--    which indicates sender's account is deleted (done by db constraints)
-- -> if users leave a group, their messages will remain in the group
-- -> this table does not check if sender_id is in the chat or not (must be checked in server)
--    the reason for that, is because sender_id might have left the group,
--    but his/her messages must remain the group
create table group_messages (
    id bigserial primary key,
    group_id bigint references groups(id) on delete cascade,
    sender_id bigint references users(id) on delete set null,
    content varchar(300),
    created_at timestamp default now()
);

-- this tables defines channels
-- -> if channels owner deletes account. channels will remain but without an owner
--    so admins will manage the channel and if no admins are there, channels still
--    remains and people can read older posts, but channel will not have new posts
--    because there is no owner or admin to send posts
-- -> any user can join channels using channel_address (channels are public in this app)
create table channels (
    id bigserial primary key,
    channel_address varchar(128) unique,
    image varchar,
    description varchar(128),
    name varchar(64) not null,
    owner_id bigint references users(id) references users(id) on delete set null,
    created_at timestamp default now()
);

-- this tables defines relationship between member users and channels
-- -> if a channels is deleted, all records related to the channels are also deleted
-- -> if a user's account is deleted, his/her membership to all his channels are deleted
create table channel_members (
    channel_id bigint references channels(id) on delete cascade,
    user_id bigint references users(id) on delete cascade,
    primary key (channel_id, user_id)
);

-- this tables defines relationship between admin users and channels
-- -> this tabel is a subset of the channel_members table that specifies admins
-- -> if a channels is deleted, all records related to the channels are also deleted
--    (duo to the foreign key relationship with channel_members table)
-- -> if an admin account is deleted, his/her membership to all his channels are deleted,
--    although his/her posts will remain in the channels
-- -> if you remove a member with admin privilege from channel_members that member will
--    be removed from this table too (duo to the foreign key relationship with channel_members table)
-- -> an admin of a channel is always a member of that channel (duo to the foreign key relationship
--    with channel_members table)
create table channel_admins (
    channel_id bigint references channels(id),
    user_id bigint references users(id),
    primary key (channel_id, user_id),
    foreign key (channel_id, user_id) references channel_admins(channel_id, user_id) on delete cascade
);

-- this table defines channel posts
-- -> if the channel is deleted, its messages will also be deleted (done by db constraints)
-- -> if the author deletes his/her account. message author_id will be null
--    which indicates author's account is deleted (done by db constraints)
-- -> if admins leave channel, their posts will remain in the channel
-- -> this table does not check if author_id is an admin or not (must be checked in server)
--    the reason for that, is because author_id might have left the channel or is not admin
--    anymore, but his/her posts must remain the channel
-- -> server only needs to check if author is admin or not for sending a post, no need for
-- -> checking membership
create table channel_posts (
    id bigserial primary key,
    channel_id bigint references channels(id) on delete cascade,
    author_id bigint references users(id) on delete set null,
    content varchar(300),
    created_at timestamp default now()
);