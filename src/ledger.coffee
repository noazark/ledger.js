Accounting = require 'accounting'
Expense = require './expense'

class Ledger
  constructor: () ->
    @expenses = []

  add: (expense) ->
    @expenses.push expense.toJSON()

  all: ->
    Expense.create(expense) for expense in @expenses

  deleteAll: ->
    @expenses = []

  total: ->
    total = 0
    total += expense.amount for expense in @all()
    return Accounting.formatMoney total

  toString: ->
    (expense.toString() for expense in @all()).join("\n")

module.exports = Ledger