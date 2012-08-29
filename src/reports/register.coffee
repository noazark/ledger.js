Accounting = require 'accounting'
Report = require '../report'

class Register extends Report
  constructor: (@ledger, @matcher) ->

  @calculate: (ledger, matcher) ->
    register = 0
    transactions = []

    for line in @eachTransaction ledger, matcher
      register = @calculateBalance line.transaction.amount, register

      transactions.push {
        expense: line.expense
        transaction: line.transaction
        balance: register
      }

    return transactions

  toString: ->
    output = for line in Register.calculate(@ledger, @matcher)
      "#{line.expense.payee} - #{line.transaction.account} - #{Accounting.formatMoney line.transaction.amount} #{Accounting.formatMoney line.balance}"

    output.join("\n")

module.exports = Register