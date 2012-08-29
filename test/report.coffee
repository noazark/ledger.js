Ledger = require '../src/ledger'
Expense = require '../src/expense'
Transaction = require '../src/transaction'

Report = require '../src/report'

expect = require('chai').expect

describe "Report", ->
  describe ".eachTransaction", ->
    beforeEach ->
      @opening = new Expense "Opening Balance"
      @money_in = new Transaction "$100.00", "Assets:Bank:Checking"
      @money_out = new Transaction "$-100.00", "Liabilities:Opening Balance"
      @opening.transactions.push @money_in
      @opening.transactions.push @money_out

      @revo = new Expense "Revocup"
      @coffee_in = new Transaction "$2.17", "Expenses:Beverages:Coffee"
      @coffee_out = new Transaction "$-2.17", "Assets:Bank:Checking"
      @revo.transactions.push @coffee_in
      @revo.transactions.push @coffee_out

      @ledger = new Ledger
      @ledger.expenses.push @opening, @revo

    it "iterates through transactions", ->
      output = []

      for line in Report.eachTransaction @ledger, ''
        output.push line.transaction

      transactions = [@money_in, @money_out, @coffee_in, @coffee_out]

      expect(output).to.eql(transactions)

    it "filters transactions by account", ->
      output = []

      for line in Report.eachTransaction @ledger, /checking/i
        output.push line.transaction

      transactions = [@money_in, @coffee_out]

      expect(output).to.eql(transactions)


  describe ".eachSubaccount", ->
    it "iterates through subaccounts", ->
      expect(Report.eachSubaccount('a:b:c')).to.eql(['a', 'a:b', 'a:b:c'])

  describe ".calculate", ->
    it "nicely suggest you do your own calculations", ->
      expect(Report.calculate).to.throw(Error)

  describe ".calculateBalance", ->
    it "calculates the total of two balances", ->
      expect(Report.calculateBalance -4, 10).to.equal(6)

    it "sets initial balance to zero by default", ->
      expect(Report.calculateBalance 15).to.equal(15)