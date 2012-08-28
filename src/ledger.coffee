Accounting = require 'accounting'
Expense = require './expense'

class Ledger
  constructor: () ->
    @expenses = []

  add: (expense) ->
    throw new TypeError unless expense instanceof Expense
    @expenses.push expense

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