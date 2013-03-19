require 'matrix'
require_relative 'cluster'

module ClumsyKMeans
  
  class Clusterer

    attr_reader :matrix, :centroids, :old_centroids, :clusters, :iterations


    def build(matrix, k, max_iterations = 1000)
      @matrix, @k, @max_iterations = matrix, k, max_iterations

      setup

      @iterations = 0

      begin 
        compute_cluster_members
        update_centroids
        @iterations += 1
      end while !stopping_condition_met?

    end


  private

    def setup
      @clusters = []
      sample_initial_centroids().each do |c|
        puts Vector::elements(c)
        @clusters << KMeans::Cluster.new(Vector::elements(c))
      end
    end


    def sample_initial_centroids
      @matrix.to_a.sample(@k)
    end




    def compute_cluster_members
      
      @centroids = @clusters.collect { |c| c.centroid }
      @clusters.each {|c| c.clear}

      0.upto(@matrix.row_size - 1) do |r|
        distances = compute_distance_to_centroids(@matrix.row(r))
        min_cluster_index = distances.index(distances.min)
        @clusters[min_cluster_index].add({index:  r, vector: @matrix.row(r)})
      end

    end


    def compute_distance_to_centroids(v)
      @centroids.map { |c| euclidean_distance(v, c) }
    end


    def euclidean_distance(u, v)
      (u - v).magnitude
    end


    def update_centroids
      @old_centroids = @centroids
      @centroids = @clusters.collect { |c| c.update_centroid }
    end


    def stopping_condition_met?
      @old_centroids == @centroids || @max_iterations <= @iterations
    end

  end

end