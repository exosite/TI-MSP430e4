--#ENDPOINT GET /v1/dashboard
-- luacheck: globals request response (magic variables from Murano)


local function instantiate_dashboard()
	local ret = Keystore.get{key='serialNumbers'}
	if ret.value == nil then
		return nil
	end

	for _, sn in ipairs(ret.value) do
		hard_coded_panes = [==[[{
				"col": {
					"3": 2
				},
				"col_width": 1,
				"row": {
					"3": 1
				},
				"title": "TEMPERATURE",
				"widgets": [{
					"settings": {
						"max_value": 100,
						"min_value": 0,
						"title": "temp",
						"value": "datasources[\"]==]..sn..[==[ All Timeseries Data\"][\"values\"][0][3]"
					},
					"type": "gauge"
				}],
				"width": 1
			},
			{
				"col": {
					"3": 3
				},
				"col_width": 1,
				"row": {
					"3": 5
				},
				"title": "User Switch 2",
				"widgets": [{
					"settings": {
						"animate": false,
						"size": "regular",
						"title": "usrsw2",
						"value": "datasources[\"]==]..sn..[==[ All Timeseries Data\"][\"values\"][0][5]"
					},
					"type": "text_widget"
				}],
				"width": 1
			},
			{
				"col": {
					"3": 3
				},
				"col_width": 1,
				"row": {
					"3": 1
				},
				"title": "User Switch 1",
				"widgets": [{
					"settings": {
						"animate": false,
						"size": "regular",
						"title": "usrsw1",
						"value": "datasources[\"]==]..sn..[==[ All Timeseries Data\"][\"values\"][0][4]"
					},
					"type": "text_widget"
				}],
				"width": 1
			},
			{
				"col": {
					"3": 1
				},
				"col_width": 1,
				"row": {
					"3": 5
				},
				"widgets": [{
					"settings": {
						"off_text": "Off",
						"on_text": "On",
						"title": "led",
						"value": "Off"
					},
					"type": "indicator"
				}],
				"width": 1
			},
			{
				"col": {
					"3": 1
				},
				"col_width": 1,
				"row": {
					"3": 1
				},
				"title": "ON TIME",
				"widgets": [{
					"settings": {
						"animate": true,
						"size": "regular",
						"title": "ontime",
						"value": "datasources[\"]==]..sn..[==[ All Timeseries Data\"][\"values\"][0][2]"
					},
					"type": "text_widget"
				}],
				"width": 1
			}
		]]==]	
		return from_json(hard_coded_panes)
	end

end


local function injectDatasources(datasources)
	local ret = Keystore.get{key='serialNumbers'}
	if ret.value == nil then
		return datasources
	end

	for _, sn in ipairs(ret.value) do

		name = sn .. ' All Timeseries Data'
		idx, _ = table.find(datasources, 'name', name)
		if idx == nil then
			local ads = {
				name = sn .. ' All Timeseries Data',
				type = 'JSON',
				settings = {
					method = 'GET',
					refresh = 5,
					url = '/v1/data/' .. sn,
					use_thingproxy = false
				}
			}
			datasources[#datasources + 1] = ads
		end
	end

	return datasources
end

local got = Keystore.get{key='dashboard.0'}
if got.code ~= nil then
	response.code = got.code
	response.message = got
elseif got.value == nil then
	
	response.message = {
		allow_edit = true,
		columns = 3,
		datasources = injectDatasources({}),
		version = 1
	}
	dash_panes = instantiate_dashboard()
	if dash_panes ~= nil then
		response.message.panes = dash_panes
	end
	print(to_json_datasources)
else
	local ex, err = from_json(got.value)
	if ex ~= nil then

		ex.datasources = injectDatasources(ex.datasources)

		response.message = ex
	else
		response.code = 500
		response.message = err
	end
end

-- vim: set ai sw=2 ts=2 :
