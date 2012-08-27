Accounting = require 'accounting'

class Expense
  constructor: (amount, @payee) ->
    @amount = Accounting.unformat(amount)
    @date = new Date

  toString: ->
    "#{@date.getMonth()}/#{@date.getDate()} - #{Accounting.formatMoney @amount} at #{@payee}"

module.exports = Expense