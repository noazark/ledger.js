Accounting = require 'accounting'

class Expense
  constructor: (amount, @payee, @date = new Date) ->
    @amount = Accounting.unformat(amount)

  toString: ->
    "#{@date.getMonth()}/#{@date.getDate()} - #{Accounting.formatMoney @amount} at #{@payee}"

module.exports = Expense