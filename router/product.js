const express   = require('express'),
	router = express.Router(),
	getAll = require('../routes/get'),
	add = require('../routes/add')

router.get('/', getAll)
router.post('/product/add', add)

module.exports = router