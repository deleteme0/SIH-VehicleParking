const mongoose = require('mongoose')

mongoose.set('strictQuery',false)


const parkingspotSchema = new mongoose.Schema({
    spotnumber: String,
    available: Boolean,
    bookeduser: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
    }
  })

parkingspotSchema.set('toJSON', {
  transform: (document, returnedObject) => {
    returnedObject.id = returnedObject._id.toString()
    delete returnedObject._id
    delete returnedObject.__v
  }
})
module.exports = mongoose.model('Parkingspots', parkingspotSchema)