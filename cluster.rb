module ClumsyKMeans

  class Cluster

    attr_reader :centroid, :members

    def initialize(centroid)
      @centroid = centroid
      @members = []
      @dirty = true
    end


    def add(v)
      @members.push(v)
      @dirty = true
    end

    def clear
      @members = [] if @members.length > 0
      @dirty = true
    end


    def update_centroid
      @dirty = false
      centroid = []
      0.upto(@centroid.size - 1) do |i|
        column = columns(i)
        centroid[i] = column.reduce(:+)/column.length
      end
      @centroid = Vector::elements(centroid)
    end


    def std_dev
      if @dirty == true || !@std_dev
        compute_std_dev
      else
        @std_dev
      end
    end

  private


    def compute_std_dev
      devs = 0.0
      0.upto(@centroid.size - 1) do |i|
        devs += compute_array_std_dev(columns(i))
      end
      @std_dev = devs
    end

    def compute_array_std_dev(array)
      mean = array.reduce(:+)/array.length.to_f
      sum_sq = array.reduce(0) {|a,e| a + (e - mean)**2}
      Math::sqrt(sum_sq/(array.length - 1))
    end

    def columns(i)
      @members.collect {|r| r[:vector].[](i)}
    end

  end

end