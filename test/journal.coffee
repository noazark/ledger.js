Journal = require '../src/journal'
Transaction = require '../src/transaction'

expect = require('chai').expect

describe "Journal", ->
  beforeEach ->
    @journal = new Journal

  describe "#all", ->
    it "returns all transactions", ->
      array = ['a', 'b']
      @journal.transactions = ['a', 'b']

      expect(
        @journal.all()
      ).to.eql(array)

  describe "#deleteAll", ->
    it "deletes all transactions", ->
      @journal.transactions.push new Transaction "Revocup"
      @journal.deleteAll()

      expect(
        @journal.transactions
      ).to.be.empty

  describe "#total", ->
    it "sums the amount of each transaction", ->
      transaction_one = new Transaction "Revocup"
      transaction_one.total = ->
        4.56

      transaction_two = new Transaction "Revocup"
      transaction_two.total = ->
        9.99

      @journal.transactions.push transaction_one
      @journal.transactions.push transaction_two

      expect(
        @journal.total()
      ).to.equal(14.55)

    it "returns zero dolars when there are no expesnse", ->
      expect(
        @journal.total()
      ).to.equal(0)

  describe "#toJSON", ->
    it "formats the transaction into JSON", ->
      transaction = new Transaction "Revocup"
      @journal.transactions.push transaction
      @journal.transactions.push transaction

      expect(
        JSON.stringify @journal.toJSON()
      ).to.eql(
        JSON.stringify [transaction, transaction]
      )

  describe "#toString", ->
    it "creates a list of all transactions", ->
      transaction = new Transaction "Revocup"

      # add two transactions to make sure it lists out correctly
      @journal.transactions.push transaction
      @journal.transactions.push transaction

      expect(
        @journal.toString()
      ).to.equal(
        "#{transaction.toString()}" + "\n" +
        "#{transaction.toString()}"
      )

    it "creates an empty string when there are no transactions", ->
      expect(
        @journal.toString()
      ).to.be.empty