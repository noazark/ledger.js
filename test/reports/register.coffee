Ledger = require '../../src/ledger'
Expense = require '../../src/expense'
Transaction = require '../../src/transaction'

Register = require '../../src/reports/register'

expect = require('chai').expect

describe "Register", ->
  describe ".calculate", ->
    beforeEach ->
      @opening = new Expense "Opening Balance"
      @money_in = new Transaction "$100.00", "Assets:Bank:Checking"
      @money_out = new Transaction "$-100.00", "Liabilities:Opening Balance"
      @opening.transactions.push @money_in
      @opening.transactions.push @money_out

      @ledger = new Ledger
      @ledger.expenses.push @opening

    it "creates a running balance from each transaction", ->
      console.log Register.calculate @ledger
      expect(Register.calculate @ledger).to.eql [
        {
          expense: @opening,
          transaction: @money_in,
          balance: 100
        },
        {
          expense: @opening,
          transaction: @money_out,
          balance: 0
        }
      ]