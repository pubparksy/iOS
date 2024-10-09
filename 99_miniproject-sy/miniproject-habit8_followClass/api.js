const express = require('express'); 
const fs = require('fs'); // file읽는거
const moment = require('moment'); // 시간
const sqlite3 = require('sqlite3'); // DB
const path = require('path'); // 자체경로?

// DB setting
const db_name = path.join(__dirname, "habit.db");
const db = new sqlite3.Database(db_name);

// Network setting
const app = express();
const PORT = 3001;


app.use(express.json()) // post body에 json으로 바로 읽을 수 있음?



app.get("/users", (req, res)=>{
    const users_sql = `select * from users`;

    db.all(users_sql, [], (err, rows)=>{
        res.json({users: rows});
    })

})


app.get("/users/:user_id/habit_list", (req, res)=>{
    const user_id = req.params.user_id;

    let sql = `select
                h.id, h.habit_name , h.start_dt , h.end_dt , count(r.habit_id) count
                from habits h
                left outer join records r 
                on h.id  = r.habit_id 
                group by h.habit_name , h.start_dt , h.end_dt , r.habit_id
                having h.user_id = '${user_id}'
                order by h.id 
                `;
    db.all(sql, [], (err, rows)=> {
        if (err) {
            res.status(500).send("Interval Server Error - habit_list");
        }
        if (rows) {
            res.json({habits: rows});
        }
    })

})







// app Run
app.listen(PORT, () => {
    console.log(`포트번호 ${PORT}으로 API 서버 시작`);
})