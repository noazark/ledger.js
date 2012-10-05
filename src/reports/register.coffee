Accounting = require 'accounting'
Report = require '../report'

class Register extends Report
  constructor: (@journal, @matcher) ->

  @calculate: (journal, matcher) ->
    register = 0
    postings = []

    for line in @eachPosting journal, matcher
      register = @calculateBalance line.posting.amount, register

      postings.push {
        transaction: line.transaction
        posting: line.posting
        balance: register
      }

    return postings

  toString: ->
    output = for line in Register.calculate(@journal, @matcher)
      "#{line.transaction.payee} - #{line.posting.account} - #{Accounting.formatMoney line.posting.amount} #{Accounting.formatMoney line.balance}"

    output.join("\n")

module.exports = Register