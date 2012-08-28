Transaction = require '../src/transaction'

expect = require('chai').expect

describe "Transaction", ->
  beforeEach ->
    @transaction = new Transaction("$4.53", "Expenses:Auto:Gas")

  it "converts accounting formatted amounts to Number", ->
    expect(@transaction.amount).to.equal 4.53

  describe "#toString", ->
    it "formats the transaction into a readable string", ->
      expect(
        @transaction.toString()
      ).to.equal(
        "$4.53 from Expenses:Auto:Gas"
      )