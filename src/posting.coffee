Accounting = require 'accounting'

class Posting
  constructor: (amount, @account)->
    @amount = Accounting.unformat(amount)

  toString: ->
    "#{Accounting.formatMoney @amount} from #{@account}"

  toJSON: ->
    amount: @amount
    account: @account

module.exports = Posting