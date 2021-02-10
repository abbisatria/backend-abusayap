const transactionModel = require('../models/transaction')
const userModel = require('../models/users')
const response = require('../helpers/response')
const bcrypt = require('bcrypt')

exports.createTransaction = async (req, res) => {
  try {
    const data = req.body
    const pinUser = await userModel.getUsersByCondition({ id: req.userData.id })
    const compare = bcrypt.compareSync(data.pin, pinUser[0].pin)
    if (compare) {
      if (pinUser[0].balance >= data.amount) {
        const sender = await transactionModel.getAmountByUser({ idUser: req.userData.id })
        const receiver = await transactionModel.getAmountByUser({ idUser: data.idReceiver })

        if (sender[0] === undefined) {
          await transactionModel.createAmountTransaction({ idUser: req.userData.id, expense: data.amount })
        } else {
          const expense = sender[0].expense + Number(data.amount)
          console.log(expense)
          await transactionModel.updateAmountTransaction(req.userData.id, { expense: expense })
        }

        if (receiver[0] === undefined) {
          await transactionModel.createAmountTransaction({ idUser: data.idReceiver, income: data.amount })
        } else {
          const income = receiver[0].income + Number(data.amount)
          await transactionModel.updateAmountTransaction(data.idReceiver, { income: income })
        }

        const balance = pinUser[0].balance - data.amount
        await userModel.updateUser(req.userData.id, { balance })
        const results = await transactionModel.createTransaction({
          idSender: req.userData.id,
          idReceiver: data.idReceiver,
          amount: data.amount,
          notes: data.notes,
          status: data.status,
          dateTransaction: data.dateTransaction
        })
        const finalResults = await transactionModel.getUserTransactionById(results.insertId)
        const userReceiver = await userModel.getUsersByCondition({ id: finalResults[0].idReceiver })
        return response(res, 200, true, 'Transaction successfully created', {
          id: finalResults[0].id,
          idSender: finalResults[0].idSender,
          amount: finalResults[0].amount,
          balance: finalResults[0].balance,
          dateTransaction: finalResults[0].dateTransaction,
          notes: finalResults[0].notes,
          receiver: [
            {
              firstname: userReceiver[0].firstname,
              lastname: userReceiver[0].lastname,
              picture: userReceiver[0].picture,
              phoneNumber: userReceiver[0].phoneNumber
            }
          ]
        })
      } else {
        return response(res, 400, false, 'Balance is not enough')
      }
    } else {
      return response(res, 400, false, 'Do not transfer to yourself')
    }
  } catch (error) {
    console.log(error)
    return response(res, 400, false, 'Bad Request')
  }
}

exports.detailTransaction = async (req, res) => {
  try {
    const { id } = req.params
    const results = await transactionModel.getUserTransactionById(id)
    if (results.length === 1) {
      const userReceiver = await userModel.getUsersByCondition({ id: results[0].idReceiver })
      return response(res, 200, true, "Detail's Transaction", {
        id: results[0].id,
        idSender: results[0].idSender,
        amount: results[0].amount,
        balance: results[0].balance,
        dateTransaction: results[0].dateTransaction,
        notes: results[0].notes,
        receiver: [
          {
            firstname: userReceiver[0].firstname,
            lastname: userReceiver[0].lastname,
            picture: userReceiver[0].picture,
            phoneNumber: userReceiver[0].phoneNumber
          }
        ]
      })
    }
    return response(res, 404, false, 'Cant Found Detail Transaction')
  } catch (error) {
    return response(res, 400, false, 'Bad Request')
  }
}

exports.amountTransactionByUser = async (req, res) => {
  try {
    const { id } = req.params
    const results = await transactionModel.getAmountTransactionByIdUser(id)
    if (results.length === 1) {
      return response(res, 200, true, 'Amount Transaction User', results)
    }
    return response(res, 404, false, 'Cant Found Detail Transaction')
  } catch (error) {
    return response(res, 400, false, 'Bad Request')
  }
}