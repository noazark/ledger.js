Ledger = require '../../src/ledger'
Expense = require '../../src/expense'
Posting = require '../../src/posting'

Balance = require '../../src/reports/balance'

expect = require('chai').expect

describe "Balance", ->
  describe ".calculate", ->
    beforeEach ->
      @opening = new Expense "Opening Balance"
      @money_in = new Posting "$100.00", "Assets:Bank:Checking"
      @money_out = new Posting "$-100.00", "Liabilities:Opening Balance"
      @opening.postings.push @money_in
      @opening.postings.push @money_out

      @ledger = new Ledger
      @ledger.expenses.push @opening

    it "sumarizes the balance of each account", ->
      expect(Balance.calculate @ledger).to.eql
        "Assets": 100
        "Assets:Bank": 100
        "Assets:Bank:Checking": 100
        "Liabilities": -100
        "Liabilities:Opening Balance": -100