Something Like That – Fuzzy Match Multi-Word Phrases in Ruby
------------------------------------------------------------

Find partial matches for long, multi-word strings. Something Like That is asymmetrical, meaning “Azkaban” will match “Harry Potter and the Prisoner of Azkaban” much more strongly than the other way around.

Based on the modified Monge-Elkan method described in [Jimenez et al. (2009)][paper], using the [amatch][amatch] library’s implementation of the Jaro-Winkler similarity measure

### Installation

### Usage

### Examples

### License

The MIT License (MIT)

Copyright © 2017 Ryan Lue

[paper]: http://www.gelbukh.com/CV/Publications/2009/Generalized%20Mongue-Elkan%20Method%20for%20Approximate%20Text%20String.pdf
[amatch]: https://github.com/flori/amatch
