Ledger = require '../src/ledger'
Expense = require '../src/expense'

expect = require('chai').expect

describe "Ledger", ->
  beforeEach ->
    @ledger = new Ledger

  describe "#all", ->
    it "returns all expenses", ->
      @ledger.expenses = ['a', 'b']

      expect(
        @ledger.all().length
      ).to.equal(2)

    it "creates an expense object out of each returned item", ->
      @ledger.expenses = [{amount: "$4", payee: "Revocup", date: 0}]

      expect(
        @ledger.all()[0]
      ).to.be.an.instanceof(Expense)

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