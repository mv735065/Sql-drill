let db=require('./db');


// [Q1] Write a node script to add 10 organizations. 
// Each org should have 100 users and a 1000 channels. 
//  Each channel should have a 10000 messages.

let createTenOrganisations=function(){
    console.time('Insert 100000 messages');
      let query='insert into  organization (name) values ?';
     let organizations=[];

      for(let i=1;i<=10;i++){
        organizations.push([`Organisation-${i}`]);
      }


        db.query(query,[organizations],(err,res)=>{
            if(err){
                console.log("err on creating orgs",err);
                return;
                
            }
            else{
                console.log(" created orgs");
                // result(null,"Added orgsn in table");
                createChannelsForEachOrganization();
            }
        })
}

let createChannelsForEachOrganization=function(){
   
         let query='insert into channel (name,organization_id) values ?';
         let store=[];
         for(let i=1;i<=10;i++){
            for(let j=1;j<=1000;j++){
             store.push([`Channel-${j}`,i]);
            }
         }
         db.query(query,[store],(err,res)=>{
            if(err){
                console.log('UNable to create channels',err);
               return err;
            }
           console.log("Ctreated channels for each org");
          
        //    consoleTheChannels();
           
        addUsers();
         })
}

let addUsers=function(){
    let query='insert into user(name) values ?';
    let store=[];

    for(let i=1;i<=100;i++){
        store.push([`User-${i}`]);
    }

    db.query(query,[store],(err,res)=>{
        if(err){
            console.log('UNable to create users',err);
           return err;
        }
       console.log("Ctreated users 100");
       console.timeEnd('Insert 100000 messages');
    })
        

}
let addUsersInChannels=function(){
    let query='insert into Channel_Users(user_id,channel_id) values ?';
     let store=[];


}




createTenOrganisations();




