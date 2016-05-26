---
title       : COURSERA DATA SCIENCE SPECIALIZATION
subtitle    : CAPSTONE Project - The App Pitch
author      : Louis-Ferdinand Goffin, aka Papaluigi
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
logo        : press.jpg
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [mathjax]
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
--- bg:yellow







## Executive Summary
The strategy to build our **App** has been the following :
* Use a `4.6 millions` words Training sample from the initial blog dataset provided
* Perform some cleaning operations on the Training sample
* Determine 1-grams, 2-grams, 3-grams in the Training dataset and their respective frequencies
* Using Markov's assumption, quantify N-grams models respective performances over a `1.2 millions` words Testing sample, disjoint from the Training dataset 
* Propose a prediction model based on the above outcomes, relying on Katz's back-off approach and Good Turing Discounting 
* Build a Shiny App running the algorithm above, with a high focus on **User Interface** and **Performances**

---

## Quantitative Results
N-grams counts in the training set
<!-- html table generated in R 3.2.2 by xtable 1.7-4 package -->
<!-- Wed May 25 10:16:25 2016 -->
<table border=1>
<tr> <th>  </th> <th> Unigrams </th> <th> Bigrams </th> <th> Trigrams </th>  </tr>
  <tr> <td align="right"> Counts </td> <td> 109515 </td> <td> 1642788 </td> <td> 3940255 </td> </tr>
   </table>
<BR>
Then,  for each N-gram, we compute Testing dataset Coverage,in order to get a first estimation of our prediction capacity 
$$ Coverage = \frac{N_\text{Words seen in the Training set}}{T_\text{Total number of words in the Testing set}} $$
<!-- html table generated in R 3.2.2 by xtable 1.7-4 package -->
<!-- Wed May 25 17:23:53 2016 -->
<table border=1>
<tr> <th>  </th> <th> Unigrams </th> <th> Bigrams </th> <th> Trigrams </th>  </tr>
  <tr> <td align="right"> Coverage </td> <td> 98.8% </td> <td> 79.8% </td> <td> 40.9% </td> </tr>
   </table>
<BR>

> Given the relatively poor coverage of Tri-grams, we decide to include all 3 N-grams in our prediction algorithm.

---

## The Model
So, we decide to use a Katz's Back-off approach, where the probability to see a specific word is given by :
$$   P(w_n|w_\text{n-2},w_\text{n-1}) =
\begin{cases}
\alpha(w_n|w_\text{n-2},w_\text{n-1}) & \text{if $count(w_n|w_\text{n-2},w_\text{n-1})$ > 0 }\\
\gamma(w_\text{n-2},w_\text{n-1}).P(w_n|w_\text{n-1}) & \text{otherwise }
\end{cases}
$$
This approach reserves some probability mass, $\gamma$, for the unseen events, and relies on a Good Turing discounting. Below the c^* values evaluated up to c=5 :


<!-- html table generated in R 3.2.2 by xtable 1.7-4 package -->
<!-- Wed May 25 18:33:31 2016 -->
<table border=1>
<tr> <th> c </th> <th> Unigrams </th> <th> Bigrams </th> <th> Trigrams </th>  </tr>
  <tr> <td align="right">   0 </td> <td align="right"> 0.66 </td> <td align="right"> 0.91 </td> <td align="right"> 0.97 </td> </tr>
  <tr> <td align="right">   1 </td> <td align="right"> 0.58 </td> <td align="right"> 0.30 </td> <td align="right"> 0.15 </td> </tr>
  <tr> <td align="right">   2 </td> <td align="right"> 1.62 </td> <td align="right"> 1.21 </td> <td align="right"> 0.98 </td> </tr>
  <tr> <td align="right">   3 </td> <td align="right"> 2.45 </td> <td align="right"> 2.17 </td> <td align="right"> 1.95 </td> </tr>
  <tr> <td align="right">   4 </td> <td align="right"> 3.69 </td> <td align="right"> 3.18 </td> <td align="right"> 2.93 </td> </tr>
  <tr> <td align="right">   5 </td> <td align="right"> 4.82 </td> <td align="right"> 4.15 </td> <td align="right"> 3.90 </td> </tr>
   </table>
<BR>

---

## The App
### Special attention has been brought to App **Weight** and **User Experience**.

- Inspired by [Paul & Klein publication](http://nlp.cs.berkeley.edu/pubs/Pauls-Klein_2011_LM_paper.pdf), an indexation of Bi-grams and Tri-grams files has been performed, using Uni-grams as a reference for index. This led to a significant reduction of the size of the files by `50%` and `66%` respectively.

- The App aims to predict the next word *on the fly*, ie as you are typing (same feature as on your prefered samartphone). The various outputs proposed (Text, Plots, Tabs) are then changing dynamically.

### ENJOY !
