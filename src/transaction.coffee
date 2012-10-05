Accounting = require 'accounting'
Posting = require './posting'

class Transaction
  constructor: (@payee, date = new Date) ->
    @postings = []
    @date = new Date(date)

  total: ->
    total = 0
    total += posting.amount for posting in @postings
    return total

  toString: ->
    "#{@date.getMonth()}/#{@date.getDate()} - #{Accounting.formatMoney @total()} at #{@payee}"

  toJSON: ->
    payee: @payee
    date: @date.getTime()
    postings: posting.toJSON() for posting in @postings

module.exports = Transaction