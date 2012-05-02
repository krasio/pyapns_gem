PYAPNS gem
=====

pyapns is an universal Apple Push Notification Service (APNS) provider.

This gem simply extracts the code under [https://github.com/samuraisam/pyapns/tree/master/ruby-client/pyapns](https://github.com/samuraisam/pyapns/tree/master/ruby-client/pyapns) in order to make instaling it as a gem from GitHub possible ([related issue here](https://github.com/samuraisam/pyapns/pull/23#issuecomment-5367855)).


Installation
============

Add it to your Gemfile

```gem 'PYAPNS', :git => 'git://github.com/krasio/pyapns_gem'```

From your project's root run

```bundle install```

If you wanna use pypans on Engine Yard cloud take a look at [ey-pyapns](https://github.com/krasio/ey-pyapns) chef recipe.

TODO
============

Add some tests.
