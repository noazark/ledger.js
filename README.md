Ledger.js
=========

[![Build Status]](http://travis-ci.org/noazark/ledger.js)

Ledger.js is inspired by it's namesake [ledger] and seeks to replicate the
functionality in Javascript for use in Node.js and browser projects.

## Getting Started

```coffee-script
{Journal, Transaction, Posting} = require 'ledger.js'

revocup = new Transaction("Revocup")
revocup.postings.push new Posting "$4", "Expenses:Beverages:Coffee"
newEgg.postings.push new Posting "$-4", "Assets:Checking"

newEgg = new Transaction("Revocup")
newEgg.postings.push new Posting "$17", "Expenses:Computers"
newEgg.postings.push new Posting "$-17", "Assets:Checking"

ledger = new Journal
ledger.expenses.push revocup
ledger.expenses.push newEgg

# using double-entry accounting, we should see $0
ledger.total()
  #=> 0.00

eliteComics = new Transaction("Elite Comics", new Date(2012, 7, 3))
eliteComics.postings.push new Posting "$10.57", "Expenses:Comics"
eliteComics.postings.push new Posting "$-10.57", "Assets:Checking"

ledger.expenses.push eliteComics

ledger.toString()
  #=> 7/28 - $4 at Revocup
      7/28 - $17 at New Egg
      7/3 - $10.57 at Elite Comics
```

## Devlopment

The goal is to replicate all, or as much as possible, the features found in
[ledger]. Ledger is super well though out, and has a lot of stuff goin on, so
this process will take time. As of this writing (v0.1.4) the feature set is
very limited.

I am writing this library for use in a digital personal assistant. The bot keeps
track of my daily expenses, and then I do my books every night. Please open up
an issue for any features you'd like to see, as long as it has bearing in
[ledger] I'm sure I'll put it in.


[Build Status]: https://secure.travis-ci.org/noazark/ledger.js.png?branch=master
[ledger]: https://github.com/jwiegley/ledger