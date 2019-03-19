// multi-method scoring fuzzymatching via matchit
// utilizing ngram, token, soundex, ngram_circ, bigram methods
matchit id matchid using "data.dta", idu(id) txtu(matchid) t(.75) ti di sim(ngram, 3)
ren similscore namescore_ngram3

matchit id matchid using "data.dta", idu(id) txtu(matchid) t(.75) ti di sim(ngram, 1)
ren similscore namescore_ngram1

matchit id matchid using "data.dta", idu(id) txtu(matchid) t(.75) ti di sim(token)
ren similscore namescore_token

matchit id matchid using "data.dta", idu(id) txtu(matchid) t(.75) ti di sim(soundex)
ren similscore namescore_soundex

matchit id matchid using "data.dta", idu(id) txtu(matchid) t(.75) ti di sim(ngram_circ, 2)
ren similscore namescore_ngramcirc1

matchit id matchid using "data.dta", idu(id) txtu(matchid) t(.75) ti di sim(ngram_circ, 3)
ren similscore namescore_ngramcirc3

matchit id matchid using "data.dta", idu(id) txtu(matchid) t(.75) ti di sim(bigram)
ren similscore namescore_bigram

