Ledger = require '../src/ledger'
Expense = require '../src/expense'

expect = require('chai').expect

describe "Ledger", ->
  beforeEach ->
    @ledger = new Ledger

  describe "#all", ->
    it "returns all expenses", ->
      array = ['a', 'b']
      @ledger.expenses = ['a', 'b']

      expect(
        @ledger.all()
      ).to.eql(array)

  describe "#deleteAll", ->
    it "deletes all expenses", ->
      @ledger.expenses.push new Expense "Revocup"
      @ledger.deleteAll()

      expect(
        @ledger.expenses
      ).to.be.empty

  describe "#total", ->
    it "sums the amount of each expense", ->
      expense_one = new Expense "Revocup"
      expense_one.total = ->
        4.56

      expense_two = new Expense "Revocup"
      expense_two.total = ->
        9.99

      @ledger.expenses.push expense_one
      @ledger.expenses.push expense_two

      expect(
        @ledger.total()
      ).to.equal(14.55)

    it "returns zero dolars when there are no expesnse", ->
      expect(
        @ledger.total()
      ).to.equal(0)

  describe "#toJSON", ->
    it "formats the expense into JSON", ->
      expense = new Expense "Revocup"
      @ledger.expenses.push expense
      @ledger.expenses.push expense

      expect(
        JSON.stringify @ledger.toJSON()
      ).to.eql(
        JSON.stringify [expense, expense]
      )

  describe "#toString", ->
    it "creates a list of all expenses", ->
      expense = new Expense "Revocup"

      # add two expenses to make sure it lists out correctly
      @ledger.expenses.push expense
      @ledger.expenses.push expense

      expect(
        @ledger.toString()
      ).to.equal(
        "#{expense.toString()}" + "\n" +
        "#{expense.toString()}"
      )

    it "creates an empty string when there are no expenses", ->
      expect(
        @ledger.toString()
      ).to.be.empty