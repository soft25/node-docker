require('dotenv').config()

const express   = require('express'),
	bodyParser  = require('body-parser'),
	mongoose    = require('mongoose'),
	product     = require('./router/product'),
	app = express()

app.set('view engine', 'ejs')

const uri = process.env.DB_TYPE +'://'+ process.env.DB_HOST+'/'+ process.env.DB_TABLE
mongoose.Promise = global.Promise
mongoose.connect(uri, (err, infos) => {
	if (!!err)
		console.log(err)
})

app.use(bodyParser.urlencoded({ extended: false }))

app.use('/', product)

const port = 3000

app.listen(port, () => console.log('Server running...'))