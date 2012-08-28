Accounting = require 'accounting'

class Transaction
  constructor: (amount, @account)->
    @amount = Accounting.unformat(amount)

  toString: ->
    "#{Accounting.formatMoney @amount} from #{@account}"

module.exports = Transaction