Expense = require '../src/expense'
Transaction = require '../src/transaction'

expect = require('chai').expect
sinon = require 'sinon'

describe "Expense", ->
  beforeEach ->
    @now = new Date(2012, 7, 17)
    sinon.useFakeTimers(@now.getTime())

    @expense = new Expense "Revocup"

  it "optionally accepts a custom Date", ->
    next_day =  new Date(2012, 7, 18)
    @expense = new Expense "Target", next_day
    
    expect(@expense.date).to.eql next_day

  it "deligates date parameter to Date object", ->
    @expense = new Expense "Revocup", 17
    
    expect(@expense.date).to.eql new Date(17)

  it "timestamps itself when created", ->
    expect(@expense.date).to.eql @now

  describe "#addTransaction", ->
    it "attaches a transaction to the expense", ->
      @expense.addTransaction new Transaction "$0"

      expect(@expense.transactions).to.have.length(1)

  describe "#createTransaction", ->
    it "returns a new transaction", ->
      expect(@expense.createTransaction "$0").to.be.an.instanceof(Transaction)

    it "adds the new transaction to transactions", ->
      transaction = @expense.createTransaction "$0"

      expect(@expense.transactions.pop()).to.equal(transaction)

  describe "#total", ->
    it "sums the amount of each transaction", ->
      @expense.transactions = [{amount: 4}, {amount: 5.64}]

      expect(
        @expense.total()
      ).to.equal(9.64)

  describe "#toString", ->
    it "formats the expense into a readable string", ->
      @expense.transactions = [{amount: 4}, {amount: 3.20}]

      expect(
        @expense.toString()
      ).to.equal(
        "7/17 - $7.20 at Revocup"
      )

  describe "#toJSON", ->
    it "formats the expense into JSON", ->
      @expense.transactions = [
        {
          toJSON: ->
            amount: 3.40
            account: "Expenses:Auto:Repair"
        },
        {
          toJSON: ->
            amount: 5.63,
            account: "Expenses:Beverage:Coffee"
        }
      ]

      expect(
        @expense.toJSON()
      ).to.eql(
        payee: "Revocup",
        date: @now.getTime(),
        transactions: [
          {
            amount: 3.40,
            account: "Expenses:Auto:Repair"
          },
          {
            amount: 5.63,
            account: "Expenses:Beverage:Coffee"
          }
        ]
      )