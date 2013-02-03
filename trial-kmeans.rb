# Weka scripting from jruby
# Written by Peter Lane, 2009.
# Run with: java -jar jruby.jar trial-kmeans.rb FILENAME.arff
# NOTE: this requires weka.jar to be in the execution folder.  A symbolic link
# will work fine.
# 

require "java"
require "weka"

java_import "java.io.FileReader"
java_import "weka.clusterers.SimpleKMeans"
java_import "weka.core.Instances"

# load data file
file = FileReader.new ARGV[0]
data = Instances.new file
 

# create the model
kmeans = SimpleKMeans.new
kmeans.buildClusterer data

# print out the built model
print kmeans

# Display the cluster for each instance
data.numInstances.times do |i|
  cluster = "UNKNOWN"
    begin
      cluster = kmeans.clusterInstance(data.instance(i))
    rescue java.lang.Exception
    end
  puts "#{data.instance(i)},#{cluster}"
end
