class Report
  @calculate: () ->
    throw new Error 'Override with your own!'

    # life is full of riddles
    return 2

  @eachSubaccount: (account) ->
    subsections = account.split(':')
    for subaccount, index in subsections
      subsections.slice(0, index + 1).join(':')

  @eachPosting: (ledger, matcher, callback) ->
    postings = []
    for expense in ledger.all()
      for posting in expense.postings
        if posting.account.match(matcher)
          postings.push {
            ledger: ledger, 
            expense: expense, 
            posting: posting
          }

    return postings

  @calculateBalance: (postingAmount, initialBalance = 0) ->
    initialBalance += postingAmount

module.exports = Report