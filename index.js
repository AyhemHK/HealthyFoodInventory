const express = require('express');
const mysql = require('mysql');
const ejs = require('ejs');

const app = new express();


const db = mysql.createConnection({
    host:"localhost",
    user:"root",
    password: "root123",
    database: "mydb",
});

db.connect((err) => {
    if(err) {
        throw err;
    } else {
        console.log('Successfully Connected To The DB...')
    }
});


app.use(express.json());
app.use(express.urlencoded({exnteded: true}));

app.set("view engine", "ejs");
app.use("/public", express.static(__dirname + "/public"));

//routes
app.get('/', (req,res) => {
    res.render('index');
});


app.post('/insertdepartments/',(req,res) =>{
    let data = {Dept_ID: req.body.departmentID, Dept_Name: req.body.departmentName};
    let sql = 'INSERT INTO dept SET ?';
    let query = db.query(sql, data, (err, result) =>{
        if(err){
            throw err;
        } 
        res.send('<h1>Department Entry Was Inserted Into The Database!</h1>');
    });
   
});

app.post("/updatedepartment", (req, res) => {
    let sql = `UPDATE dept SET Dept_Name = '${req.body.DepartmentNewName}'  WHERE Dept_ID = ${req.body.departmentID}`;
    db.query(sql, (err, result) => {
      if (err) {
        throw err;
      }
      res.send(`<h1>Department Name Was Updated In The Database</h1>`);
    });
  });
  
  app.post("/deletedepartment", (req, res) => {
    let sql = `DELETE FROM dept WHERE Dept_Name = '${req.body.departmentName}'`;
    db.query(sql, (err, result) => {
      if (err) {
        throw err;
      }
      res.send(`<h1>Department Was Successfully Deleted From The Database</h1>`);
    });
  });
  

 app.get('/readdepartment',(req,res)=>{
    let sql = 'SELECT * FROM dept';
    db.query (sql,(err,result) =>{
        if (err){
            throw err;
        }
        res.render("readData", {data: result});
    });
});






const PORT = process.env.PORT || 3000;
app.listen(PORT,() => console.log('The server is running on PORT', PORT));