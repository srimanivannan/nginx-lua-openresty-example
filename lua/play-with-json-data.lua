local _JsonPlay = {}

function _JsonPlay.parseJsonData()
    ngx.req.read_body()
    local cjson = require "cjson"
    local body = cjson.decode(ngx.req.get_body_data())
    ngx.req.set_header("x-body-token", body.token)
    ngx.req.set_header("Content-Type", "application/json")
    ngx.log(ngx.INFO, body.token)
    -- This is calling endpoint within nginx conf
    local response = ngx.location.capture(
        '/postJsonRequestAndGetThatJsonResponseBack',
        { method = ngx.HTTP_POST, body = '{"id": 1, "username":"mani","greetMessage":"Good to see you"}' }
    )
    ngx.say(response.body)
    return ngx.exit(ngx.HTTP_OK)
end

return _JsonPlay