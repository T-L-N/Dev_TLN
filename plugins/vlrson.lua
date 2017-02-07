--[[ 
 _____   _       _   _     
|_   _| | |     | \ | |    
  | |   | |     |  \| |    
  | |   | |___  | |\  |    
  |_|   |_____| |_| \_|    
Dev @Aaa1R
Dev @llN00Nll
Dev @liknil
Dev @x_I_10_I_x
--]]

  do
  
  function dragon(msg, matches)
  local reply_id = msg['id']
    local S = 'https://telegram.me/Dev_TLN'  reply_msg(reply_id, S, ok_cb, false)
  end
  
  return {
    patterns = {
  "^(الاصدار)$",
    }, 
    run = dragon 
  }
  
  end
