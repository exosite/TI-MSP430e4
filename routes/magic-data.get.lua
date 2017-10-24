--#ENDPOINT GET /magic/data/
-- I am using this endpoint to test how the freeboard is actually getting data through Murano.
-- My guess is that the data sources section allows you ro descibe a procedure to user the viewers \
-- browser to query some URI.

math.randomseed(os.time())
local number = math.random(100)

response.message = {hello = number}
