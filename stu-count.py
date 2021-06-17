# -*- coding: utf-8 -*-
import sys
reload(sys)
sys.setdefaultencoding('utf8')
from pyspark.sql import SparkSession
spark = SparkSession.builder.appName("StuCount").getOrCreate()

people = spark.read.option("header", "true").option("inferSchema", "true")\
    .csv("file:///home/happy/Downloads/data")

print("Here is our inferred schema:")
people.printSchema()

people.groupBy("学号").agg({"学号":"count"}).sort("学号").show(100)

spark.stop()