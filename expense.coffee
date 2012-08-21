Accounting = require 'accounting'

class Expense
  constructor: (amount, @payee) ->
    @amount = Accounting.unformat(amount)
    @date = new Date

  toString: ->
    "#{@date.getMonth()}/#{@date.getDate()} - #{Accounting.formatMoney @amount} at #{@payee}"

  toJSON: ->
    {
      amount: @amount
      payee: @payee
      date: @date
    }

  @create: (json) ->
    if json.amount? and json.payee? and json.date?
      expense = new Expense json.amount, json.payee
      expense.date = new Date(json.date)
      expense

module.exports = Expense