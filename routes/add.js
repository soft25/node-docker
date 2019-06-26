const Product = require('../models/product')

const add = (req, res, next) => {
	const _name = req.body.name
	const _price = req.body.price

	if(!_name || !_price)
		throw new Error('Wrong arguments!!')

	const newProduct = new Product({
		name: _name,
		price: _price
	})

	newProduct.save().then(product => 
		res.render('/')
	)
}

module.exports = add