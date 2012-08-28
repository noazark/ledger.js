Expense = require '../src/expense'

expect = require('chai').expect
sinon = require 'sinon'

describe "Expense", ->
  beforeEach ->
    @now = new Date(2012, 7, 17)
    sinon.useFakeTimers(@now.getTime())

    @expense = new Expense "$4", "Revocup"

  it "optionally accepts a custom Date", ->
    next_day =  new Date(2012, 7, 18)
    @expense = new Expense "$13", "Target", next_day
    
    expect(@expense.date).to.eql next_day

  it "deligates date parameter to Date object", ->
    @expense = new Expense "$13", "Target", 17
    
    expect(@expense.date).to.eql new Date(17)

  it "converts accounting formatted amounts to Number", ->
    expect(@expense.amount).to.equal 4

  it "timestamps itself when created", ->
    expect(@expense.date).to.eql @now

  describe "#toString", ->
    it "formats the expense into a readable string", ->
      expect(
        @expense.toString()
      ).to.equal(
        "7/17 - $4.00 at Revocup"
      )

  describe "#toJSON", ->
    it "formats the expense into JSON", ->
      expect(
        @expense.toJSON()
      ).to.equal(
        JSON.stringify
          amount: 4,
          payee: "Revocup",
          date: @now.getTime()
      )