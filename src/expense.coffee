Accounting = require 'accounting'

class Expense
  constructor: (amount, @payee, date = new Date) ->
    @amount = Accounting.unformat(amount)
    @date = new Date(date)

  toString: ->
    "#{@date.getMonth()}/#{@date.getDate()} - #{Accounting.formatMoney @amount} at #{@payee}"

  toJSON: ->
    JSON.stringify
      amount: @amount
      payee: @payee
      date: @date.getTime()

module.exports = Expense