const express = require('express'); 
const fs = require('fs'); // file읽는거
const moment = require('moment'); // 시간
const sqlite3 = require('sqlite3'); // DB
const path = require('path'); // 자체경로?
const cookieParser = require('cookie-parser'); // 쿠키 세팅 위한거
const expressSession = require('express-session'); // 세션 냄기기


// DB setting
const db_name = path.join(__dirname, "habit.db");
const db = new sqlite3.Database(db_name);
// create query
const create_sql_users = `
    create table if not exists users (
        id integer primary key autoincrement,
        name varchar(50) not null,
        email varchar(50) not null unique,
        password varchar(20) not null,
        createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
`;
const create_sql_habits = `
    create table if not exists habits (
        id integer primary key autoincrement, 
        habit_name varchar(255) not null,
        start_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        end_dt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        user_id varchar(20),
        foreign key(user_id) references user(id)
    )
`;
const create_sql_habit_records = `
    create table if not exists records (
        id integer primary key autoincrement, 
        memo text not null,
        createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        habit_id integer,
        foreign key(habit_id) references habit(id)
    )
`;
// create tables
db.serialize(()=>{
    db.run(create_sql_users);
    db.run(create_sql_habits);
    db.run(create_sql_habit_records);
});
// 나중에 .sql로 빼기..


// Network setting
const app = express();
const PORT = 3002;
app.use(cookieParser());
app.use(express.urlencoded({extended:true}));
app.set("view engine","ejs");
app.use(express.static('public'));

// Network session setting
app.use(
    expressSession({
        secret: "sample",
        resave: true,
        saveUninitialized: true,
    })
)
// view setting
app.set('view engine','ejs');
app.set('views','./views');





app.get("/login", (req, res)=>{
    res.render("login");
})


app.post("/login", (req, res)=> {
    const { email, password } = req.body;

    let sql = `
                select 
                    id, name, email, password
                from users u 
                where email = '${email}'
                and password = '${password}'
              `;


    db.get(sql, (err, row) => {
        if (err) {
            res.status(500).send("Internal Server Error - login");
        } else {
            const result = row; // select 조회 결과는 1개. 불일치하면 비회원인거임.
            console.log(result);
            if(result && (email == result.email && password == result.password)) {
                /** 나중에 여기서 세션 담아야함. 
                 * 그래야 localhost:3002/habit_list 그냥 호출해도 session이 없으면
                 * app.get("/habit_list")에서 요청은 받았지만 session 체크 후 res.redirect(login)함.
                  */
                res.redirect('/habit_list'); // localhost:3002/habit_list(.ejs get으로 화면전환);
            } else {
                console.log('잘못 입력하거나 회원이 아닙니다.');
                res.redirect('/login');
            }
        }
    })
})

app.get("/habit_list", (req, res)=>{
    res.render("habit_list");
})







app.get("/register", (req, res)=>{
    res.render("register");
})


app.post("/register", (req, res)=>{
    const { name, email, password } = req.body;

    const createdAt = moment().format("YYYY-MM-DD");

    let sql = `insert into users (name, email, password, createdAt)
               values (
                '${name}', '${email}','${password}','${createdAt}'
               )
               `;
    db.run(sql, (err)=>{
        if (err) {
            res.status(500).send("Interval Server Error - register insert");
        } else {
            res.redirect("/login");
        }
    })
})

// app Run
app.listen(PORT, () => {
    console.log(`포트번호 ${PORT}으로 습관관리 서버를 시작합니다.`);
})