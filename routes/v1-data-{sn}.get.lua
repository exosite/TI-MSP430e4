--#ENDPOINT GET /v1/data/{sn}
-- luacheck: globals request response (magic variables from Murano)
-- Description: Get timeseries data for specific device

local identifier = request.parameters.sn

-- For now, grab all metrics and query them.  In future, can we be smarter about
-- this?
local metrics = Tsdb.listMetrics()

local out = Tsdb.query{
  tags={sn=identifier},
  metrics=metrics.metrics,
  limit = 10,
  epoch = 'ms',
}

print(to_json(out))

return out

-- vim: set et ai sw=2 ts=2 :
