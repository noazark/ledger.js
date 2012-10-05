Accounting = require 'accounting'
Transaction = require './transaction'

class Ledger
  constructor: () ->
    @transactions = []

  all: ->
    @transactions

  deleteAll: ->
    @transactions = []

  total: ->
    total = 0
    total += transaction.total() for transaction in @all()
    return total
  
  toJSON: ->
    transaction.toJSON() for transaction in @all()

  toString: ->
    (transaction.toString() for transaction in @all()).join("\n")

module.exports = Ledger