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

  describe "#add", ->
    it "adds an expense", ->
      @ledger.add new Expense "Revocup"

      expect(
        @ledger.expenses
      ).to.have.length 1

    it "throws error with incorrect expense type", ->
      expect(->
        @ledger.add 'hello'
      ).to.throw(TypeError)

  describe "#deleteAll", ->
    it "deletes all expenses", ->
      @ledger.add new Expense "Revocup"
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

      @ledger.add expense_one
      @ledger.add expense_two

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
      @ledger.add expense
      @ledger.add expense

      expect(
        JSON.stringify @ledger.toJSON()
      ).to.eql(
        JSON.stringify [expense, expense]
      )

  describe "#toString", ->
    it "creates a list of all expenses", ->
      expense = new Expense "Revocup"

      # add two expenses to make sure it lists out correctly
      @ledger.add expense
      @ledger.add expense

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