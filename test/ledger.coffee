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
      @ledger.add new Expense "$4", "Revocup"

      expect(
        @ledger.expenses
      ).to.have.length 1

    it "throws error with incorrect expense type", ->
      expect(->
        @ledger.add 'hello'
      ).to.throw(TypeError)

  describe "#deleteAll", ->
    it "deletes all expenses", ->
      @ledger.add new Expense "$4", "Revocup"
      @ledger.deleteAll()

      expect(
        @ledger.expenses
      ).to.be.empty

  describe "#total", ->
    it "sums the amount of each expense", ->
      @ledger.add new Expense "$4", "Revocup"
      @ledger.add new Expense "$13", "Revocup"

      expect(
        @ledger.total()
      ).to.equal("$17.00")

    it "returns zero dolars when there are no expesnse", ->
      expect(
        @ledger.total()
      ).to.equal("$0.00")

  describe "#toString", ->
    it "creates a list of all expenses", ->
      expense = new Expense "$13", "Revocup"

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