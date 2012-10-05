Accounting = require 'accounting'
Report = require '../report'

class Register extends Report
  constructor: (@ledger, @matcher) ->

  @calculate: (ledger, matcher) ->
    register = 0
    postings = []

    for line in @eachPosting ledger, matcher
      register = @calculateBalance line.posting.amount, register

      postings.push {
        transaction: line.transaction
        posting: line.posting
        balance: register
      }

    return postings

  toString: ->
    output = for line in Register.calculate(@ledger, @matcher)
      "#{line.transaction.payee} - #{line.posting.account} - #{Accounting.formatMoney line.posting.amount} #{Accounting.formatMoney line.balance}"

    output.join("\n")

module.exports = Register