const express = require('express')
const mongoose = require('mongoose')
const app = express()
const cors = require('cors')
const ReserR = require('./controllers/reservations')

const {url} = require('./utils/config') 

mongoose.connect(url).then(()=>{
    console.log("Connected")
})


app.use(cors())
app.use(express.json())
app.use('/api/',ReserR)

module.exports = app