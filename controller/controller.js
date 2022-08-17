const express = require('express');
const router = express.Router();
const { executeQueryInsert, executeQuerySelect, executeQueryUpdate } = require('../shared/shared-db');
const Joi = require('joi');


router.post('/create-order', async function (req, res) {
   
    // const schema = Joi.object({
    //    });
    // const { error } =schema.validate(req.body);
    // if (error) return res.status(400).send({ status: false, data: error, message: "failed" })
    let orders=req.body.orders;
    if(orders.length>0){
        orders.forEach((order,index) => {
            executeQueryInsert('INSERT INTO orders (pizza_name,toppings) VALUES ? ',
            [[order.pizza_name,order.toppings.join(',')]],
            function (ordererr, orderresult) {
                if (ordererr) return res.status(500).send({ status: false, data: ordererr, message: "failed" });
                addtoDoughchef()
                addtotoppings(orderresult.insertId,order.toppings)
                
                return res.status(200).send({status:true,message:'order created'})
               
                
           });
        });
    }
})

function addtoDoughchef(){
    // select one order which is still not processed
    executeQuerySelect('SELECT * FROM `orders` where status = 0 order by order_id asc', function (err, orders) {
    if(orders.length>0){
        let order_id=orders[0].order_id;
         //checking which dough chef is free
    executeQuerySelect('SELECT dc_id FROM `dough_chef` where status = 0 ', function (err, chefs) {
        if(chefs.length>0){
            //moving into dough
            console.log('a',chefs) 
            executeQueryInsert('INSERT INTO dough_data (order_id,chef_id) VALUES ? ',
            [[order_id,chefs[0]['dc_id']]],
            function (ordererr, orderresult) {
              //after 7 seconds moving to topping
                
                if (ordererr) console.log(ordererr);
                let data = { status: 1 };
                executeQueryUpdate('UPDATE `dough_chef` SET ? where `dc_id`=? ',
                    [data, chefs[0]],
                    function (err, result) {
                        if (err) return res.status(500).send({ status: false, data: err, message: "failed" });
                    })
                    let orderstatus={status:1}
                    console.log('ORDER ID: '+order_id+' reached to dough chef at '+new Date().toTimeString().split(' ')[0])
                    executeQueryUpdate('UPDATE `orders` SET ? where `order_id`=? ',
                    [orderstatus, order_id],
                    function (err, result) {
                        //moving dough to topping, dough chef is free now
                        setTimeout(()=>{
                            console.log('ORDER ID: '+order_id+' moved to topping section at '+new Date().toTimeString().split(' ')[0])

                            handovertotoppings() ;
                            let data = { status: 0 };
                            executeQueryUpdate('UPDATE `dough_chef` SET ? where `dc_id`=? ',
                                [data, chefs[0]['dc_id']],
                                function (err, result) {
                                    if (err) return res.status(500).send({ status: false, data: err, message: "failed" });
                                })
                                addtoDoughchef()
                            },7000)
                        if (err) return res.status(500).send({ status: false, data: err, message: "failed" });
                    })
            })
        }
        })
    }
    })

   
  
}
 function addtotoppings(order_id,toppings){
    toppings.forEach(top=>{
        executeQueryInsert('INSERT INTO topping_data (order_id,topping) VALUES ? ',
        [[order_id,top]],
        function (ordererr, orderresult) {
        })
    })
   
 }
 function handovertoOven(){
    executeQuerySelect('SELECT * FROM `orders` where status = 2 order by order_id asc', function (err, orders) {
        if(orders.length>0){
            let order_id=orders[0].order_id;
            //status=2 means pizza in the oven
            executeQuerySelect('SELECT * FROM `oven_data` where status =2 ', function (err, waiting) {
                if(waiting.length==0){
                    //nothing in the oven
                    executeQueryInsert('INSERT INTO oven_data (order_id,status) VALUES ? ',
                    [[order_id,2]],
                    function (ordererr, orderresult) {
                        let oven_id=orderresult.insertId
                        setTimeout(()=>{
                            let data={status:3}
                            console.log('ORDER ID: '+order_id+' moved from oven at '+new Date().toTimeString().split(' ')[0])
                            //now order is moved from oven.
                            executeQueryUpdate('update orders set ? where order_id=?',
                            [data, order_id],
                            function (ordererr, orderresult) { 
                                handovertoWaiter();

                            })
                            let status={status:1}
                            //update into topping
                            executeQueryUpdate('update oven_data set ? where oven_id=?',
                            [status, oven_id],
                            function (ordererr, orderresult) { 
                                handovertoOven();
                            })
                        },10000)
                    })
                }
            })

         
        }
    })
       
   
}
function handovertoWaiter(){
      // select one order which is now tokk from oven
      executeQuerySelect('SELECT * FROM `orders` where status = 3 order by order_id asc', function (err, orders) {
        if(orders.length>0){
            let order_id=orders[0].order_id;
             //checking which waiter chef is free
        executeQuerySelect('SELECT w_id FROM `waiters` where status = 0 ', function (err, chefs) {
            if(chefs.length>0){

                executeQueryInsert('INSERT INTO serving_data (order_id,waiter_id) VALUES ? ',
                [[order_id,chefs[0].w_id]],
                function (ordererr, serveingresult) {
                    let data = { status: 1 };
                    executeQueryUpdate('UPDATE `waiters` SET ? where `w_id`=? ',
                        [data, chefs[0]],
                        function (err, result) {
                            if (err) return res.status(500).send({ status: false, data: err, message: "failed" });
                        })
  
                            //moving dough to topping, dough chef is free now
                            setTimeout(()=>{
                               let data = { status: 0 };
                                executeQueryUpdate('UPDATE `waiters` SET ? where `w_id`=? ',
                                    [data, chefs[0].w_id],
                                    function (err, result) {
                                        if (err) return res.status(500).send({ status: false, data: err, message: "failed" });
                                    })
                                    let orderstatus={status:4}
                                    console.log('ORDER ID: '+order_id+' served at '+new Date().toTimeString().split(' ')[0])
                                    console.log('ORDER ID: '+order_id+' Total Time taken - '+((new Date().getTime()-new Date(orders[0].created_at).getTime())))+'ms'
                                    executeQueryUpdate('UPDATE `orders` SET ? where `order_id`=? ',
                                    [orderstatus, order_id],
                                    function (err, result) {
                                    })
                                },5000)
                })
                 
                            
            }
            })
        }
        })
   
}
function handovertotoppings(){
    executeQuerySelect('SELECT * FROM `orders` where status = 1 order by order_id asc', function (err, orders) {
        if(orders.length>0){
            let order_id=orders[0].order_id;
            //checking which topinchef is free
            executeQuerySelect('SELECT tc_id FROM `topping_chef` where status = 0 ', function (err, chefs) {
                if(chefs.length>0){
                    executeQuerySelect('SELECT * FROM `topping_data` where order_id=? and chef_id is null and status=0 limit 2 ',[order_id], function (err, toppings) {
                        if(toppings.length>0){
                            toppings.forEach((top,index)=>{
                                //status to to identify it is just assigned not completed all toppings
                                chefstatus={chef_id:chefs[0]['tc_id'],status:2}
                                //update into topping
                                executeQueryUpdate('update topping_data set ? where order_id=?',
                                [chefstatus, order_id],
                                function (ordererr, orderresult) {                           
                                    let data = { status: 1 };
                                    executeQueryUpdate('UPDATE `topping_chef` SET ? where `tc_id`=? ',
                                        [data, chefs[0]],
                                        function (err, result) {
                                            if (err) return res.status(500).send({ status: false, data: err, message: "failed" });
                                        })
                                        //after 4 sec moving to topping again 
                                    setTimeout(()=>{
                                        let data = { status: 0 };
                                    executeQueryUpdate('UPDATE `topping_chef` SET ? where `tc_id`=? ',
                                        [data, chefs[0]],
                                        function (err, result) {
                                            if (err) return res.status(500).send({ status: false, data: err, message: "failed" });
                                        })
                                        handovertotoppings() ;
                                    },4000)
                                    
                                })
                                })
                        }
                        else{
                            chefstatus1={chef_id:chefs[0]['tc_id'],status:1}
                            //update into topping
                            executeQueryUpdate('update topping_data set ? where order_id=?',
                            [chefstatus1, order_id],function (err,res){ })
                            let orderstatus={status:2}
                            console.log('ORDER ID: '+order_id+' toppings completed at '+new Date().toTimeString().split(' ')[0])
                            executeQueryUpdate('UPDATE `orders` SET ? where `order_id`=? ',
                            [orderstatus, order_id],
                            function (err, result) {
                                if (err) return res.status(500).send({ status: false, data: err, message: "failed" });
                                handovertoOven()

                            })
                        }
                        
                    
                    })
                    
                }
            })
        }
    })
     
}
module.exports = router;