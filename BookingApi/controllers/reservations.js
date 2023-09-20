
const Reservation = require('../models/reservation')
const Parkingspot = require('../models/parkingspot')
const User = require('../models/user')
const parkingspot = require('../models/parkingspot')
const reserveRouter = require('express').Router()


reserveRouter.get('/spots/',async(request,response) => {

    const ret = await Reservation.find({}).populate('spots',{ _id:1,spotnumber:1, available:1})

    response.json(ret).send()
})
/*

ADD RESERVATION

user = "somename"
spotid = "650b0cdef10a4d10e57640b4"

*/
reserveRouter.post('/reserve/',async(request,response)=>{

    if (request.body.user == null || request.body.spotid == null){
        return response.status(401).json({error:"invalid"}).send()
    }
    const spots = await parkingspot.find({ _id: request.body.spotid })

    if (spots == null){
        return response.status(401).json({error:'invalid spot'}).send()
    }

    const alluser = await User.find({name: request.body.user})
    var curruser = null;
    if (alluser[0] != null){
        var tempuser = alluser[0]
        tempuser.spotsbooked.push(spots[0]._id)
    }else{
        const newusr = new User({
            username: request.body.user,
            spotsbooked: [spots[0]._id]
        })
        const ou = await newusr.save()
        curruser = ou._id
    }

    var currspot = spots[0];
    currspot.available = false
    currspot.bookeduser = curruser

    const res = currspot.save()
    return response.json(res).send()

})

/*

ADD PARKING SPOTS

state = "TN"
city = "chennai"
area = "Anna Nagar"
spot = "deluxe 001"

*/
reserveRouter.post('/spots/',async(request,response)=>{

    if (request.body.state == null || request.body.area == null || request.body.city == null || request.body.spot == null){
        return response.status(401).json({error:'invalid'}).send()
    }

    

    const newspot = new Parkingspot({
        spotnumber: request.body.spot,
        available: true
    })

    const savednewspot = await newspot.save()

    const exist = await Reservation.find({state: request.body.state})

    const nr = {
        state: request.body.state,
        city: request.body.city,
        area: request.body.area,
        spots: [savednewspot._id]
    }

    var isthere = null;

    exist.forEach(element => {
        if (element.city == nr.city && element.area == nr.area){
            isthere = element;
        }
    });

    var res = null;




    if (isthere){
        isthere.spots.push(savednewspot._id)
        res = await isthere.save()
    }else{
        const reservation = new Reservation(nr)
        res =await reservation.save()
    }

    return response.status(202).json(res).send()
})

/*
REMOVE RESERVATION

user = "username"
spotid = "650b0cdef10a4d10e57640b4"

*/
reserveRouter.delete('/reserve/', async(request,response) =>{

    if (request.body.user == null || request.body.spotid == null){
        return response.json({error:"invalid request"}).send()
    }

    var curr_user = await User.find({username: request.body.user})

    curr_user = curr_user[0]
    curr_user.spotsbooked = curr_user.spotsbooked.filter((element)=> {
        if (element == request.body.spotid){
            console.log("deleted")
            return false
        }
        return true
    }
    )

    const changed = await curr_user.save()

    const currspot = await parkingspot.findById(request.body.spotid)
    currspot.available = true
    currspot.bookeduser = null

    const trash = await currspot.save()



    return response.status(201).json(changed).send()
})

module.exports = reserveRouter