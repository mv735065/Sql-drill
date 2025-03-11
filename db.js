let dbConfig=require('./dbs.config');
let mysql=require('mysql');


let connection=mysql.createConnection({
    host:dbConfig.HOST,
    user:dbConfig.USER,
    password:dbConfig.PASSWORD,
    database:dbConfig.DB,
});

connection.connect((err,res)=>{
    if(err){
        console.log("error in connection");
        return err;
    }
    else{
        console.log("Connected ");
        return ;
        
    }
})


module.exports=connection;
