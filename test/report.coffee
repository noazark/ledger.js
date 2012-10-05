Journal = require '../src/journal'
Transaction = require '../src/transaction'
Posting = require '../src/posting'

Report = require '../src/report'

expect = require('chai').expect

describe "Report", ->
  describe ".eachPosting", ->
    beforeEach ->
      @opening = new Transaction "Opening Balance"
      @money_in = new Posting "$100.00", "Assets:Bank:Checking"
      @money_out = new Posting "$-100.00", "Liabilities:Opening Balance"
      @opening.postings.push @money_in
      @opening.postings.push @money_out

      @revo = new Transaction "Revocup"
      @coffee_in = new Posting "$2.17", "Transactions:Beverages:Coffee"
      @coffee_out = new Posting "$-2.17", "Assets:Bank:Checking"
      @revo.postings.push @coffee_in
      @revo.postings.push @coffee_out

      @journal = new Journal
      @journal.transactions.push @opening, @revo

    it "iterates through postings", ->
      output = []

      for line in Report.eachPosting @journal, ''
        output.push line.posting

      postings = [@money_in, @money_out, @coffee_in, @coffee_out]

      expect(output).to.eql(postings)

    it "filters postings by account", ->
      output = []

      for line in Report.eachPosting @journal, /checking/i
        output.push line.posting

      postings = [@money_in, @coffee_out]

      expect(output).to.eql(postings)


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