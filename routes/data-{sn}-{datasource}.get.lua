--#ENDPOINT GET /data/{sn}/{datasource}
-- luacheck: globals request response (magic variables from Murano)
-- Description: Get timeseries data for specific device
-- Parameters: ?window=<number>
local identifier = request.parameters.sn
local alias = request.parameters.datasource
local window = request.parameters.window -- in minutes,if ?window=<number>

if window == nil then window = '-30' end

local metrics = {
    alias
}
local tags = {
  identity = identifier
}
-- local query = {
--   metrics = metrics,
--   tags = tags
-- }

local out = Tsdb.query({
  metrics = {alias},
  tags = tags,
  relative_start = window.."m",
  epoch = "ms",
  fill = "null",
  limit = 1
})

response.message = out
