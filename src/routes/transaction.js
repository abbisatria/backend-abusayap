const routes = require('express').Router()
const transactionController = require('../controllers/transaction')
const authMiddleware = require('../middleware/auth')

routes.post('/', authMiddleware.authCheck, transactionController.createTransaction)
routes.get('/:id', authMiddleware.authCheck, transactionController.detailTransaction)
routes.get('/amountTransaction/:id', authMiddleware.authCheck, transactionController.amountTransactionByUser)

module.exports = routes
