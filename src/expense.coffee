Accounting = require 'accounting'
Transaction = require './transaction'

class Expense
  constructor: (@payee, date = new Date) ->
    @transactions = []
    @date = new Date(date)

  addTransaction: (transaction)->
    throw new TypeError unless transaction instanceof Transaction
    @transactions.push transaction

  total: ->
    total = 0
    total += transaction.amount for transaction in @transactions
    return total

  toString: ->
    "#{@date.getMonth()}/#{@date.getDate()} - #{Accounting.formatMoney @total()} at #{@payee}"

  toJSON: ->
    payee: @payee
    date: @date.getTime()
    transactions: transaction.toJSON() for transaction in @transactions

module.exports = Expense