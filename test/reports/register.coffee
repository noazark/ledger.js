Ledger = require '../../src/ledger'
Expense = require '../../src/expense'
Posting = require '../../src/posting'

Register = require '../../src/reports/register'

expect = require('chai').expect

describe "Register", ->
  describe ".calculate", ->
    beforeEach ->
      @opening = new Expense "Opening Balance"
      @money_in = new Posting "$100.00", "Assets:Bank:Checking"
      @money_out = new Posting "$-100.00", "Liabilities:Opening Balance"
      @opening.postings.push @money_in
      @opening.postings.push @money_out

      @ledger = new Ledger
      @ledger.expenses.push @opening

    it "creates a running balance from each posting", ->
      console.log Register.calculate @ledger
      expect(Register.calculate @ledger).to.eql [
        {
          expense: @opening,
          posting: @money_in,
          balance: 100
        },
        {
          expense: @opening,
          posting: @money_out,
          balance: 0
        }
      ]