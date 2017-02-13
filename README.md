Something Like That
===================

See how closely two long, multi-word phrases match each other.

Something Like That is asymmetrical, meaning “Azkaban” will match “Harry Potter and the Prisoner of Azkaban” much more strongly than vice versa. Great for ordering search results gathered from diverse sources.

Based on the modified Monge-Elkan method described in [Jimenez et al. (2009)][paper] (pdf), using the [amatch][amatch] library’s implementation of the Jaro-Winkler similarity measure.

Installation
------------

```bash
$ gem install something_like_that
```

Usage
-----

```ruby
>> require 'something_like_that'
=> true
>> query = SomethingLikeThat.new('Hannibal Lecter')
=> "Hannibal Lecter"
>> query.match('Hannibal Lecter Goes to Washington')
=> 1.0
>> query.match('Hannibal Buress')
=> 0.7071067811865476
>> query.match?('Hannibal Buress')
=> false
>> SomethingLikeThat::Scorer.threshold = 0.7
=> 0.7
>> query.match?('Hannibal Buress')
=> true
```

Config
------

This gem collects similarity scores for matching pairs of tokens (words) from two different phrases, then averages them together. 

* `SomethingLikeThat::Scorer.threshold` (default = 0.8)  
  During the first (tokenwise) round of scoring, match scores below this value are dropped to 0. Once the resulting scores are averaged, this value determines whether `#match?` returns `true` or `false`.
* `SomethingLikeThat::Scorer.mean_exponent` (default = 2)  
  The method outlined by Jimenez et al. (2009) uses a [generalized mean][gmean] to favor matches over non-matches. For a two-word phrase, one exact match (1.0) and one non-match (0.0) produce an arithmetic mean (_p = 1_) of 0.5 and a quadratic mean (_p = 2_) of ~0.7. (For an in-depth analysis, [see Section 3 of their paper][paper].)

License
-------

The MIT License (MIT)

Copyright © 2017 Ryan Lue

[paper]: http://www.gelbukh.com/CV/Publications/2009/Generalized%20Mongue-Elkan%20Method%20for%20Approximate%20Text%20String.pdf
[amatch]: https://github.com/flori/amatch
[gmean]: https://en.wikipedia.org/wiki/Generalized_mean
