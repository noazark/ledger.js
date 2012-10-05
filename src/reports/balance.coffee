Accounting = require 'accounting'
Report = require '../report'

class Balance extends Report
  constructor: (@journal, @matcher) ->

  @calculate: (journal, matcher) ->
    balances = {}

    for line in @eachPosting journal, matcher
      for subaccount in @eachSubaccount line.posting.account
        balances[subaccount] = @calculateBalance line.posting.amount, balances[subaccount]

    return balances

  toString: ->
    output = for account, amount of Balance.calculate(@journal, @matcher)
      "#{Accounting.formatMoney amount}  #{account}"

    return output.join("\n")

module.exports = Balance