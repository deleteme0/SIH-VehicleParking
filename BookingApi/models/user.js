const mongoose = require('mongoose')

mongoose.set('strictQuery',false)


const userSchema = new mongoose.Schema({
    username: String,
    spotsbooked: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'Parkingspots'
        }
    ]
  })


userSchema.set('toJSON', {
    transform: (document, returnedObject) => {
      returnedObject.id = returnedObject._id.toString()
      delete returnedObject._id
      delete returnedObject.__v
  
      delete returnedObject.passwordhash
    }
  })
  
  module.exports = mongoose.model('User', userSchema)
  
  