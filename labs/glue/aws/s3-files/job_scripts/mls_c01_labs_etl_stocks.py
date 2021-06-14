import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

## @params: [JOB_NAME]
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)
## @type: DataSource
## @args: [database = "mls-c01-labs-catalog-database", table_name = "stocks", transformation_ctx = "datasource0"]
## @return: datasource0
## @inputs: []
datasource0 = glueContext.create_dynamic_frame.from_catalog(database = "mls-c01-labs-catalog-database", table_name = "stocks", transformation_ctx = "datasource0")
## @type: ApplyMapping
## @args: [mapping = [("date", "string", "date", "string"), ("open", "double", "open", "double"), ("high", "double", "high", "double"), ("low", "double", "low", "double"), ("close", "double", "close", "double"), ("adj close", "double", "adj close", "double"), ("volume", "long", "volume", "long")], transformation_ctx = "applymapping1"]
## @return: applymapping1
## @inputs: [frame = datasource0]
applymapping1 = ApplyMapping.apply(frame = datasource0, mappings = [("date", "string", "date", "string"), ("open", "double", "open", "double"), ("high", "double", "high", "double"), ("low", "double", "low", "double"), ("close", "double", "close", "double"), ("adj close", "double", "adj close", "double"), ("volume", "long", "volume", "long")], transformation_ctx = "applymapping1")
## @type: SelectFields
## @args: [paths = ["date", "open", "high", "low", "close", "adj close", "volume"], transformation_ctx = "selectfields2"]
## @return: selectfields2
## @inputs: [frame = applymapping1]
selectfields2 = SelectFields.apply(frame = applymapping1, paths = ["date", "open", "high", "low", "close", "adj close", "volume"], transformation_ctx = "selectfields2")
## @type: ResolveChoice
## @args: [choice = "MATCH_CATALOG", database = "mls-c01-labs-catalog-database", table_name = "stocks", transformation_ctx = "resolvechoice3"]
## @return: resolvechoice3
## @inputs: [frame = selectfields2]
resolvechoice3 = ResolveChoice.apply(frame = selectfields2, choice = "MATCH_CATALOG", database = "mls-c01-labs-catalog-database", table_name = "stocks", transformation_ctx = "resolvechoice3")
## @type: DataSink
## @args: [database = "mls-c01-labs-catalog-database", table_name = "stocks", transformation_ctx = "datasink4"]
## @return: datasink4
## @inputs: [frame = resolvechoice3]
datasink4 = glueContext.write_dynamic_frame.from_catalog(frame = resolvechoice3, database = "mls-c01-labs-catalog-database", table_name = "stocks", transformation_ctx = "datasink4")
job.commit()