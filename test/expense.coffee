Expense = require '../src/expense'

expect = require('chai').expect
sinon = require 'sinon'

describe "Expense", ->
  beforeEach ->
    @now = new Date(2012, 7, 17)
    sinon.useFakeTimers(@now.getTime())

    @expense = new Expense "$4", "Revocup"

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