--#ENDPOINT GET /tsdb/metrics

local out = Tsdb.listMetrics()
response.message = out
