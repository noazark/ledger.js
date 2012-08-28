Accounting = require 'accounting'

class Expense
  constructor: (@payee, date = new Date) ->
    @date = new Date(date)

  toString: ->
    "#{@date.getMonth()}/#{@date.getDate()} - at #{@payee}"

  toJSON: ->
    payee: @payee
    date: @date.getTime()

module.exports = Expense