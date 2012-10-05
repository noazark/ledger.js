Ledger = require '../src/ledger'
Transaction = require '../src/transaction'

expect = require('chai').expect

describe "Ledger", ->
  beforeEach ->
    @ledger = new Ledger

  describe "#all", ->
    it "returns all transactions", ->
      array = ['a', 'b']
      @ledger.transactions = ['a', 'b']

      expect(
        @ledger.all()
      ).to.eql(array)

  describe "#deleteAll", ->
    it "deletes all transactions", ->
      @ledger.transactions.push new Transaction "Revocup"
      @ledger.deleteAll()

      expect(
        @ledger.transactions
      ).to.be.empty

  describe "#total", ->
    it "sums the amount of each transaction", ->
      transaction_one = new Transaction "Revocup"
      transaction_one.total = ->
        4.56

      transaction_two = new Transaction "Revocup"
      transaction_two.total = ->
        9.99

      @ledger.transactions.push transaction_one
      @ledger.transactions.push transaction_two

      expect(
        @ledger.total()
      ).to.equal(14.55)

    it "returns zero dolars when there are no expesnse", ->
      expect(
        @ledger.total()
      ).to.equal(0)

  describe "#toJSON", ->
    it "formats the transaction into JSON", ->
      transaction = new Transaction "Revocup"
      @ledger.transactions.push transaction
      @ledger.transactions.push transaction

      expect(
        JSON.stringify @ledger.toJSON()
      ).to.eql(
        JSON.stringify [transaction, transaction]
      )

  describe "#toString", ->
    it "creates a list of all transactions", ->
      transaction = new Transaction "Revocup"

      # add two transactions to make sure it lists out correctly
      @ledger.transactions.push transaction
      @ledger.transactions.push transaction

      expect(
        @ledger.toString()
      ).to.equal(
        "#{transaction.toString()}" + "\n" +
        "#{transaction.toString()}"
      )

    it "creates an empty string when there are no transactions", ->
      expect(
        @ledger.toString()
      ).to.be.empty