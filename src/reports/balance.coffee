Accounting = require 'accounting'
Report = require '../report'

class Balance extends Report
  constructor: (@ledger, @matcher) ->

  @calculate: (ledger, matcher) ->
    balances = {}

    for line in @eachTransaction ledger, matcher
      for subaccount in @eachSubaccount line.transaction.account
        balances[subaccount] = @calculateBalance line.transaction.amount, balances[subaccount]

    return balances

  toString: ->
    output = for account, amount of Balance.calculate(@ledger, @matcher)
      "#{Accounting.formatMoney amount}  #{account}"

    return output.join("\n")

module.exports = Balance