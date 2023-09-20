const mongoose = require('mongoose')

mongoose.set('strictQuery',false)


const reservationSchema = new mongoose.Schema({
    state: String,
    city: String,
    area: String,
    spots: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'Parkingspots'
        }
    ]
  })

reservationSchema.set('toJSON', {
  transform: (document, returnedObject) => {
    returnedObject.id = returnedObject._id.toString()
    delete returnedObject._id
    delete returnedObject.__v
  }
})
module.exports = mongoose.model('Reservations', reservationSchema)

