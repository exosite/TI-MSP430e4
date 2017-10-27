--#EVENT {product.id} event
-- luacheck: globals event (magic variable from Murano)

local handler = require "data_handler"

handler.data_in(event)