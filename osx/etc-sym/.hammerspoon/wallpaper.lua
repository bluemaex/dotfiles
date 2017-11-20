local timer = nil
local last_url = nil
local user_agent_str = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/603.2.4 (KHTML, like Gecko) Version/10.1.1 Safari/603.2.4"
local json_req_url = "http://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1"

-- actual curl request to download the image
local curlRequest = nil
local function curl_callback(filepath, exitCode, stdOut, stdErr)
    if exitCode == 0 then
        curlRequest = nil
        hs.screen.mainScreen():desktopImageURL("file://" .. filepath)
    else
        print(stdOut, stdErr)
    end
end

local function curl_request(url, callback)
  if curlRequest then
      curlRequest:terminate()
      curlRequest = nil
  end

  local localpath = os.getenv("TMPDIR") .. hs.http.urlParts(url).lastPathComponent
  local callbackWrapper = hs.fnutils.partial(callback, localpath)
  curlRequest = hs.task.new("/usr/bin/curl", callbackWrapper, {"-A", user_agent_str, url, "-o", localpath})
  curlRequest:start()
end

-- query bing for the daily json to get image
local function query_bing()
    hs.http.asyncGet(json_req_url, {["User-Agent"]=user_agent_str}, function(stat,body,header)
        if stat == 200 then
            if pcall(function() hs.json.decode(body) end) then
                local decoded_json = hs.json.decode(body)
                local new_url = "https://www.bing.com" .. decoded_json.images[1].url

                if new_url ~= last_url then
                    last_url = new_url
                    curl_request(new_url, curl_callback)
                end
            end
        end
    end)
end

--- do a request every 6h for a new desktop image
if timer == nil then
    timer = hs.timer.doEvery(6 * 60 * 60, query_bing)
    timer:setNextTrigger(5)
else
    timer:start()
end
