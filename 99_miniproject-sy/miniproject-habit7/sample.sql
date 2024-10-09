-- users
insert into users (email, name, password) values ('s@com', '송송','s1');
insert into users (email, name, password) values ('l@com', '이이','l1');
insert into users (email, name, password) values ('k@com', '김김','k1');

-- habits
insert into habits (habit_name, start_dt, end_dt, createdAt, user_id) values ('오전 독서', '2024-09-01', '2024-09-03', '2024-09-01','1');
insert into habits (habit_name, start_dt, end_dt, createdAt, user_id) values ('점심 운동', '2024-09-02', '2024-09-05', '2024-09-02','1');
insert into habits (habit_name, start_dt, end_dt, createdAt, user_id) values ('오후 커피', '2024-09-10', '2024-09-15', '2024-09-10','1');
insert into habits (habit_name, start_dt, end_dt, createdAt, user_id) values ('저녁 산책', '2024-09-16', '2024-09-20', '2024-09-16','1');

insert into habits (habit_name, start_dt, end_dt, createdAt, user_id) values ('오전 수영', '2024-09-01', '2024-09-01', '2024-09-01','2');
insert into habits (habit_name, start_dt, end_dt, createdAt, user_id) values ('오후 개발', '2024-09-01', '2024-09-30', '2024-09-01','2');
insert into habits (habit_name, start_dt, end_dt, createdAt, user_id) values ('밤 명상',   '2024-09-10', '2024-09-30', '2024-09-10','2');

insert into habits (habit_name, start_dt, end_dt, createdAt, user_id) values ('오전 수면', '2024-09-01', '2024-12-02', '2024-09-01','3');
insert into habits (habit_name, start_dt, end_dt, createdAt, user_id) values ('오후 낮잠', '2024-09-12', '2024-12-12', '2024-09-12','3');



-- records
insert into records (memo, createdAt, habit_id) values ('첫번째 독서 : 성경', '2024-09-01',1);
insert into records (memo, createdAt, habit_id) values ('두번째 독서 : 반야심경', '2024-09-02',1);
insert into records (memo, createdAt, habit_id) values ('세번째 독서 : 알라', '2024-09-03',1);
insert into records (memo, createdAt, habit_id) values ('네번째 독서 : 개발책', '2024-09-03',1);

insert into records (memo, createdAt, habit_id) values ('첫번째 운동 : 피티', '2024-09-02',2);
insert into records (memo, createdAt, habit_id) values ('두번째 운동 : 필라테스', '2024-09-03',2);

insert into records (memo, createdAt, habit_id) values ('첫번째 커피 : 과테말라', '2024-09-10',3);
insert into records (memo, createdAt, habit_id) values ('두번째 커피 : 에티오피아', '2024-09-11',3);
insert into records (memo, createdAt, habit_id) values ('세번째 커피 : 브라질산토스', '2024-09-13',3);

insert into records (memo, createdAt, habit_id) values ('첫번째 저녁산책 : 한강', '2024-09-10',4);
insert into records (memo, createdAt, habit_id) values ('두번째 저녁산책 : 둘레길', '2024-09-11',4);
insert into records (memo, createdAt, habit_id) values ('세번째 저녁산책 : 동네공원', '2024-09-13',4);

insert into records (memo, createdAt, habit_id) values ('첫번째 수영 오전1 : 배영', '2024-09-01',5);
insert into records (memo, createdAt, habit_id) values ('두번째 수영 오전2 : 접영', '2024-09-01',5);

insert into records (memo, createdAt, habit_id) values ('첫번째 개발 : Linux', '2024-09-05',6);
insert into records (memo, createdAt, habit_id) values ('두번째 개발 : Windows', '2024-09-15',6);
insert into records (memo, createdAt, habit_id) values ('세번째 개발 : Mac', '2024-09-21',6);


insert into records (memo, createdAt, habit_id) values ('첫번째 밤 명상 - 수면1', '2024-09-06',7);
insert into records (memo, createdAt, habit_id) values ('두번째 밤 명상 - 수면2', '2024-09-13',7);
insert into records (memo, createdAt, habit_id) values ('세번째 밤 명상 - 수면3', '2024-12-01',7);
