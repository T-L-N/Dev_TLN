--[[ 
--By @x_I_10_I_x
--By @llN00Nll
--By @liknil
--ch> @Dev_TLN  
▀▄ ▄▀     delete : حذف الرسائل            ▀▄ ▄▀ 
▀▄▀▀▄▄▀▀▄▄▀▄▄▀▀▄▄▀▀▄▄▀▄▄▀▀▄▄▀▀▄▄▀▄▄▀▀▄▄▀▀▄▄▀▄▄▀▀
--]]
local function history(extra, suc, result)
  for i=1, #result do
    delete_msg(result[i].id, ok_cb, false)
  end
  if tonumber(extra.con) == #result then
    send_msg(extra.chatid, '"'..#result..'"  🚫تہم تنہظيہف نہفآيہآتہ آلہكہروبہ ⚠️😒', ok_cb, false)
  else
send_msg(extra.chatid, '🚫تہم تنہظيہف جمہيع  الہروابط 😐 ولتہوجہيه داخہل  ⚠️آلہٰكہٰروب😻', ok_cb, false)
end
end
local function dragon(msg, matches)
  if matches[1] == 'تنظيف' and is_sudo(msg) then
    if msg.to.type == 'channel' then
    if tonumber(matches[2]) > 100000 or tonumber(matches[2]) < 1 then
        return "يمكنك وضع عدد100000 رسالة او اقل فقط"
      end
      get_history(msg.to.peer_id, matches[2] + 1 , history , {chatid = msg.to.peer_id, con = matches[2]})
    else
      return ""
    end
  else
    return "لہآ تہلہعہب🍷🐸 بہكہيہفہك 👌🏿️"
  end
end

return {
    patterns = {
        '^(تنظيف) (%d*)$'
    },
    run = dragon
}