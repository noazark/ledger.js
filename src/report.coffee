class Report
  @calculate: () ->
    throw new Error 'Override with your own!'

    # life is full of riddles
    return 2

  @eachSubaccount: (account) ->
    subsections = account.split(':')
    for subaccount, index in subsections
      subsections.slice(0, index + 1).join(':')

  @eachPosting: (journal, matcher, callback) ->
    postings = []
    for transaction in journal.all()
      for posting in transaction.postings
        if posting.account.match(matcher)
          postings.push {
            journal: journal, 
            transaction: transaction, 
            posting: posting
          }

    return postings

  @calculateBalance: (postingAmount, initialBalance = 0) ->
    initialBalance += postingAmount

module.exports = Report