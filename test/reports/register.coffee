Journal = require '../../src/journal'
Transaction = require '../../src/transaction'
Posting = require '../../src/posting'

Register = require '../../src/reports/register'

expect = require('chai').expect

describe "Register", ->
  describe ".calculate", ->
    beforeEach ->
      @opening = new Transaction "Opening Balance"
      @money_in = new Posting "$100.00", "Assets:Bank:Checking"
      @money_out = new Posting "$-100.00", "Liabilities:Opening Balance"
      @opening.postings.push @money_in
      @opening.postings.push @money_out

      @journal = new Journal
      @journal.transactions.push @opening

    it "creates a running balance from each posting", ->
      expect(Register.calculate @journal).to.eql [
        {
          transaction: @opening,
          posting: @money_in,
          balance: 100
        },
        {
          transaction: @opening,
          posting: @money_out,
          balance: 0
        }
      ]