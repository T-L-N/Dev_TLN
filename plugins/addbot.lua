--[[ 
 _____   _       _   _     
|_   _| | |     | \ | |    
  | |   | |     |  \| |    
  | |   | |___  | |\  |    
  |_|   |_____| |_| \_|    
Dev @Aaa1R (علي_دراكون)
Dev @llN00Nll (نظوري_الرئاسه)
Dev @liknil (كرار_ابن_الرئاسه)
Dev @x_I_10_I_x (انور_فايدر)
—]]
do

local function parsed_url(link)
  local parsed_link = URL.parse(link)
  local parsed_path = URL.parse_path(parsed_link.path)
  return parsed_path[2]
end

function run(msg, matches)
  local hash = parsed_url(matches[1])   
  join = import_chat_link(hash,ok_cb,false)
end


return {
  description = "Add Robot to Group", 
  usage = "ادخل (link) : add bot to group",
  patterns = {
    "^ادخل (.*)$"
  }, 
  run = run
}

end
--[[ 
    --By @x_I_10_I_x
--By @llN00Nll
--By @liknil
--ch> @Dev_TLN
--]]