Accounting = require 'accounting'
Expense = require './expense'

class Ledger
  constructor: () ->
    @expenses = []

  add: (expense) ->
    throw new TypeError unless expense instanceof Expense
    @expenses.push expense.toJSON()

  all: ->
    for expense in @expenses
      Expense.create expense

  deleteAll: ->
    @expenses = []

  total: ->
    total = 0
    total += expense.amount for expense in @all()
    return Accounting.formatMoney total

  toString: ->
    (expense.toString() for expense in @all()).join("\n")

module.exports = Ledger