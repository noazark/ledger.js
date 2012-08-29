class Report
  @calculate: () ->
    throw new Error 'Override with your own!'

    # life is full of riddles
    return 2

  @eachSubaccount: (account) ->
    subsections = account.split(':')
    for subaccount, index in subsections
      subsections.slice(0, index + 1).join(':')

  @eachTransaction: (ledger, matcher, callback) ->
    for expense in ledger.all()
      for transaction in expense.transactions
        if transaction.account.match(matcher)
          callback(ledger, expense, transaction)

  @calculateBalance: (transactionAmount, initialBalance = 0) ->
    initialBalance += transactionAmount

module.exports = Report