Clumsy K-Means
============

This is a clumsy implementation of the <a href="http://en.wikipedia.org/wiki/K-means_clustering" target="_blank">k-means clustering algorithm</a> using Ruby vectors and matrices. 

Why is it clumsy? 
-----------------
We're using this for the final step in a Spectral Clustering algorithm. Since it's clustering a matrix of eigenvectors, the clusters arise very easily. So we're not very concerned about scaling or crazy efficiency.

There are <a href="https://github.com/reddavis/K-Means" target="_blank">faster k-means implementations</a> in Ruby, but they have MRI dependencies so they won't run in jRuby. Also, other implementations don't compute the cluster standard deviation or return the set of indices from the original matrix for each cluster.


Usage
-----

```ruby
m = Matrix[ [0, 1], [0, 0.75], [1, 0], [0.75, 0] ]
k = KMeans::Clusterer.new
k.build(m,2)
k.clusters[0].std_dev
```