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
local function run(msg, matches)
    if is_momod(msg) then
        return
    end
    local data = load_data(_config.moderation.data)
    if data[tostring(msg.to.id)] then
        if data[tostring(msg.to.id)]['settings'] then
            if data[tostring(msg.to.id)]['settings']['tag'] then
                lock_tag = data[tostring(msg.to.id)]['settings']['tag']
            end
        end
    end
    local chat = get_receiver(msg)
    local user = "user#id"..msg.from.id
    if lock_tag == "yes" then
       delete_msg(msg.id, ok_cb, true)
    end
end
 
return {
  patterns = {
  "#"
  },
  run = run
}


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
