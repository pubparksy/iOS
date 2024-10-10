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


// habit_add
app.post("/users/:user_id/habit_add", (req, res)=>{
    const user_id = req.params.user_id;
    const { habit_name, start_dt, end_dt } = req.body;
    // const { id, name } = req.session.user;
    const createdAt = moment().format("YYYY-MM-DD");

    let insert_habit_sql = `
                insert into habits (habit_name, start_dt, end_dt, createdAt, user_id) 
                values ('${habit_name}', '${start_dt}', '${end_dt}', '${createdAt}','${user_id}')
                `;
    db.run(insert_habit_sql, (err)=>{
        if (err) {
            res.status(500).send(`Internal Server Error(/habit_add) : ${err}`);
        }

        res.redirect(`/users/${user_id}/habit_list`);

    })
})




//  delete/:habit_id
app.delete("/users/:user_id/habit/:habit_id", (req, res)=>{
    const habit_id = req.params.habit_id;
    const user_id = req.params.user_id;

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
                }
                res.redirect(`/users/${user_id}/habit_list`); // 처리 끝내고 화면전환 (render는 기존 list db.all하고 다시 담아야해서 안 쓰고 하면 오류남?)
            })
        }
    })
});






//  record/:id
app.get("/users/:user_id/habit/:id/record", (req,res)=>{

    const habit_id = req.params.id;
    const user_id = req.params.user_id;

    let record_sql = `SELECT 
                id, memo, createdAt
                from records r
                where habit_id = ?
                `;
    db.all(record_sql, [habit_id], (err, rows)=> {
        if (err) {
            res.status(500).send(`Internal Server Error(/record/:id) : ${err}`);
        }
        res.json({ records: rows});
    })
})




// record_add
app.post("/users/:user_id/habit/:id/record_add", (req, res)=>{
    const habit_id = req.params.id;
    const user_id = req.params.user_id;
    const { memo } = req.body; 
    const createdAt = moment().format("YYYY-MM-DD");

    let sql = `
                insert into records (memo, createdAt, habit_id) 
                values (?, ?, ?)
                `;
    /** 
     * sql에 바로 '${memo}', '${createdAt}','${habit_id}'를 적지 않고  전부 ? 로 적고  
     * db.run(sql, [memo, createdAt, habit_id], (err) ~ 로 적는 것도 가능하다. 
     * db.run, db.get, db.all 전부 상관없는 듯하다. 
     */
    db.run(sql,[memo, createdAt, habit_id], (err)=>{
        if (err) {
            res.status(500).send(`Internal Server Error(/record_add) : ${err}`);
        } else {
            res.redirect(`/users/${user_id}/habit/${habit_id}/record`); // 처리 끝내고 화면전환 (render는 기존 list db.all하고 다시 담아야해서 안 쓰고 하면 오류남?)
        }
    })
})




// delete/:habit_id/:record_id
app.delete("/users/:user_id/habit/:hid/record/:rid", (req, res)=>{
    const habit_id = req.params.hid;
    const record_id = req.params.rid;
    const user_id = req.params.user_id;

    let sql = `
                DELETE FROM records
                WHERE id= ?
                `;
    db.run(sql, [record_id],  (err)=>{
        if (err) {
            res.status(500).send(`Internal Server Error(/delete/:habit_id/:record_id) : ${err}`);
        }
        res.redirect(`/users/${user_id}/habit/${habit_id}/record`); // 처리 끝내고 화면전환 (render는 기존 list db.all하고 다시 담아야해서 안 쓰고 하면 오류남?)
    })
});




// app Run
app.listen(PORT, () => {
    console.log(`포트번호 ${PORT}으로 API 서버 시작`);
})