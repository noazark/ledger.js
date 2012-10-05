Transaction = require '../src/transaction'
Posting = require '../src/posting'

expect = require('chai').expect
sinon = require 'sinon'

describe "Transaction", ->
  beforeEach ->
    @now = new Date(2012, 7, 17)
    sinon.useFakeTimers(@now.getTime())

    @transaction = new Transaction "Revocup"

  it "optionally accepts a custom Date", ->
    next_day =  new Date(2012, 7, 18)
    @transaction = new Transaction "Target", next_day
    
    expect(@transaction.date).to.eql next_day

  it "deligates date parameter to Date object", ->
    @transaction = new Transaction "Revocup", 17
    
    expect(@transaction.date).to.eql new Date(17)

  it "timestamps itself when created", ->
    expect(@transaction.date).to.eql @now

  describe "#total", ->
    it "sums the amount of each posting", ->
      @transaction.postings = [{amount: 4}, {amount: 5.64}]

      expect(
        @transaction.total()
      ).to.equal(9.64)

  describe "#toString", ->
    it "formats the transaction into a readable string", ->
      @transaction.postings = [{amount: 4}, {amount: 3.20}]

      expect(
        @transaction.toString()
      ).to.equal(
        "7/17 - $7.20 at Revocup"
      )

  describe "#toJSON", ->
    it "formats the transaction into JSON", ->
      @transaction.postings = [
        {
          toJSON: ->
            amount: 3.40
            account: "Transactions:Auto:Repair"
        },
        {
          toJSON: ->
            amount: 5.63,
            account: "Transactions:Beverage:Coffee"
        }
      ]

      expect(
        @transaction.toJSON()
      ).to.eql(
        payee: "Revocup",
        date: @now.getTime(),
        postings: [
          {
            amount: 3.40,
            account: "Transactions:Auto:Repair"
          },
          {
            amount: 5.63,
            account: "Transactions:Beverage:Coffee"
          }
        ]
      )