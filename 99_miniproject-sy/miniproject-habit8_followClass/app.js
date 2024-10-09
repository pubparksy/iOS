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
        id          integer     primary key autoincrement,
        name        varchar(50) not null,
        email       varchar(50) not null unique,
        password    varchar(20) not null,
        createdAt   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
`;
const create_sql_habits = `
    create table if not exists habits (
        id          integer primary key autoincrement, 
        habit_name  varchar(255) not null,
        start_dt    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        end_dt      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        createdAt   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        user_id     varchar(20),
        foreign key(user_id) references user(id)
    )
`;
const create_sql_habit_records = `
    create table if not exists records (
        id          integer primary key autoincrement, 
        memo        text not null,
        createdAt   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        habit_id    integer,
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
app.set('views','./views');
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



// localhost:3000/login
app.get("/login", (req, res)=>{
    res.render("login");
    // res.redirect("/login");
})


app.post("/login", (req, res)=> {
    const { email, password } = req.body;

    let sql = `select id, name, email, password, createdAt 
               from users
               where email = '${email}'
               and password = '${password}'
               `;
    db.get(sql, (err, row)=> {
        if (err) {
            res.status(500).send(`Internal Server Error(/login) : ${err}`);
        } else {
            const result = row; // select 조회 결과는 1개. 불일치하면 비회원인거임.
            // console.log(result);
            if(result != undefined) {

                req.session.user = {
                    id: result.id,
                    name: result.name,
                    authorized: true
                }
                res.redirect('/habit_list?login_success=true'); // localhost:3002/habit_list(.ejs get으로 화면전환);
            } else {
                res.redirect('/login');
            }
        }
    })

})


// localhost:3000/login > localhost:3000/habit_list 
app.get("/habit_list", (req, res)=>{
    if(req.session.user == undefined) {
        res.redirect("/login");
        return;
    }
    const { id, name } = req.session.user;

    let sql = `select
                h.id, h.habit_name , h.start_dt , h.end_dt , count(r.habit_id) count
                from habits h
                left outer join records r 
                on h.id  = r.habit_id 
                group by h.habit_name , h.start_dt , h.end_dt , r.habit_id
                having h.user_id = '${id}'
                order by h.id 
                `;
    db.all(sql, [], (err, rows)=> {
        if (err) {
            res.status(500).send(`Internal Server Error(/habit_list) : ${err}`);
        } else {
            const habits = rows;
            // console.log(habits);
            res.render("habit_list", {name: name, habits: habits});
        }
    })
})










app.get("/habit_add", (req,res)=> {
    if(req.session.user == undefined) {
        res.redirect("/login");
        return;
    }

    res.render("habit_add");
})


app.post("/habit_add", (req, res)=>{
    if(req.session.user == undefined) {
        res.redirect("/login");
        return;
    }

    const { habit_name, start_dt, end_dt } = req.body;
    const { id, name } = req.session.user;
    const createdAt = moment().format("YYYY-MM-DD");

    let insert_habit_sql = `
                insert into habits (habit_name, start_dt, end_dt, createdAt, user_id) 
                values ('${habit_name}', '${start_dt}', '${end_dt}', '${createdAt}','${id}')
                `;
    db.run(insert_habit_sql, (err)=>{
        if (err) {
            res.status(500).send(`Internal Server Error(/habit_add) : ${err}`);
        } else {
            res.redirect("/habit_list"); // 처리 끝내고 화면전환 (render는 기존 list db.all하고 다시 담아야해서 안 쓰고 하면 오류남?)
        }
    })
})




// localhost:3000/login > localhost:3000/habit_list  > localhost:3000/record/1 
app.get("/record/:id", (req,res)=>{
    if (req.session.user) {
        const habit_id = req.params.id;
        const { name, id } = req.session.user; // habit_id도 session 도중 추가 되나?

//      let sql = `SELECT 
//               id, memo, createdAt
//               from records r
//               where habit_id = ?    // 여기에 물음표를 주면
//               `;
//      db.all(sql, [habit_id], (err, rows)=> {  // ?에 대한 데이터 지정을 여기서 해줄 수 있고 보안도 강화된다.

        let sql = `SELECT 
                    id, memo, createdAt
                    from records r
                    where habit_id = ${habit_id}
                    `;
        db.all(sql, [], (err, rows)=> {
            if (err) {
                res.status(500).send(`Internal Server Error(/record/:id) : ${err}`);
            } else {
                const records = rows;
                // console.log(records);
                res.render("habit_record_list", {name: name, habit_id: habit_id, records: records});
            }
        })
    } else {
        // session이 없을 때
        res.redirect("/login");
    }
})



/** 
 * (1) button href에 params 붙여서 가져오기
 * (2) form get  > (1)과 동일
 * (3) form post > params 대신 body로 가져와서 소스 바꿔야함.
 *     어차피 동일명의 post함수가 있으니 그냥 (1),(2) 사용
 */
app.get("/record_add/:id", (req,res)=> {
    if(req.session.user == undefined) {
        res.redirect("/login");
        return;
    }
    const habit_id =  req.params.id;
    res.render("habit_record_add", {habit_id:habit_id});
    //  render("무조건 ejs >>파일명<<") // habit_id 넘기려면 render. redirect안됨.
})



app.post("/record_add", (req, res)=>{
    if(req.session.user == undefined) {
        res.redirect("/login");
        return;
    }
    const { habit_id, memo } = req.body;
    const { id, name } = req.session.user;
    const createdAt = moment().format("YYYY-MM-DD");

    let sql = `
                insert into records (memo, createdAt, habit_id) 
                values ('${memo}', '${createdAt}','${habit_id}')
                `;
    /** 
     * sql에 바로 '${memo}', '${createdAt}','${habit_id}'를 적지 않고  전부 ? 로 적고  
     * db.run(sql, [memo, createdAt, habit_id], (err) ~ 로 적는 것도 가능하다. 
     * db.run, db.get, db.all 전부 상관없는 듯하다. 
     */
    db.run(sql, (err)=>{
        if (err) {
            res.status(500).send(`Internal Server Error(/record_add) : ${err}`);
        } else {
            res.redirect(`/record/${habit_id}`); // 처리 끝내고 화면전환 (render는 기존 list db.all하고 다시 담아야해서 안 쓰고 하면 오류남?)
        }
    })
})




app.get("/delete/:habit_id/:record_id", (req, res)=>{
    if(req.session.user == undefined) {
        res.redirect("/login");
        return;
    }
    const habit_id = req.params.habit_id;
    const record_id = req.params.record_id;

    let sql = `
                DELETE FROM records
                WHERE id=${record_id}
                `;
    db.run(sql, (err)=>{
        if (err) {
            res.status(500).send(`Internal Server Error(/delete/:habit_id/:record_id) : ${err}`);
        } else {
            res.redirect(`/record/${habit_id}`); // 처리 끝내고 화면전환 (render는 기존 list db.all하고 다시 담아야해서 안 쓰고 하면 오류남?)
        }
    })
});




app.get("/delete/:habit_id", (req, res)=>{
    if(req.session.user == undefined) {
        res.redirect("/login");
        return;
    }
    const habit_id = req.params.habit_id;
    let sql = `
                DELETE FROM habits
                WHERE id=${habit_id}
                `;
    db.run(sql, (err)=>{
        if (err) {
            res.status(500).send("Interval Server Error - delete habit");
        } else {
            let sql2 = `
                        DELETE FROM records
                        WHERE habit_id=${habit_id}
                        `;
            db.run(sql2, (err)=>{
                if (err) {
                    res.status(500).send(`Internal Server Error(/delete/:habit_id) : ${err}`);
                } else {
                    res.redirect("/habit_list"); // 처리 끝내고 화면전환 (render는 기존 list db.all하고 다시 담아야해서 안 쓰고 하면 오류남?)
                }
            })
        }
    })
});




app.get("/logout", (req,res)=>{
    if (req.session.user) {
        req.session.user = null;
    }
    res.redirect("/login");
})

app.get("/register", (req, res)=>{
    res.render("register");
})


app.post("/register", (req, res)=>{
    const { name, email, password } = req.body;
    const createdAt = moment().format("YYYY-MM-DD");

    let dupl_chk_sql = `select count(1) as count from users
                        where email = '${email}'`;
    db.get(dupl_chk_sql, (err, row)=>{
        if (err) {
            res.status(500).send(`Internal Server Error(/register) : ${err}`);
        } else {
            if(row.count > 0) {
                res.redirect("/register?duplEmail=true");
            } else {
                let insert_sql = `insert into users (name, email, password, createdAt)
                            values (
                            '${name}', '${email}','${password}','${createdAt}'
                            )`;
                db.run(insert_sql);
                res.redirect("/login");
            }
        }
    })
})

// app.post("/register", (req, res)=>{
//     const { name, email, password } = req.body;
//     const createdAt = moment().format("YYYY-MM-DD");

//     let sql = `insert into users (name, email, password, createdAt)
//                values (
//                 '${name}', '${email}','${password}','${createdAt}'
//                )
//                `;
//     db.run(sql, (err)=>{
//         if (err) {
//             res.status(500).send("Interval Server Error - register insert");
//         } else {
//             res.redirect("/login");
//             // res.render("login");
//         }
//     })
// })

// app Run
app.listen(PORT, () => {
    console.log(`포트번호 ${PORT}으로 습관관리 서버를 시작합니다.`);
})