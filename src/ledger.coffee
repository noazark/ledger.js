Accounting = require 'accounting'
Expense = require './expense'

class Ledger
  constructor: (@robot) ->
    @expenses = []

    @robot.brain.on 'loaded', =>
      @robot.brain.data.ledger ?= []
      @expenses = @robot.brain.data.ledger

  add: (expense) ->
    @expenses.push expense.toJSON()
    @robot.brain.data.ledger = @expenses

  all: ->
    Expense.create(expense) for expense in @expenses

  deleteAll: ->
    @expenses = []
    @robot.brain.data.ledger = []

  total: ->
    total = 0
    total += expense.amount for expense in @all()
    return Accounting.formatMoney total

  toString: ->
    (expense.toString() for expense in @all()).join("\n")

module.exports = Ledger