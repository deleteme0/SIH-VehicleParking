
const Reservation = require('../models/reservation')
const Parkingspot = require('../models/parkingspot')
const User = require('../models/user')
const parkingspot = require('../models/parkingspot')
const reserveRouter = require('express').Router()


reserveRouter.get('/spots/',async(request,response) => {

    try{
    const ret = await Reservation.find({}).populate('spots',{ _id:1,spotnumber:1, available:1})
    response.status(200).json(ret).send()
    }
    catch{}
})

reserveRouter.get('/user/',async(request,response)=>{
    const ret = await User.find({})

    return response.status(200).json(ret).send()
})

/*

ADD USER

user = "somename"

*/
reserveRouter.post('/user/', async(request,response)=>{
    try{
    const exist = await User.find({username: request.body.user})

    if (exist.length > 0){
        console.log(exist)
        return response.status(208).json({error:"Already exists"}).send()
    }

    const newusr = new User({
        username: request.body.user,
        spotsbooked: []
    })

    const usr = await newusr.save()
    return response.status(201).json({id: usr._id}).send()
    }

catch{
}
}
)

/*

LOGIN USER

user = "name"

*/

reserveRouter.post('/user/login/', async(request,response)=>{
    try{

    const exist = await User.find({username: request.body.user})

    if (exist.length > 0){
        return response.status(200).json({id: exist[0]._id}).send()
    }

    return response.status(400).json({error:"user not found"}).send()
}
catch{}
})


/*

ADD RESERVATION

userid = "650b14cba20ff00e8692ed7a"
spotid = "650b0cdef10a4d10e57640b4"

*/
reserveRouter.post('/reserve/',async(request,response)=>{
    try{
    if (request.body.userid == null || request.body.spotid == null){
        return response.status(401).json({error:"invalid"}).send()
    }
    const spots = await parkingspot.findById(request.body.spotid)

    if (spots.length == 0 || spots.available == false){
        return response.status(401).json({error:'invalid spot'}).send()
    }

    var curruser = await User.findById(request.body.userid)
    if (curruser){
        curruser.spotsbooked.push(spots._id)
        curruser.save()
    }else{
        return response.status(401).json({error:"user not found"}).send()
    }

    spots.available = false
    spots.bookeduser = curruser._id

    const res = await spots.save()
    return response.status(200).json(res).send()
}
catch{}

})

/*

ADD PARKING SPOTS

state = "TN"
city = "chennai"
area = "Anna Nagar"
spot = "deluxe 001"

*/
reserveRouter.post('/spots/',async(request,response)=>{
    try{

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

    return response.status(200).json(res).send()
}
catch{}
})

/*
REMOVE RESERVATION

userid = "650b14cba20ff00e8692ed7a"
spotid = "650b0cdef10a4d10e57640b4"

*/
reserveRouter.delete('/reserve/', async(request,response) =>{
    try{

    if (request.body.userid == null || request.body.spotid == null){
        return response.status(400).json({error:"invalid request"}).send()
    }

    var curr_user = await User.findById(request.body.userid)

    
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



    return response.status(200).json(changed).send()
}
catch{}
})

module.exports = reserveRouter