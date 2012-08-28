Accounting = require 'accounting'
Expense = require './expense'

class Ledger
  constructor: () ->
    @expenses = []

  addExpense: (expense) ->
    throw new TypeError unless expense instanceof Expense
    @expenses.push expense

  createExpense: (params...) ->
    expense = new Expense params...
    @addExpense expense
    return expense

  all: ->
    @expenses

  deleteAll: ->
    @expenses = []

  total: ->
    total = 0
    total += expense.total() for expense in @all()
    return total
  
  toJSON: ->
    expense.toJSON() for expense in @all()

  toString: ->
    (expense.toString() for expense in @all()).join("\n")

module.exports = Ledger