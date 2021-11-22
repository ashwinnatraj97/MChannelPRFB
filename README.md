# M Channel Perfect Reconstruction Filter Bank
Here we design an M-Channel Perfect Reconstruction Filter(PFRB) bank in an efficient parrallelised structure from a cascaded tree strcuture using Noble's Identities. We test out the efficiency of the M-Channel PFRB with the following filters.

* Raised Cosine Filter of Length N = 32, β = 0.35 
* Raised Cosine Filter of Length N = 48, β = 0.1 
* Two Tap Filter, h[n] = {1, 1}

We visulaize each component of the analysis and sythensis filter banks and compare the frequency content of the input and output signals to check for any changes in the frequency content of the signal.
The input signal here is considered as a sample funtion of Gaussian Random process of zero mean and unit variance. This helps us to see the efficiency of the PFRB as the input signal contains all the frequencies possible.
 
This was done as a part of the homework for [Digital Signal Processing I (ECE 538)](https://engineering.purdue.edu/~ee538/) , [PFRB Assignment](https://engineering.purdue.edu/~ee538/MatlabHmwk2F21.pdf) in Fall 2021 at Purdue University.
