const Product = require('../models/product')

const getAll = (req, res, next) => {
	Product.find({}).lean().then(products => {
		if(!products)
			throw new Error('No product found')
		res.render('index', {products})
	}).catch(err => {
		next(err)
	})
}

module.exports = getAll