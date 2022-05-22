local _Hello = {}

function _Hello.greet(name)
    ngx.say("Message from hello.lua file from the greet function ", name)
end

function _Hello.getHardCodedJsonResponse()
    local cjson = require "cjson"
    ngx.status  = ngx.HTTP_OK
    ngx.say(cjson.encode('{"greetMessage":"This is the Greeting Message from Lua"}'))
    return ngx.exit(ngx.HTTP_OK) -- return is not necessary
end

function _Hello.postJsonRequestAndGetThatJsonResponseBack()
    local cjson = require "cjson"
    -- To understand below oneline: read : https://ketzacoatl.github.io/posts/2017-03-03-JSON-POST-processing-in-openresty.html

    local get, post, files = require "resty.reqargs"()
    -- print is not working. will look at it later
    print ("print message")
    -- for index, data in ipairs(get) do
    --     print(index)
    
    --     for key, value in pairs(data) do
    --         print('\t', key, value)
    --     end
    -- end
    ngx.status  = ngx.HTTP_OK
    ngx.say(cjson.encode(post))
    return ngx.exit(ngx.HTTP_OK)
end

return _Hello
