--[[ 
    _____    _        _    _    _____    Dev @lIMyIl 
   |_   _|__| |__    / \  | | _| ____|   Dev @li_XxX_il
     | |/ __| '_ \  / _ \ | |/ /  _|     Dev @h_k_a
     | |\__ \ | | |/ ___ \|   <| |___    Dev @Aram_omar22
     |_||___/_| |_/_/   \_\_|\_\_____|   Dev @IXX_I_XXI
              CH > @lTSHAKEl_CH
سوبر الزعيم 
تعديل المطورين الفووك :)
--]]
local function check_member_super(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  if success == 0 then
	send_large_msg(receiver, "شہٰدتہٰحہٰس آبہٰنہٰيے لہٰلہٰكہٰبہٰآر فہٰقہٰط")
 end
  for k,v in pairs(result) do
    local member_id = v.peer_id
    if member_id ~= our_id then
      -- SuperGroup configuration
      data[tostring(msg.to.id)] = {
        group_type = 'SuperGroup',
        long_id = msg.to.peer_id,
        moderators = {},
        set_owner = member_id ,
        settings = {
          set_name = string.gsub(msg.to.title, '_', ' '),
          lock_arabic = 'no',
          lock_link = "no",
          flood = 'yes',
          lock_spam = 'yes',
          lock_sticker = 'no',
          member = 'no',
          public = 'no',
          lock_rtl = 'no',
          lock_contacts = 'no',
          strict = 'no'
        }
      }
      save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
   local text = '🛡 تمے تفہٰٖعيل ✔️ الہٰٖبوت فہٰٖي المہٰٖجموعہٰٖةه 😻🎐\n'..msg.to.title
      return reply_msg(msg.id, text, ok_cb, false)
    end
  end
end

--Check Members #rem supergroup
local function check_member_superrem(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  for k,v in pairs(result) do
    local member_id = v.id
    if member_id ~= our_id then
      -- Group configuration removal
      data[tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
      local text = '🛡 تمے تعہٰٖطيل ❌ الہٰٖبوت فہٰٖي المہٰٖجموعہٰٖةه 🙀🚏\n'..msg.to.title
      return reply_msg(msg.id, text, ok_cb, false)
    end
  end
end

--Function to Add supergroup
local function superadd(msg)
    local data = load_data(_config.moderation.data)
    local receiver = get_receiver(msg)
    channel_get_users(receiver, check_member_super,{receiver = receiver, data = data, msg = msg})
end

--Function to remove supergroup
local function superrem(msg)
    local data = load_data(_config.moderation.data)
    local receiver = get_receiver(msg)
    channel_get_users(receiver, check_member_superrem,{receiver = receiver, data = data, msg = msg})
end

--Get and output admins and bots in supergroup
local function callback(cb_extra, success, result)
local i = 1
local chat_name = string.gsub(cb_extra.msg.to.print_name, "_", " ")
local member_type = cb_extra.member_type
local text = member_type.." for "..chat_name..":\n"
for k,v in pairsByKeys(result) do
if not v.first_name then
    name = " "
else
    vname = v.first_name:gsub("‮", "")
    name = vname:gsub("_", " ")
    end
        text = text.."\n"..i.." - "..name.."["..v.peer_id.."]"
        i = i + 1
    end
        send_large_msg(cb_extra.receiver, text)
end

--Get and output info about supergroup
local function callback_info(cb_extra, success, result)
local title ="✝ مہٰعہٰلہٰومہٰآتہٰ ‼️  عہٰن آلہٰمہٰجہٰمہٰوعہٰة ⚠️ : ["..result.title.."]\n\n"
local admin_num = "⚠️  عہٰدد ⁉️ آلآدمہٰنہٰيہٰةة 💯 : "..result.admins_count.."\n"
local user_num = "♨️  عہٰدد  آلآعہٰضہٰآء  ✅ : "..result.participants_count.."\n"
local kicked_num = "⁉️ آلآعہٰضہٰآء آلآكہٰثہٰر تہٰفہٰآعہٰل  👥 : "..result.kicked_count.."\n"
local channel_id = "آيہٰديے آلہٰمہٰجہٰمہٰوعہٰةة 🆔 : "..result.peer_id.."\n"
if result.username then
    channel_username = "مہٰعہٰرفہ آلہٰمہٰجہٰمہٰوعہٰةة 🆔 : @"..result.username
else
 channel_username = ""
end
local text = title..admin_num..user_num..kicked_num..channel_id..channel_username
    send_large_msg(cb_extra.receiver, text)
end

--Get and output members of supergroup
local function callback_who(cb_extra, success, result)
local text = "آعہٰضہٰآء 🚸 آلـمـ‼️ـجہٰموعــۿﮧ⚜\n"..cb_extra.receiver
local i = 1
for k,v in pairsByKeys(result) do
if not v.print_name then
    name = " "
else
    vname = v.print_name:gsub("‮", "")
    name = vname:gsub("_", " ")
end
    if v.username then
        username = " @"..v.username
    else
        username = ""
    end
    text = text.."\n"..i.." - "..name.." "..username.." [ "..v.peer_id.." ]\n"
    --text = text.."\n"..username
    i = i + 1
end
    local file = io.open("./groups/lists/supergroups/"..cb_extra.receiver..".txt", "w")
    file:write(text)
    file:flush()
    file:close()
    send_document(cb_extra.receiver,"./groups/lists/supergroups/"..cb_extra.receiver..".txt", ok_cb, false)
    post_msg(cb_extra.receiver, text, ok_cb, false)
end

--Get and output list of kicked users for supergroup
local function callback_kicked(cb_extra, success, result)
--vardump(result)
local text = "💻 قہٰآئہٰمہٰةة آيہٰديہٰآتہٰ آلآعہٰضہٰآءہ 📝"..cb_extra.receiver.."\n\n"
local i = 1
for k,v in pairsByKeys(result) do
if not v.print_name then
    name = " "
else
    vname = v.print_name:gsub("‮", "")
    name = vname:gsub("_", " ")
end
    if v.username then
        name = name.." @"..v.username
    end
    text = text.."\n"..i.." - "..name.." [ "..v.peer_id.." ]\n"
    i = i + 1
end
    local file = io.open("./groups/lists/supergroups/kicked/"..cb_extra.receiver..".txt", "w")
    file:write(text)
    file:flush()
    file:close()
    send_document(cb_extra.receiver,"./groups/lists/supergroups/kicked/"..cb_extra.receiver..".txt", ok_cb, false)
    --send_large_msg(cb_extra.receiver, text)
end

--Begin supergroup locks
local function lock_group_links(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_link_lock = data[tostring(target)]['settings']['lock_link']
  if group_link_lock == 'yes' then
    return '🛡بالتأكيد تمے قفل 🔐 الہٰٖروآبــہٰٖطے ⭕️🤖 \n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['lock_link'] = 'yes'
    save_data(_config.moderation.data, data)
    return ' تمے قفل 🔐 الہٰٖروآبــہٰٖطے ⭕️🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function unlock_group_links(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_link_lock = data[tostring(target)]['settings']['lock_link']
  if group_link_lock == 'no' then
    return '🛡بالتأكيد تمے فتح ✔️ الہٰٖروآبــہٰٖطے 🎐🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['lock_link'] = 'no'
    save_data(_config.moderation.data, data)
    return 'تمے فتح ✔️ الہٰٖروآبــہٰٖطے 🎐🤖 \n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
    end
end
--------------------------------
local function lock_group_spam(msg, data, target)
  if not is_momod(msg) then
    return
  end
  if not is_momod(msg) then
    return " 🤖 لہٰتلہٰعہٰب آبہٰنيے لہٰلہٰدمہٰنيہٰۿﮧ #فہٰقہٰط ⁉️ "
  end
  local group_spam_lock = data[tostring(target)]['settings']['lock_spam']
  if group_spam_lock == 'yes' then
    return '🛡بالتأكيد تمے قفل🔐 الكلاي‏ــہٰٰـــشــہٰٰـــ⭕️🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['lock_spam'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'تمے قفل🔐 الكلاي‏ــہٰٰـــشــہٰٰـــ⭕️🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function unlock_group_spam(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_spam_lock = data[tostring(target)]['settings']['lock_spam']
  if group_spam_lock == 'no' then
    return '🛡بالتأكيد تمے فتح ✔️ الكلايــہٰٰـــشــہٰٰـــ🎐🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['lock_spam'] = 'no'
    save_data(_config.moderation.data, data)
    return '🛡 تمے فتح ✔️ الكلايــہٰٰـــشــہٰٰـــ🎐🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end
---------------------------------
local function lock_group_flood(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_flood_lock = data[tostring(target)]['settings']['flood']
  if group_flood_lock == 'yes' then
    return '🛡بالتأكيد تمے قفل 🔐 آلہٰتہكہٰرآر 🎛\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['flood'] = 'yes'
    save_data(_config.moderation.data, data)
    return '🛡تمے قفل🔐  آلہٰتہكہٰرآر 🎛\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function unlock_group_flood(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_flood_lock = data[tostring(target)]['settings']['flood']
  if group_flood_lock == 'no' then
    return '🛡بالتأكيد تمے ✔️ فتح  آلہٰتہكہٰرآر 🎛 \n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['flood'] = 'no'
    save_data(_config.moderation.data, data)
    return '🛡 تمے ✔️ فتح  آلہٰتہكہٰرآر 🎛\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end
---------------------------------
local function lock_group_arabic(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_arabic_lock = data[tostring(target)]['settings']['lock_arabic']
  if group_arabic_lock == 'yes' then
    return 'بالتأكيد🛡 تمے قِفِّلَ ✔️ العربہٰٖيةه  🆎📲 \n👲🏻#بواسطه  (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['lock_arabic'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'تمے قفہٰٖل ✔️ العربہٰٖيةه  🆎📲  \n👲🏻#بواسطه  (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end
local function unlock_group_arabic(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_arabic_lock = data[tostring(target)]['settings']['lock_arabic']
  if group_arabic_lock == 'no' then
    return ' 🛡بالتأكيد تمے فتح ✔️ العربہٰٖيةه  🆎📲\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['lock_arabic'] = 'no'
    save_data(_config.moderation.data, data)
    return ' تمے فتح ✔️ العربہٰٖيةه  🆎📲\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end
------------------------------
local function lock_group_membermod(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_member_lock = data[tostring(target)]['settings']['lock_member']
  if group_member_lock == 'yes' then
    return '🛡بالتأكيد تمے قفل🔐 آلآضہــٰٰآفــہٰٰـــۿﮧ ⭕️🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['lock_member'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'تمے قفل🔐 آلآضہــٰٰآفــہٰٰـــۿﮧ ⭕️🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function unlock_group_membermod(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_member_lock = data[tostring(target)]['settings']['lock_member']
  if group_member_lock == 'no' then
    return '🛡بالتأكيد تمے فتح ✔️ آلآضہــٰٰآفــہٰٰـــۿﮧ 🎐🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['lock_member'] = 'no'
    save_data(_config.moderation.data, data)
    return 'تمے فتح ✔️ آلآضہــٰٰآفــہٰٰـــۿﮧ 🎐🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end
------------------------------
local function lock_group_rtl(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_rtl_lock = data[tostring(target)]['settings']['lock_rtl']
  if group_rtl_lock == 'yes' then
    return '🛡بالتأكيد تمے قفل🔐 آل‏جہـمہٰٰآعــيـہـہٰٰــۿﮧ⭕️🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['lock_rtl'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'تمے قفل🔐 آل‏جہـمہٰٰآعــيـہـہٰٰــۿﮧ⭕️🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function unlock_group_rtl(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_rtl_lock = data[tostring(target)]['settings']['lock_rtl']
  if group_rtl_lock == 'no' then
    return '🛡بالتأكيد تمے فتح ✔️ آل‏جہـمہٰٰآعــيـہـہٰٰــۿﮧ🎐🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['lock_rtl'] = 'no'
    save_data(_config.moderation.data, data)
    return 'تمے فتح ✔️ آل‏جہـمہٰٰآعــيـہـہٰٰــۿﮧ🎐🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end
----------------------------
local function lock_group_sticker(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_sticker_lock = data[tostring(target)]['settings']['lock_sticker']
  if group_sticker_lock == 'yes' then
    return '🛡بالتأكيد تمے قفل 🔐 آلـمـہٰٖلـصہٰٖقـہٰٖآت⭕️🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['lock_sticker'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'تمے قفل 🔐 آلـمـہٰٖلـصہٰٖقـہٰٖآت⭕️🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end
local function unlock_group_sticker(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_sticker_lock = data[tostring(target)]['settings']['lock_sticker']
  if group_sticker_lock == 'no' then
    return '🛡بالتأكيد تمے فتح ✔️ آلـمـہٰٖلـصہٰٖقـہٰٖآت🎐🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['lock_sticker'] = 'no'
    save_data(_config.moderation.data, data)
    return 'تمے فتح ✔️ آلـمـہٰٖلـصہٰٖقـہٰٖآت🎐🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function lock_group_contacts(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_rtl_lock = data[tostring(target)]['settings']['lock_contacts']
  if group_contacts_lock == 'yes' then
    return '🛡بالتأكيد تمے قفل 🔐 جہٰٖهات الاتصہٰٖال🔰 📞\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['lock_contacts'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'تمے قفل 🔐 جہٰٖهات الاتصہٰٖال🔰 📞\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function unlock_group_contacts(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_contacts_lock = data[tostring(target)]['settings']['lock_contacts']
  if group_contacts_lock == 'no' then
    return '🛡بالتأكيد تمے فتح ✔️ جہٰٖهات الاتصہٰٖال♻️ 📞\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['lock_contacts'] = 'no'
    save_data(_config.moderation.data, data)
    return 'تمے فتح ✔️ جہٰٖهات الاتصہٰٖال♻️ 📞\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function enable_strict_rules(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_strict_lock = data[tostring(target)]['settings']['strict']
  if group_strict_lock == 'yes' then
    return '🛡بالتأكيد تمے قفل🔐 آل‏طہـرد فہٰٰي آلمہجہموعۿﮧ⭕️🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['strict'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'تمے قفل🔐 آل‏طہـرد فہٰٰي آلمہجہموعۿﮧ⭕️🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function disable_strict_rules(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_strict_lock = data[tostring(target)]['settings']['strict']
  if group_strict_lock == 'no' then
    return '🛡بالتأكيد تمے فتح ✔️ آل‏طہـرد فہٰٰي آلمہجہموعۿﮧ🎐🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['strict'] = 'no'
    save_data(_config.moderation.data, data)
    return 'تمے فتح ✔️ آل‏طہـرد فہٰٰي آلمہجہموعۿﮧ🎐🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function lock_group_username(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_username_lock = data[tostring(target)]['settings']['username']
  if group_username_lock == 'yes' then
    return '🛡بالتأكيد تمے قفل 🔐  المہٰٖعہٰٖرف 🌀❕\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['username'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'تمے قفل 🔐  المہٰٖعہٰٖرف 🌀❕\n👲🏻#بواسطه (@'..msg.from.username or 'لا يوجد'..'\n'
  end
end

local function unlock_group_username(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_username_lock = data[tostring(target)]['settings']['username']
  if group_username_lock == 'no' then
    return '🛡بالتأكيد تمے فتح ✔️  المہٰٖعہٰٖرف 🌀❓\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
    else
data[tostring(target)]['settings']['username'] = 'no'
    save_data(_config.moderation.data, data)
    return 'تمے فتح ✔️  المہٰٖعہٰٖرف 🌀❓\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function lock_group_emoji(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_emoji_lock = data[tostring(target)]['settings']['emoji']
  if group_emoji_lock == 'yes' then
    return '🛡بالتأكيد تمے قفل 🔐 آلْـہٰٖسہمـآيـّہلآت⭕️🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['emoji'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'تمے قفل 🔐 آلْـہٰٖسہمـآيـّہلآت⭕️��\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function unlock_group_emoji(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_emoji_lock = data[tostring(target)]['settings']['emoji']
  if group_emoji_lock == 'no' then
    return '🛡بالتأكيد تمے فتح ✔️ آلْـہٰٖسہمـآيـّہلآت🎐🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['emoji'] = 'no'
    save_data(_config.moderation.data, data)
    return 'تمے فتح ✔️ آلْـہٰٖسہمـآيـّہلآت🎐🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function lock_group_tag(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_tag_lock = data[tostring(target)]['settings']['tag']
  if group_tag_lock == 'yes' then
    return '🛡بالتأكيد تمے قفہٰٖل 🔐 الاتہٰٖاك هہٰٖنا 🙇🏿♐️\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['tag'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'تمے قفہٰٖل 🔐 الاتہٰٖاك هہٰٖنا 🙇🏿♐️\n👲��#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function unlock_group_tag(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_tag_lock = data[tostring(target)]['settings']['tag']
  if group_tag_lock == 'no' then
  return 'بالتأكيد تمے فتح ✔️ الاتہٰٖاك هہٰٖنا يد🙇🏿💟\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['tag'] = 'no'
    save_data(_config.moderation.data, data)
    return 'تمے فتح ✔️ الاتہٰٖاك هہٰٖنا 🙇🏿💟\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function lock_group_fwd(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_fwd_lock = data[tostring(target)]['settings']['fwd']
  if group_fwd_lock == 'yes' then
    return '🛡بالتأكيد تمے قفل🔐 آلتوجــہٰٰـــيۦ‏ــہٰٰـــه ⭕️🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['fwd'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'تمے قفل🔐 التوجــہٰٰـــيۦ‏ــہٰٰـــه ⭕️🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function unlock_group_fwd(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_fwd_lock = data[tostring(target)]['settings']['fwd']
  if group_fwd_lock == 'no' then
    return '🛡بالتأكيد تمے فتح ✔️ التوجــہٰٰـــيۦ‏ــہٰٰـــه 🎐🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['fwd'] = 'no'
    save_data(_config.moderation.data, data)
    return 'تمے فتح ✔️ التوجــہٰٰـــيۦ‏ــہٰٰـــه 🎐🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function lock_group_cmd(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_cmd_lock = data[tostring(target)]['settings']['cmd']
  if group_cmd_lock == 'yes' then
    return '🛡بالتأكيد تمے قفہٰٖل 🔐 الشہٰٖارحہٰٖةه ♉️〽️\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['cmd'] = 'yes'
    save_data(_config.moderation.data, data)
    return ' تمے قفہٰٖل 🔐 الشہٰٖارحہٰٖةه ♉️〽️\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'  end
  end

local function unlock_group_cmd(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_cmd_lock = data[tostring(target)]['settings']['cmd']
  if group_cmd_lock == 'no' then
    return '🛡بالتأكيد تمے فتح ✔️ الشہٰٖارحہٰٖةه ✝〽️ \n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['cmd'] = 'no'
    save_data(_config.moderation.data, data)
    return 'تمے فتح ✔️ الشہٰٖارحہٰٖةه ✝〽️ \n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function lock_group_unsupported(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_unsupported_lock = data[tostring(target)]['settings']['unsupported']
  if group_unsupported_lock == 'yes' then
    return '🛡بالتأكيد تمے قفہٰٖل 🔐 الانلايہٰٖن 🔻📢\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['unsupported'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'تمے قفہٰٖل 🔐 الانلايہٰٖن 🔻📢\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function unlock_group_unsupported(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_unsupported_lock = data[tostring(target)]['settings']['unsupported']
  if group_unsupported_lock == 'no' then
    return '🛡بالتأكيد تمے فتہٰٖح ✔️ الانلايہٰٖن 🔺📢\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['unsupported'] = 'no'
    save_data(_config.moderation.data, data)
    return 'تمے فتہٰٖح ✔️ الانلايہٰٖن 🔺📢\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function lock_group_bots(msg, data, target)
  if not is_momod(msg) then
    return 
  end
  local group_bots_lock = data[tostring(target)]['settings']['lock_bots']
  if group_bots_lock == 'yes' then
    return '🛡بالتأكيد تمے قفل 🔐 آضہٰآفہٰةة آلہٰبوتہٰآت 👾❌  \n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['lock_bots'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'تمے قفل 🔐 آضہٰآفہٰةة آلہٰبوتہٰآت 👾❌\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function unlock_group_bots(msg, data, target)
  if not is_momod(msg) then
    return 
  end
  local group_bots_lock = data[tostring(target)]['settings']['lock_bots']
  if group_bots_lock == 'no' then
    return '🛡بالتأكيد تمے فتح 🔓 آضہٰآفہٰةة آلہٰبوتہٰآت ✔️🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['lock_bots'] = 'no'
    save_data(_config.moderation.data, data)
    return 'تمے فتح 🔓 آضہٰآفہٰةة آلہٰبوتہٰآت ✔️🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function lock_group_join(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_join_lock = data[tostring(target)]['settings']['join']
  if group_join_lock == 'yes' then
    return ' 🛡بالتأكيد تمے قفہٰٖل 🔐 الدخہٰٖول بالہٰٖرابط 🚯‼️\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['lock_join'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'تمے قفہٰٖل 🔐 الدخہٰٖول بالہٰٖرابط 🚯‼️\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function unlock_group_join(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_join_lock = data[tostring(target)]['settings']['lock_join']
  if group_join_lock == 'no' then
    return ' 🛡بالتأكيد تمے فتح ✔️ الدخہٰٖول بالہٰٖرابط 🚷❓\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['lock_join'] = 'no'
    save_data(_config.moderation.data, data)
    return ' تمے فتح ✔️ الدخہٰٖول بالہٰٖرابط 🚷❓\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function lock_group_tgservice(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_tgservice_lock = data[tostring(target)]['settings']['lock_tgservice']
  if group_tgservice_lock == 'yes' then
    return ' 🛡بالتأكيد تمے قفہٰل 🔐 آلأشــہٰٖعــآرآت 🚫🏴\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['lock_tgservice'] = 'yes'
    save_data(_config.moderation.data, data)
    return ' تمے قفہٰل 🔐 آلأشــہٰٖعــآرآت 🚫🏴\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function unlock_group_tgservice(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_tgservice_lock = data[tostring(target)]['settings']['lock_tgservice']
  if group_tgservice_lock == 'no' then
    return '🛡بالتأكيد تمے فتح ✔️ آلأشــہٰٖعــآرآت🔹🏳\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['lock_tgservice'] = 'no'
    save_data(_config.moderation.data, data)
    return ' تمے فتح ✔️ آلأشــہٰٖعــآرآت🔹🏳\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end


local function lock_group_ads(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_ads_lock = data[tostring(target)]['settings']['lock_ads']
  if group_ads_lock == 'yes' then
    return '🛡بالتأكيد تمے قفل 🔐 جمــَيِّعٌ الروابــطے ⭕️🤖 \n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['lock_ads'] = 'yes'
    save_data(_config.moderation.data, data)
    return 'تمے قفل 🔐 جمــَيِّعٌ الروابــطے ⭕️🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

local function unlock_group_ads(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_ads_lock = data[tostring(target)]['settings']['lock_ads']
  if group_ads_lock == 'no' then
    return '🛡بالتأكيد تمے فتح ✔️ جمــَيِّعٌ الروابــطے 🎐🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['lock_ads'] = 'no'
    save_data(_config.moderation.data, data)
    return 'تمے فتح ✔️ جمــَيِّعٌ الروابــطے 🎐🤖 \n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end
--End supergroup locks

--'Set supergroup rules' function
local function set_rulesmod(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local data_cat = 'rules'
  data[tostring(target)][data_cat] = rules
  save_data(_config.moderation.data, data)
  return 'تـــمہٰٖـ☑️ وضہٰٖـــع الـقـوانہٰٖــ📝ــيہٰٖـن للـمہٰٖـمہٰٖـجہٰٖـمہٰٖوعـــه 👥' 
end

--'Get supergroup rules' function
local function get_rules(msg, data)
  local data_cat = 'rules'
  if not data[tostring(msg.to.id)][data_cat] then
  return 'لمے يہٰٖتمے وضہٰٖع القوانہٰٖيہٰٖن للمہٰٖجہٰٖمہٰٖوعه😢😹'
  end
  local rules = data[tostring(msg.to.id)][data_cat]
  local group_name = data[tostring(msg.to.id)]['settings']['set_name']
  local rules = group_name..'\nقوانہٰٖيہٰٖن المہٰٖجہٰٖمہٰٖوعه\nهيہٰٖ👇\n'..rules:gsub("/n", " ")
  return rules
end

--Set supergroup to public or not public function
local function set_public_membermod(msg, data, target)
  if not is_momod(msg) then
    return "لہٰتلہٰعہٰب آبہٰني🐸🚸  لہٰلہٰمہٰديہٰر #فہٰقہٰط ⁉️"
  end
  local group_public_lock = data[tostring(target)]['settings']['public']
  local long_id = data[tostring(target)]['long_id']
  if not long_id then
	data[tostring(target)]['long_id'] = msg.to.peer_id
	save_data(_config.moderation.data, data)
  end
  if group_public_lock == 'yes' then
    return '🛡بآلتأكيد آلـمـ‼️ـجہٰموعــۿﮧ آصبہٰحہٰت ! عآمہٰھﮧ 🙊💋\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['public'] = 'yes'
    save_data(_config.moderation.data, data)
  end
    return 'آلـمـ‼️ـجہٰموعــۿﮧ آصبہٰحہٰت ! عآمہٰھﮧ 🙊💋\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
end

local function unset_public_membermod(msg, data, target)
  if not is_momod(msg) then
    return
  end
  local group_public_lock = data[tostring(target)]['settings']['public']
  local long_id = data[tostring(target)]['long_id']
  if not long_id then
 data[tostring(target)]['long_id'] = msg.to.peer_id
 save_data(_config.moderation.data, data)
  end
  if group_public_lock == 'no' then
    return '🛡بآلتأكيد آلـمـ‼️ـجہٰموعــۿﮧ آصبہٰحہٰت غہــٰݛ عآمہٰھﮧ🐸❤️\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  else
    data[tostring(target)]['settings']['public'] = 'no'
    data[tostring(target)]['long_id'] = msg.to.long_id 
    save_data(_config.moderation.data, data)
    return 'آلـمـ‼️ـجہٰموعــۿﮧ آصبہٰحہٰت غہــٰݛ عآمہٰھﮧ🐸❤️\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
  end
end

--Show supergroup settings; function
function show_supergroup_settingsmod(msg, target)
 	if not is_momod(msg) then
    	return
  	end
	local data = load_data(_config.moderation.data)
    if data[tostring(target)] then
     	if data[tostring(target)]['settings']['flood_msg_max'] then
        	NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['flood_msg_max'])
        	print('custom'..NUM_MSG_MAX)
      	else
        	NUM_MSG_MAX = 5
      	end
    end
    local bots_protection = "Yes"
    if data[tostring(target)]['settings']['lock_bots'] then
    	bots_protection = data[tostring(target)]['settings']['lock_bots']
   	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['public'] then
			data[tostring(target)]['settings']['public'] = 'no'
		end
	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_rtl'] then
			data[tostring(target)]['settings']['lock_rtl'] = 'no'
		end
        end
      if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_tgservice'] then
			data[tostring(target)]['settings']['lock_tgservice'] = 'no'
		end
	end
	  if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['tag'] then
			data[tostring(target)]['settings']['tag'] = 'no'
		end
	end
	  if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['emoji'] then
			data[tostring(target)]['settings']['emoji'] = 'no'
		end
	end
	  if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['english'] then
			data[tostring(target)]['settings']['english'] = 'no'
		end
	end
	  if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['fwd'] then
			data[tostring(target)]['settings']['fwd'] = 'no'
		end
	end
	  if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['reply'] then
			data[tostring(target)]['settings']['reply'] = 'no'
		end
	end
	  if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['join'] then
			data[tostring(target)]['settings']['join'] = 'no'
		end
	end
	  if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['fosh'] then
			data[tostring(target)]['settings']['fosh'] = 'no'
		end
	end
	  if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['username'] then
			data[tostring(target)]['settings']['username'] = 'no'
		end
	end
	  if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['media'] then
			data[tostring(target)]['settings']['media'] = 'no'
		end
	end
	  if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['leave'] then
			data[tostring(target)]['settings']['leave'] = 'no'
		end
	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_member'] then
			data[tostring(target)]['settings']['lock_member'] = 'no'
		end
	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['all'] then
			data[tostring(target)]['settings']['all'] = 'no'
		end
	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['operator'] then
			data[tostring(target)]['settings']['operator'] = 'no'
		end
	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['etehad'] then
			data[tostring(target)]['settings']['etehad'] = 'no'
		end
  end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['ads'] then
			data[tostring(target)]['settings']['ads'] = 'no'
		end
	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['unsupported'] then
			data[tostring(target)]['settings']['unsupported'] = 'no'
		end
	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['cmd'] then
			data[tostring(target)]['settings']['cmd'] = 'no'
		end
	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['strict'] then
			data[tostring(target)]['settings']['strict'] = 'no'
		end
end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['photo'] then
			data[tostring(target)]['settings']['photo'] = 'no'
		end
	end
  local gp_type = data[tostring(msg.to.id)]['group_type']
  
local settings = data[tostring(target)]['settings']
local text = "🔱➖➖➖➖➖🔱 \n|💯| آعہٰـدآدآت 🚸آڶــمہٰجـمـہٰوعـہٰۿﮧ :-\n|💠| آسہٰم 🚸آڶــمہٰجـمـہٰوعـہٰۿﮧ : "..msg.to.title.."\n❗️🔸🔹🔸🔹🔸❗️\n|💠|  آلـہٰروآبـہٰط : "..settings.lock_link.."\n|💠|  جہٰـهہٰـاتـ الـہٰاتـہٰصہٰـال : "..settings.lock_contacts.."\n|💠|  آلہٰـتـہٰكـرآر  : "..settings.flood.."\n|Ⓜ️|  عـہٰـدد آلہٰـتـہٰكـرآر : "..NUM_MSG_MAX.."\n|Ⓜ️|  الـكـہٰلـايـہٰش : "..settings.lock_spam.."\n|💠|  الـلـہٰغـه الـعـہٰربـيـہٰه  : "..settings.lock_arabic.."\n|💠|  الـاضہٰـافـہٰه : "..settings.lock_member.."\n|🔰| الـاضہٰـافہٰـه الـجہٰـمـاعـہٰيـه : "..settings.lock_rtl.."\n|🔰|   الـاشـہٰعـہٰارات : "..settings.lock_tgservice.."\n|Ⓜ️|  الـمـہٰلـصہٰـقـاتـ : "..settings.lock_sticker.."\n\n|Ⓜ️|  الـتـہٰاكـہٰاتـ : "..settings.tag.."\n|🔰|  الـاسـہٰمـہٰايـالـات : "..settings.emoji.."\n|💠|  آلـبہٰـوتہٰـاتـ : "..bots_protection.."\n|💠|  آلـہٰتـوجـہٰـيه : "..settings.fwd.."\n|♻️|  الـدخـولـ بہٰـالـہٰرآبہٰط  : "..settings.join.."\n|🔰|  آلـمـہٰعـہٰرفـہٰاتـ : "..settings.username.."\n|♻️|  الانہٰلايہٰن : "..settings.unsupported.."\n|💠|  آلشہٰآرحہٰه : "..settings.cmd.."\n|💠|   جہٰميہٰع آلہٰروآبہٰط : "..settings.ads.."\n|💠|  آلہٰطہٰرد : "..settings.strict.."\n❗️🔸🔹🔸🔹🔸❗️\n @Dev_TLN"
return text
end
local function promote_admin(receiver, member_username, user_id)
  local data = load_data(_config.moderation.data)
  local group = string.gsub(receiver, 'channel#id', '')
  local member_tag_username = string.gsub(member_username, '@', '(at)')
  if not data[group] then
    return
  end
  if data[group]['moderators'][tostring(user_id)] then
    return send_large_msg(receiver, member_username..' هہٰوۃ بہٰݪ فہٰعہٰݪ آدمہٰن 🐸💋')
  end
  data[group]['moderators'][tostring(user_id)] = member_tag_username
  save_data(_config.moderation.data, data)
end

local function demote_admin(receiver, member_username, user_id)
  local data = load_data(_config.moderation.data)
  local group = string.gsub(receiver, 'channel#id', '')
  if not data[group] then
    return
  end
  if not data[group]['moderators'][tostring(user_id)] then
    return send_large_msg(receiver, member_username..' هہٰوۃ بہٰݪ فہٰعہٰݪ آدمہٰن 🐸💋')
  end
  data[group]['moderators'][tostring(user_id)] = nil
  save_data(_config.moderation.data, data)
end

local function promote2(receiver, member_username, user_id)
  local data = load_data(_config.moderation.data)
  local group = string.gsub(receiver, 'channel#id', '')
  local member_tag_username = string.gsub(member_username, '@', '(at)')
  if not data[group] then
    return send_large_msg(receiver, 'آلـمــ‼️ـجہٰموعــۿﮧ ليہٰسہٰت فعہٰالھ❌')
  end
  if data[group]['moderators'][tostring(user_id)] then
return send_large_msg(receiver, member_username..' -- 🛡 بالتأكيد تمے رفعہٰٖك ✔️ ادمہٰٖن 😻🎗 كفشہٰٖت عٰٖہٰٖمري 👲🏻  \n' ) 
end
  data[group]['moderators'][tostring(user_id)] = member_tag_username
  save_data(_config.moderation.data, data)
  send_large_msg(receiver, member_username..' -- 🛡 تمے رفعہٰٖك ✔️ ادمہٰٖن 😻🎗 كفشہٰٖت عٰٖہٰٖمري 👲🏻  : \n ')
end

local function demote2(receiver, member_username, user_id)
  local data = load_data(_config.moderation.data)
  local group = string.gsub(receiver, 'channel#id', '')
  if not data[group] then
    return send_large_msg(receiver, 'آلـمــ‼️ـجہٰموعــۿﮧ ليہٰسہٰت فعہٰالھ❌')
  end
  if not data[group]['moderators'][tostring(user_id)] then
return send_large_msg(receiver, member_username..' -- 🛡 تمے تنہٰٖزيلہٰٖك ❌ لانہٰٖك ادمہٰٖن فاشہٰٖل 😿🎐 👲🏻 # \n' )
  end
  data[group]['moderators'][tostring(user_id)] = nil
  save_data(_config.moderation.data, data)
  send_large_msg(receiver, member_username.. ' -- 🛡 تمے تنہٰٖزيلہٰٖك ❌ لانہٰٖك ادمہٰٖن فاشہٰٖل 😿🎐 👲🏻  : \n')
end

local function modlist(msg)
  local data = load_data(_config.moderation.data)
  local groups = "groups"
  if not data[tostring(groups)][tostring(msg.to.id)] then
    return 'آلـمــ‼️ـجہٰموعــۿﮧ ليہٰسہٰت فعہٰالھ❌'
  end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['moderators']) == nil then
    return '‼️ لآ يؤجہٰد آدمہٰنہٰيہٰةة حآلہٰيہٰآً 🚸✅'
  end
  local i = 1
  local message = '\nقــآئمہٰۿﮧ ❗️ آلأدمہٰنــيہٰۿﮧ📝  ' .. string.gsub(msg.to.print_name, '_', ' ') .. ':\n'
  for k,v in pairs(data[tostring(msg.to.id)]['moderators']) do
    message = message ..i..' - '..v..' [' ..k.. '] \n'
    i = i + 1
  end
  return message
end

-- Start by reply actions
function get_message_callback(extra, success, result)
    local get_cmd = extra.get_cmd
    local msg = extra.msg
    local data = load_data(_config.moderation.data)
    local print_name = user_print_name(msg.from):gsub("‮", "")
    local name_log = print_name:gsub("_", " ")
    if get_cmd == "ايدي" and not result.action then
        local channel = 'channel#id'..result.to.peer_id
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] obtained id for: ["..result.from.peer_id.."]")
        id1 = send_large_msg(channel, result.from.peer_id)
    elseif get_cmd == 'ايدي' and result.action then
        local action = result.action.type
        if action == 'chat_add_user' or action == 'chat_del_user' or action == 'chat_rename' or action == 'chat_change_photo' then
            if result.action.user then
                user_id = result.action.user.peer_id
            else
                user_id = result.peer_id
            end
            local channel = 'channel#id'..result.to.peer_id
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] obtained id by service msg for: ["..user_id.."]")
            id1 = send_large_msg(channel, user_id)
        end
    elseif get_cmd == "idfrom" then
        local channel = 'channel#id'..result.to.peer_id
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] obtained id for msg fwd from: ["..result.fwd_from.peer_id.."]")
        id2 = send_large_msg(channel, result.fwd_from.peer_id)
    elseif get_cmd == 'channel_block' and not result.action then
        local member_id = result.from.peer_id
        local channel_id = result.to.peer_id
    if member_id == msg.from.id then
      return send_large_msg("channel#id"..channel_id, "Leave using kickme command")
    end
    if is_momod2(member_id, channel_id) and not is_admin2(msg.from.id) then
            return send_large_msg(channel_id, " لآ تہٰلہٰعب آبہٰنيے 🚷 لآ يہٰمہٰكہٰنك طہٰرد  ❌الآدمہٰنہٰ آو آلہٰمہٰديہٰر  🤖 🎈")
    end
    if is_momod(member_id) then
         return send_large_msg("channel#id"..channel_id, "لآ تہٰلہٰعب آبہٰنيے 🚷 لآ يہٰمہٰكہٰنك طہٰرد  ❌الآدمہٰنہٰ آو آلہٰمہٰديہٰر  🤖 🎈  ")
    end
        --savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked: ["..user_id.."] by reply")
        kick_user(member_id, channel_id)
    elseif get_cmd == 'channel_block' and result.action and result.action.type == 'chat_add_user' then
        local user_id = result.action.user.peer_id
        local channel_id = result.to.peer_id
    if member_id == msg.from.id then
      return send_large_msg("channel#id"..channel_id, "Leave using kickme command")
    end
    if is_momod2(member_id, channel_id) and not is_admin2(msg.from.id) then
         return send_large_msg("channel#id"..channel_id, " لآ تہٰلہٰعب آبہٰنيے 🚷 لآ يہٰمہٰكہٰنك طہٰرد  ❌الآدمہٰنہٰ آو آلہٰمہٰديہٰر  🤖 🎈")
    end
    if is_admin2(member_id) then
         return send_large_msg("channel#id"..channel_id, "لآ تہٰلہٰعب آبہٰنيے 🚷 لآ يہٰمہٰكہٰنك طہٰرد  ❌الآدمہٰنہٰ آو آلہٰمہٰديہٰر  🤖 🎈")
    end
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked: ["..user_id.."] by reply to sev. msg.")
        kick_user(user_id, channel_id)
    elseif get_cmd == "احذف" then
        delete_msg(result.id, ok_cb, false)
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] deleted a message by reply")
    elseif get_cmd == "رفع اداري" then
        local user_id = result.from.peer_id
        local channel_id = "channel#id"..result.to.peer_id
        channel_set_admin(channel_id, "user#id"..user_id, ok_cb, false)
		if result.from.username then
            text = "[@"..result.from.username.."] \n🛡 تمے رفعك ❌ ضمن الادارين 👮🏿🎐 👲🏻"
		else
            text = "[ "..user_id.." ] \n🛡 تمے رفعك ❌ ضمن الادارين 👮🏿🎐 👲🏻"
		end
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] set: ["..user_id.."] as admin by reply")
        send_large_msg(channel_id, text)
    elseif get_cmd == "تنزيل اداري" then
        local user_id = result.from.peer_id
        local channel_id = "channel#id"..result.to.peer_id
		if is_admin2(result.from.peer_id) then
            return send_large_msg(channel_id, "لآ تہٰلہٰعب آبہٰنيے 🚷 لآ يہٰمہٰكہٰنك طہٰرد  ❌الآدمہٰنہٰ آو آلہٰمہٰديہٰر  🤖 🎈")
		end
		channel_demote(channel_id, "user#id"..user_id, ok_cb, false)
		if result.from.username then
            text = " [@"..result.from.username.. "] \n🛡 تمے تنہٰٖزيلہٰٖك ❌ مہٰٖن الاداره 👮🏿🎐 👲🏻 "
        else
            text = " [ "..user_id.." ] \n🛡 تمے تنہٰٖزيلہٰٖك ❌ مہٰٖن الاداره 👮🏿🎐 👲🏻 "
        end
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] demoted: ["..user_id.."] from admin by reply")
        send_large_msg(channel_id, text)
    elseif get_cmd == "رفع المدير" then
        local group_owner = data[tostring(result.to.peer_id)]['set_owner']
        if group_owner then
        local channel_id = 'channel#id'..result.to.peer_id
            if not is_admin2(tonumber(group_owner)) and not is_support(tonumber(group_owner)) then
                local user = "user#id"..group_owner
                channel_demote(channel_id, user, ok_cb, false)
            end
            local user_id = "user#id"..result.from.peer_id
            channel_set_admin(channel_id, user_id, ok_cb, false)
            data[tostring(result.to.peer_id)]['set_owner'] = tostring(result.from.peer_id)
            save_data(_config.moderation.data, data)
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] set: ["..result.from.peer_id.."] as owner by reply")
			if result.from.username then
        text = "@"..result.from.username.." [ "..result.from.peer_id.." ] \n🛡 تمے  رفعہٰٖك ✔️ مہٰٖديہٰٖر فہٰٖي المہٰٖجموعہٰٖةه 😻🕷 👲🏻 "
			else
        text = "[ "..result.from.peer_id.." ] \n🛡 تمے  رفعہٰٖك ✔️ مہٰٖديہٰٖر فہٰٖي المہٰٖجموعہٰٖةه 😻🕷 👲🏻 "
			end
            send_large_msg(channel_id, text)
        end
    elseif get_cmd == "رفع ادمن" then
        local receiver = result.to.peer_id
        local full_name = (result.from.first_name or '')..' '..(result.from.last_name or '')
        local member_name = full_name:gsub("‮", "")
        local member_username = member_name:gsub("_", " ")
        if result.from.username then
            member_username = '@'.. result.from.username
        end
        local member_id = result.from.peer_id
        if result.to.peer_type == 'channel' then
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] promoted mod: @"..member_username.."["..result.from.peer_id.."] by reply")
        promote2("channel#id"..result.to.peer_id, member_username, member_id)
        --channel_set_mod(channel_id, user, ok_cb, false)
        end
    elseif get_cmd == "تنزيل ادمن" then
        local full_name = (result.from.first_name or '')..' '..(result.from.last_name or '')
        local member_name = full_name:gsub("‮", "")
        local member_username = member_name:gsub("_", " ")
    if result.from.username then
        member_username = '@'.. result.from.username
    end
        local member_id = result.from.peer_id
        --local user = "user#id"..result.peer_id
        savelog(msg.to.id, name_log.." ["..msg.from.id.."]  تنزيل ادمن: @"..member_username.."["..result.from.peer_id.."] by reply")
        demote2("channel#id"..result.to.peer_id, member_username, member_id)
        --channel_demote(channel_id, user, ok_cb, false)
    elseif get_cmd == 'mute_user' then
        if result.service then
            local action = result.action.type
            if action == 'chat_add_user' or action == 'chat_del_user' or action == 'chat_rename' or action == 'chat_change_photo' then
                if result.action.user then
                    user_id = result.action.user.peer_id
                end
            end
            if action == 'chat_add_user_link' then
                if result.from then
                    user_id = result.from.peer_id
                end
            end
        else
            user_id = result.from.peer_id
        end
        local receiver = extra.receiver
        local chat_id = msg.to.id
        print(user_id)
        print(chat_id)
        if is_muted_user(chat_id, user_id) then
            unmute_user(chat_id, user_id)
send_large_msg(receiver, " ["..user_id.."] \n🛡 تمے الغاء ✔️ الكتمہٰٖ 🚷🚏👲🏻 ")
        elseif is_momod(msg) then
            mute_user(chat_id, user_id)
            send_large_msg(receiver, " ["..user_id.."] \n🛡 تمے 🚏 الكتمہٰٖ ☑️⭕️👲🏻 ")
        end
	end
end
-- End by reply actions

--By ID actions
local function cb_user_info(extra, success, result)
    local receiver = extra.receiver
    local user_id = result.peer_id
    local get_cmd = extra.get_cmd
    local data = load_data(_config.moderation.data)
    --[[if get_cmd == "setadmin" then
        local user_id = "user#id"..result.peer_id
        channel_set_admin(receiver, user_id, ok_cb, false)
        if result.username then
            text = "@"..result.username.." has been set as an admin"
        else
            text = "[ "..result.peer_id.." ] has been set as an admin"
        end
            send_large_msg(receiver, text)]]
    if get_cmd == "تنزيل اداري" then
		if is_admin2(result.peer_id) then
            return send_large_msg(receiver, "لہٰأ❌ تسہٰتطہٰيع تنہٰزيل الاداريہٰن 📛💲")
		end
		local user_id = "user#id"..result.peer_id
		channel_demote(receiver, user_id, ok_cb, false)
		if result.username then
            text = "🛡 تمے تنہٰٖزيلہٰٖك ❌ مہٰٖن الاداره 👮🏿🎐 👲🏻\n"..result.username.." \n"
            send_large_msg(receiver, text)
        else
            text = " [ "..result.peer_id.." ] \n🛡 تمے تنہٰٖزيلہٰٖك ❌ مہٰٖن الاداره 👮🏿🎐 👲🏻"
            send_large_msg(receiver, text)
        end
    elseif get_cmd == "رفع ادمن" then
        if result.username then
            member_username = "@"..result.username
        else
            member_username = string.gsub(result.print_name, '_', ' ')
        end
        promote2(receiver, member_username, user_id)
    elseif get_cmd == "تنزيل ادمن" then
        if result.username then
            member_username = "@"..result.username
        else
            member_username = string.gsub(result.print_name, '_', ' ')
        end
        demote2(receiver, member_username, user_id)
    end
end

-- Begin resolve username actions
local function callbackres(extra, success, result)
  local member_id = result.peer_id
  local member_username = "@"..result.username
  local get_cmd = extra.get_cmd
    if get_cmd == "الايدي" then
        local user = result.peer_id
        local name = string.gsub(result.print_name, "_", " ")
        local channel = 'channel#id'..extra.channelid
        send_large_msg(channel, user..'\n'..name)
        return user
    elseif get_cmd == "ايدي" then
        local user = result.peer_id
        local channel = 'channel#id'..extra.channelid
        send_large_msg(channel, user)
        return user
  elseif get_cmd == "invite" then
    local receiver = extra.channel
    local user_id = "user#id"..result.peer_id
    channel_invite(receiver, user_id, ok_cb, false)
    --[[elseif get_cmd == "channel_block" then
        local user_id = result.peer_id
        local channel_id = extra.channelid
    local sender = extra.sender
    if member_id == sender then
      return send_large_msg("channel#id"..channel_id, "Leave using kickme command")
    end
        if is_momod2(member_id, channel_id) and not is_admin2(sender) then
               return send_large_msg("channel#id"..channel_id, "You can't kick mods/owner/admins")
    end
    if is_admin2(member_id) then
         return send_large_msg("channel#id"..channel_id, "You can't kick other admins")
    end
        kick_user(user_id, channel_id)
    elseif get_cmd == "setadmin" then
        local user_id = "user#id"..result.peer_id
        local channel_id = extra.channel
        channel_set_admin(channel_id, user_id, ok_cb, false)
        if result.username then
            text = "@"..result.username.." has been set as an admin"
            send_large_msg(channel_id, text)
        else
            text = "@"..result.peer_id.." has been set as an admin"
            send_large_msg(channel_id, text)
        end
    elseif get_cmd == "setowner" then
        local receiver = extra.channel
        local channel = string.gsub(receiver, 'channel#id', '')
        local from_id = extra.from_id
        local group_owner = data[tostring(channel)]['set_owner']
        if group_owner then
            local user = "user#id"..group_owner
            if not is_admin2(group_owner) and not is_support(group_owner) then
                channel_demote(receiver, user, ok_cb, false)
            end
            local user_id = "user#id"..result.peer_id
            channel_set_admin(receiver, user_id, ok_cb, false)
            data[tostring(channel)]['set_owner'] = tostring(result.peer_id)
            save_data(_config.moderation.data, data)
            savelog(channel, name_log.." ["..from_id.."] set ["..result.peer_id.."] as owner by username")
        if result.username then
            text = member_username.." [ "..result.peer_id.." ] added as owner"
        else
            text = "[ "..result.peer_id.." ] added as owner"
        end
        send_large_msg(receiver, text)
  end]]
    elseif get_cmd == "رفع ادمن" then
        local receiver = extra.channel
        local user_id = result.peer_id
        --local user = "user#id"..result.peer_id
        promote2(receiver, member_username, user_id)
        --channel_set_mod(receiver, user, ok_cb, false)
    elseif get_cmd == "تنزيل ادمن" then
        local receiver = extra.channel
        local user_id = result.peer_id
        local user = "user#id"..result.peer_id
        demote2(receiver, member_username, user_id)
    elseif get_cmd == "تنزيل اداري" then
        local user_id = "user#id"..result.peer_id
        local channel_id = extra.channel
        if is_admin2(result.peer_id) then
            return send_large_msg(channel_id, "لہٰأ❌ تسہٰتطہٰيع تنہٰزيل الاداريہٰن 📛💲")
  end
        channel_demote(channel_id, user_id, ok_cb, false)
        if result.username then
            text = "[@"..result.username.."] \n🛡 تمے تنہٰٖزيلہٰٖك ❌ مہٰٖن الاداره 👮🏿🎐 👲🏻 "
            send_large_msg(channel_id, text)
        else
            text = "[ "..result.peer_id.." ] \n🛡 تمے تنہٰٖزيلہٰٖك ❌ مہٰٖن الاداره 👮🏿🎐 👲🏻  "
            send_large_msg(channel_id, text)
        end
        local receiver = extra.channel
        local user_id = result.peer_id
        demote_admin(receiver, member_username, user_id)
    elseif get_cmd == 'mute_user' then
        local user_id = result.peer_id
        local receiver = extra.receiver
        local chat_id = string.gsub(receiver, 'channel#id', '')
        if is_muted_user(chat_id, user_id) then
            unmute_user(chat_id, user_id)
            send_large_msg(receiver, " ["..user_id.."] \n🛡 تمے الغاء ✔️ الكتمہٰٖ 🚷🚏👲🏻")
        elseif is_momod(extra.msg) then
            mute_user(chat_id, user_id)
            send_large_msg(receiver, " ["..user_id.."] \n🛡 تمے 🚏 الكتمہٰٖ ☑️⭕️👲🏻 ")
        end
	end
end
--End resolve username actions

--Begin non-channel_invite username actions
local function in_channel_cb(cb_extra, success, result)
  local get_cmd = cb_extra.get_cmd
  local receiver = cb_extra.receiver
  local msg = cb_extra.msg
  local data = load_data(_config.moderation.data)
  local print_name = user_print_name(cb_extra.msg.from):gsub("‮", "")
  local name_log = print_name:gsub("_", " ")
  local member = cb_extra.username
  local memberid = cb_extra.user_id
  if member then
    text = 'لايوجد عضو @'..member..' في هذه المجموعه.'
  else
    text = 'لايوجد عضو  ['..memberid..'] في هذه المجموعه.'
  end
if get_cmd == "channel_block" then
  for k,v in pairs(result) do
    vusername = v.username
    vpeer_id = tostring(v.peer_id)
    if vusername == member or vpeer_id == memberid then
     local user_id = v.peer_id
     local channel_id = cb_extra.msg.to.id
     local sender = cb_extra.msg.from.id
      if user_id == sender then
        return send_large_msg("channel#id"..channel_id, "Leave using kickme command")
      end
      if is_momod2(user_id, channel_id) and not is_admin2(sender) then
        return send_large_msg("channel#id"..channel_id, "لہٰٱ تستہٰطہٰيع طہٰرد آلادمہٰن 🙊❤️")
      end
      if is_admin2(user_id) then
        return send_large_msg("channel#id"..channel_id, "لہٰٱ تسہتطہيع طہرد الاداري 🐸🌹 خلہيك ريلہكس 😌 لا تلہعب مال غيہرڪ 😒❤️")
      end
      if v.username then
        text = ""
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked: @"..v.username.." ["..v.peer_id.."]")
      else
        text = ""
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked: ["..v.peer_id.."]")
      end
      kick_user(user_id, channel_id)
      return
    end
  end
elseif get_cmd == "رفع اداري" then
   for k,v in pairs(result) do
    vusername = v.username
    vpeer_id = tostring(v.peer_id)
    if vusername == member or vpeer_id == memberid then
      local user_id = "user#id"..v.peer_id
      local channel_id = "channel#id"..cb_extra.msg.to.id
      channel_set_admin(channel_id, user_id, ok_cb, false)
      if v.username then
        text = "[@"..v.username.."] ["..v.peer_id.."] \nتـمـ☑️ رفـعـك ضـــمـــن الاداريــن👥"
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] set admin @"..v.username.." ["..v.peer_id.."]")
      else
        text = "["..v.peer_id.."] \nتـمـ☑️ رفـعـك ضـــمـــن الاداريــن👥"
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] set admin "..v.peer_id)
      end
      if v.username then
        member_username = "@"..v.username
      else
        member_username = string.gsub(v.print_name, '_', ' ')
      end
        local receiver = channel_id
        local user_id = v.peer_id
        promote_admin(receiver, member_username, user_id)

    end
    send_large_msg(channel_id, text)
    return
 end
 elseif get_cmd == 'رفع المدير' then
    for k,v in pairs(result) do
        vusername = v.username
        vpeer_id = tostring(v.peer_id)
        if vusername == member or vpeer_id == memberid then
            local channel = string.gsub(receiver, 'channel#id', '')
            local from_id = cb_extra.msg.from.id
            local group_owner = data[tostring(channel)]['set_owner']
            if group_owner then
                if not is_admin2(tonumber(group_owner)) and not is_support(tonumber(group_owner)) then
                    local user = "user#id"..group_owner
                    channel_demote(receiver, user, ok_cb, false)
                end
                    local user_id = "user#id"..v.peer_id
                    channel_set_admin(receiver, user_id, ok_cb, false)
                    data[tostring(channel)]['set_owner'] = tostring(v.peer_id)
                    save_data(_config.moderation.data, data)
                    savelog(channel, name_log.."["..from_id.."] set ["..v.peer_id.."] as owner by username")
				if result.username then
                	text = member_username.." [@"..v.username.."] \n🛡 تمے  رفعہٰٖك ✔️ مہٰٖديہٰٖر فہٰٖي المہٰٖجموعہٰٖةه 😻🕷 👲🏻 "
				else
					text =" [@"..v.username.."] \n🛡 تمے  رفعہٰٖك ✔️ مہٰٖديہٰٖر فہٰٖي المہٰٖجموعہٰٖةه 😻🕷 👲🏻"
				end
			end
        elseif memberid and vusername ~= member and vpeer_id ~= memberid then
            local channel = string.gsub(receiver, 'channel#id', '')
            local from_id = cb_extra.msg.from.id
            local group_owner = data[tostring(channel)]['set_owner']
            if group_owner then
                if not is_admin2(tonumber(group_owner)) and not is_support(tonumber(group_owner)) then
                    local user = "user#id"..group_owner
                    channel_demote(receiver, user, ok_cb, false)
                end
                data[tostring(channel)]['set_owner'] = tostring(memberid)
                save_data(_config.moderation.data, data)
                savelog(channel, name_log.."["..from_id.."] set ["..memberid.."] as owner by username")
				text = "["..memberid.."] \n🛡 تمے  رفعہٰٖك ✔️ مہٰٖديہٰٖر فہٰٖي المہٰٖجموعہٰٖةه 😻🕷 👲🏻 "
            end
        end
    end
 end
send_large_msg(receiver, text)
end
--End non-channel_invite username actions

--'Set supergroup photo' function
local function set_supergroup_photo(msg, success, result)
  local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)] then
      return
  end
  local receiver = get_receiver(msg)
  if success then
    local file = 'data/photos/channel_photo_'..msg.to.id..'.jpg'
    print('File downloaded to:', result)
    os.rename(result, file)
    print('File moved to:', file)
    channel_set_photo(receiver, file, ok_cb, false)
    data[tostring(msg.to.id)]['settings']['set_photo'] = file
    save_data(_config.moderation.data, data)
send_large_msg(receiver, 'اهلا وسهلا  😍\n '..msg.from.first_name..'\nتہٰم ✔️ ححـہٰـفظ آلصہٰــورۿﮧ 🙊💋', ok_cb, false)  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false)
  end
end

--Run function
local function run(msg, matches)
    if msg.to.type == 'chat' then
        if matches[1] == 'ترقيه سوبر' then
            if not is_admin1(msg) then
                return
            end
            local receiver = get_receiver(msg)
            chat_upgrade(receiver, ok_cb, false)
        end
    elseif msg.to.type == 'channel'then
        if matches[1] == 'ترقيه سوبر' then
            if not is_admin1(msg) then
                return
            end
            return "آلمہٰجہٰــمہٰوعۿﮧ🔰خہٰآرقہٰۿﮧ #لتلح ⁉️"
        end
    end
    if msg.to.type == 'channel' then
    local support_id = msg.from.id
    local receiver = get_receiver(msg)
    local print_name = user_print_name(msg.from):gsub("‮", "")
    local name_log = print_name:gsub("_", " ")
    local data = load_data(_config.moderation.data)
        if matches[1] == 'تفعيل' and not matches[2] then
            if not is_admin1(msg) and not is_support(support_id) then
                return
            end
            if is_super_group(msg) then
                return reply_msg(msg.id, ' 🛡 بِأّلَتّأّګيِّدِ تّمَ تفہٰٖعيل ✔️ الہٰٖبوت فہٰٖي المہٰٖجموعہٰٖةه 😻🎐 ', ok_cb, false)
            end
            print("SuperGroup "..msg.to.print_name.."("..msg.to.id..") added")
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] added SuperGroup")
            superadd(msg)
            set_mutes(msg.to.id)
            channel_set_admin(receiver, 'user#id'..msg.from.id, ok_cb, false)
        end

        if matches[1] == 'تعطيل' and is_admin1(msg) and not matches[2] then            if not is_super_group(msg) then
                return reply_msg(msg.id, ' 🛡 بِأّلَتّأّګيِّدِ تّمَ تعہٰٖطيل ❌ الہٰٖبوت فہٰٖي المہٰٖجموعہٰٖةه 🙀🚏 ', ok_cb, false)
            end
            print("SuperGroup "..msg.to.print_name.."("..msg.to.id..") removed")
            superrem(msg)
            rem_mutes(msg.to.id)
        end

        if not data[tostring(msg.to.id)] then
            return
        end
        if matches[1] == "معلومات المجموعه" then
            if not is_owner(msg) then
                return
            end
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup info")
            channel_info(receiver, callback_info, {receiver = receiver, msg = msg})
        end

        if matches[1] == "الاداريين" then
            if not is_owner(msg) and not is_support(msg.from.id) then
                return
            end
            member_type = 'قہٰآئہٰمہٰة آلآدآريہٰيہٰن 🌝🆔'
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup Admins list")
            admins = channel_get_admins(receiver,callback, {receiver = receiver, msg = msg, member_type = member_type})
        end

        if matches[1] == "مدير المجموعه" then
            local group_owner = data[tostring(msg.to.id)]['set_owner']
            if not group_owner then
            return "مہٰديہٰر آلہٰكہٰروبہٰ 💋🙊 آلہٰصہٰآك"
            end
			savelog(msg.to.id, name_log.." ["..msg.from.id.."] used /owner")
            return "لہٰٱ يہٰوجہٰد مہٰديہٰر⁉️للمہٰجــمہٰوعہٰۿﮧ ☹️☝️\n["..group_owner..']'
        		end

        if matches[1] == "الادمنيه" then
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group modlist")
            return modlist(msg)
            -- channel_get_admins(receiver,callback, {receiver = receiver})
        end

        if matches[1] == "كشف بوت" and is_momod(msg) then
            member_type = 'تہٰم✔️ كشہٰف عہٰن وجہٰود⚠️ آلبہٰوتہٰات فہٰي المہٰجمہٰوعہٰۿﮧ 🚸💯'
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup bots list")
            channel_get_bots(receiver, callback, {receiver = receiver, msg = msg, member_type = member_type})
        end

        if matches[1] == "ايدي الاعضاء" and not matches[2] and is_momod(msg) then
            local user_id = msg.from.peer_id
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup users list")
            channel_get_users(receiver, callback_who, {receiver = receiver})
        end

        if matches[1] == "kicked" and is_momod(msg) then
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested Kicked users list")
            channel_get_kicked(receiver, callback_kicked, {receiver = receiver})
        end

        if matches[1] == 'احذف' and is_momod(msg) then
            if type(msg.reply_id) ~= "nil" then
                local cbreply_extra = {
                    get_cmd = 'احذف',
                    msg = msg
                }
                delete_msg(msg.id, ok_cb, false)
                get_message(msg.reply_id, get_message_callback, cbreply_extra)
            end
        end

        if matches[1] == 'بلوك' and is_momod(msg) then
            if type(msg.reply_id) ~= "nil" then
                local cbreply_extra = {
                    get_cmd = 'channel_block',
                    msg = msg
                }
                get_message(msg.reply_id, get_message_callback, cbreply_extra)
            elseif matches[1] == 'بلوك' and string.match(matches[2], '^%d+$') then
                --[[local user_id = matches[2]
                local channel_id = msg.to.id
                if is_momod2(user_id, channel_id) and not is_admin2(user_id) then
                    return send_large_msg(receiver, "You can't kick mods/owner/admins")
                end
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked: [ user#id"..user_id.." ]")
                kick_user(user_id, channel_id)]]
                local    get_cmd = 'channel_block'
                local    msg = msg
                local user_id = matches[2]
                channel_get_users (receiver, in_channel_cb, {get_cmd=get_cmd, receiver=receiver, msg=msg, user_id=user_id})
            elseif msg.text:match("@[%a%d]") then
            --[[local cbres_extra = {
                    channelid = msg.to.id,
                    get_cmd = 'channel_block',
                    sender = msg.from.id
                }
                local username = matches[2]
                local username = string.gsub(matches[2], '@', '')
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked: @"..username)
                resolve_username(username, callbackres, cbres_extra)]]
            local get_cmd = 'channel_block'
            local msg = msg
            local username = matches[2]
            local username = string.gsub(matches[2], '@', '')
            channel_get_users (receiver, in_channel_cb, {get_cmd=get_cmd, receiver=receiver, msg=msg, username=username})
            end
        end
        if matches[1] == 'ايدي' then
            if type(msg.reply_id) ~= "nil" and is_momod(msg) and not matches[2] then
                local cbreply_extra = {
                    get_cmd = 'ايدي',
                    msg = msg
                }
                get_message(msg.reply_id, get_message_callback, cbreply_extra)
            elseif type(msg.reply_id) ~= "nil" and matches[2] == "from" and is_momod(msg) then
                local cbreply_extra = {
                    get_cmd = 'idfrom',
                    msg = msg
                }
                get_message(msg.reply_id, get_message_callback, cbreply_extra)
            elseif msg.text:match("@[%a%d]") then
                local cbres_extra = {
                    channelid = msg.to.id,
                    get_cmd = 'ايدي'
                }
                local username = matches[2]
                local username = username:gsub("@","")
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested ID for: @"..username)
                resolve_username(username,  callbackres, cbres_extra)
            else
savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup ID")
                return "|📝| آسـہٰمـ آلـمـہٰجـہٰمـوعۿﮧ🌝 |\n"..string.gsub(msg.to.print_name, "_", " ").."\n|♋️| آيـہٰديـ آلـمہٰـجـہٰمـوعۿﮧ🐸 |\n"..msg.to.id.."\n|⬅️| آسہٰــمـہٰـك 🙊|  \n"..msg.from.first_name.."\n"   .."|↔️| مـعـہٰرفـہٰك😒 | \n(@"..(msg.from.username or "لا يوجد")..")\n"
            end
        end

        if matches[1] == 'زحلكني' then
            if msg.to.type == 'channel' then
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] left via kickme")
                channel_kick("channel#id"..msg.to.id, "user#id"..msg.from.id, ok_cb, false)
            end
        end

        if matches[1] == 'تغير الرابط' and is_momod(msg)then
            local function callback_link (extra , success, result)
            local receiver = get_receiver(msg)
                if success == 0 then
                    send_large_msg(receiver, 'لا يمہٰكنك تغہٰيير الرابہٰط \nالمہٰجمہٰوعه ليہٰسہٰت مہٰن صہٰنع 🤖📌 البہٰوت')
                    data[tostring(msg.to.id)]['settings']['set_link'] = nil
                    save_data(_config.moderation.data, data)
                else
                send_large_msg(receiver, 'اهلا وسهلا بك 😻❤️\n '..msg.from.first_name..'\n🛡 تہٰم 👍🏻 تہٰغہٰييہٰر  📝 آلہٰرآبہٰط  💋🙊')
                    data[tostring(msg.to.id)]['settings']['set_link'] = result
                    save_data(_config.moderation.data, data)
                end
            end
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] attempted to create a new SuperGroup link")
            export_channel_link(receiver, callback_link, false)
        end

        if matches[1] == 'ضع رابط' and is_owner(msg) then
            data[tostring(msg.to.id)]['settings']['set_link'] = 'waiting'
            save_data(_config.moderation.data, data)
            return 'اهلا وسهلا بك 😻❤️\n '..msg.from.first_name..'\nآرسہٰل ✔️ لہٰہٰي الہٰرابہٰط  ألَأّنِ⁉️🌝'
        end

        if msg.text then
            if msg.text:match("^(https://telegram.me/joinchat/%S+)$") and data[tostring(msg.to.id)]['settings']['set_link'] == 'waiting' and is_owner(msg) then
                data[tostring(msg.to.id)]['settings']['set_link'] = msg.text
                save_data(_config.moderation.data, data)
            return 'اهلا وسهلا بك 😻❤️\n '..msg.from.first_name..'\n🛡 تہٰم 👍🏻 تہغہٰييہٰر  📝 آلہٰرآبہٰط  💋🙊 '
            end
        end

        if matches[1] == 'الرابط' then
            if not is_momod(msg) then
                return
            end
            local group_link = data[tostring(msg.to.id)]['settings']['set_link']
            if not group_link then
            return "🛡 يہٰرجہٰئ آرسہٰآلہٰ 📌تہٰغہٰييہٰر 📎 آلہٰرآبہٰط ⚠️" 
            end
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group link ["..group_link.."]")
            return 'اهلا وسهلا بك 😻❤️\n '..msg.from.first_name..'\nرآبہٰط ⁉️ آلہٰمہٰجہٰمہٰوعہٰةة 😿💔 \n'..group_link
        end
        
        if matches[1] == "invite" and is_sudo(msg) then
            local cbres_extra = {
                channel = get_receiver(msg),
                get_cmd = "invite"
            }
            local username = matches[2]
            local username = username:gsub("@","")
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] invited @"..username)
            resolve_username(username,  callbackres, cbres_extra)
        end

        if matches[1] == 'الايدي' and is_owner(msg) then
            local cbres_extra = {
                channelid = msg.to.id,
                get_cmd = 'الايدي'
            }
            local username = matches[2]
            local username = username:gsub("@","")
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] resolved username: @"..username)
            resolve_username(username,  callbackres, cbres_extra)
        end

        --[[if matches[1] == 'kick' and is_momod(msg) then
            local receiver = channel..matches[3]
            local user = "user#id"..matches[2]
            chaannel_kick(receiver, user, ok_cb, false)
        end]]

            if matches[1] == 'رفع اداري' then
                if not is_support(msg.from.id) and not is_owner(msg) then
                    return
                end
            if type(msg.reply_id) ~= "nil" then
                local cbreply_extra = {
                    get_cmd = 'رفع اداري',
                    msg = msg
                }
                setadmin = get_message(msg.reply_id, get_message_callback, cbreply_extra)
            elseif matches[1] == 'رفع اداري' and string.match(matches[2], '^%d+$') then
            --[[]    local receiver = get_receiver(msg)
                local user_id = "user#id"..matches[2]
                local get_cmd = 'setadmin'
                user_info(user_id, cb_user_info, {receiver = receiver, get_cmd = get_cmd})]]
                local    get_cmd = 'رفع اداري'
                local    msg = msg
                local user_id = matches[2]
                channel_get_users (receiver, in_channel_cb, {get_cmd=get_cmd, receiver=receiver, msg=msg, user_id=user_id})
            elseif matches[1] == 'رفع اداري' and not string.match(matches[2], '^%d+$') then
                --[[local cbres_extra = {
                    channel = get_receiver(msg),
                    get_cmd = 'setadmin'
                }
                local username = matches[2]
                local username = string.gsub(matches[2], '@', '')
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] set admin @"..username)
                resolve_username(username, callbackres, cbres_extra)]]
                local    get_cmd = 'رفع اداري'
                local    msg = msg
                local username = matches[2]
                local username = string.gsub(matches[2], '@', '')
                channel_get_users (receiver, in_channel_cb, {get_cmd=get_cmd, receiver=receiver, msg=msg, username=username})
            end
        end

        if matches[1] == 'تنزيل اداري' then
            if not is_support(msg.from.id) and not is_owner(msg) then
                return
            end
            if type(msg.reply_id) ~= "nil" then
                local cbreply_extra = {
                    get_cmd = 'تنزيل اداري',
                    msg = msg
                }
                demoteadmin = get_message(msg.reply_id, get_message_callback, cbreply_extra)
            elseif matches[1] == 'تنزيل اداري' and string.match(matches[2], '^%d+$') then
                local receiver = get_receiver(msg)
                local user_id = "user#id"..matches[2]
                local get_cmd = 'تنزيل اداري'
                user_info(user_id, cb_user_info, {receiver = receiver, get_cmd = get_cmd})
            elseif matches[1] == 'تنزيل اداري' and not string.match(matches[2], '^%d+$') then
                local cbres_extra = {
                    channel = get_receiver(msg),
                    get_cmd = 'تنزيل اداري'
                }
                local username = matches[2]
                local username = string.gsub(matches[2], '@', '')
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] demoted admin @"..username)
                resolve_username(username, callbackres, cbres_extra)
            end
        end

        if matches[1] == 'رفع المدير' and is_owner(msg) then
            if type(msg.reply_id) ~= "nil" then
                local cbreply_extra = {
                    get_cmd = 'رفع المدير',
                    msg = msg
                }
                setowner = get_message(msg.reply_id, get_message_callback, cbreply_extra)
            elseif matches[1] == 'رفع المدير' and string.match(matches[2], '^%d+$') then
        --[[    local group_owner = data[tostring(msg.to.id)]['set_owner']
                if group_owner then
                    local receiver = get_receiver(msg)
                    local user_id = "user#id"..group_owner
                    if not is_admin2(group_owner) and not is_support(group_owner) then
                        channel_demote(receiver, user_id, ok_cb, false)
                    end
                    local user = "user#id"..matches[2]
                    channel_set_admin(receiver, user, ok_cb, false)
                    data[tostring(msg.to.id)]['set_owner'] = tostring(matches[2])
                    save_data(_config.moderation.data, data)
                    savelog(msg.to.id, name_log.." ["..msg.from.id.."] set ["..matches[2].."] as owner")
                    local text = "[ "..matches[2].." ] added as owner"
                    return text
                end]]
                local    get_cmd = 'رفع المدير'
                local    msg = msg
                local user_id = matches[2]
                channel_get_users (receiver, in_channel_cb, {get_cmd=get_cmd, receiver=receiver, msg=msg, user_id=user_id})
            elseif matches[1] == 'رفع المدير' and not string.match(matches[2], '^%d+$') then
                local    get_cmd = 'رفع المدير'
                local    msg = msg
                local username = matches[2]
                local username = string.gsub(matches[2], '@', '')
                channel_get_users (receiver, in_channel_cb, {get_cmd=get_cmd, receiver=receiver, msg=msg, username=username})
            end
        end

        if matches[1] == 'رفع ادمن' then
          if not is_momod(msg) then
                return
            end
            if not is_owner(msg) then 
                return 'اهلا وسهلا بك 😻❤️\n '..msg.from.first_name..'\n  🙊💋هِـہٰٖذا الامہٰٖہٰٖر 😐 للہٰٖمہٰٖديہٰٖر #فہٰٖقہٰٖط'
           end
            if type(msg.reply_id) ~= "nil" then
                local cbreply_extra = {
                    get_cmd = 'رفع ادمن',
                    msg = msg
                }
                promote = get_message(msg.reply_id, get_message_callback, cbreply_extra)
            elseif matches[1] == 'رفع ادمن' and string.match(matches[2], '^%d+$') then
                local receiver = get_receiver(msg)
                local user_id = "user#id"..matches[2]
                local get_cmd = 'رفع ادمن'
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] promoted user#id"..matches[2])
                user_info(user_id, cb_user_info, {receiver = receiver, get_cmd = get_cmd})
            elseif matches[1] == 'رفع ادمن' and not string.match(matches[2], '^%d+$') then
                local cbres_extra = {
                    channel = get_receiver(msg),
                    get_cmd = 'رفع ادمن',
                }
                local username = matches[2]
                local username = string.gsub(matches[2], '@', '')
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] promoted @"..username)
                return resolve_username(username, callbackres, cbres_extra)
            end
        end

        if matches[1] == 'mp' and is_sudo(msg) then
            channel = get_receiver(msg)
            user_id = 'user#id'..matches[2]
            channel_set_mod(channel, user_id, ok_cb, false)
            return "ok"
        end
        if matches[1] == 'md' and is_sudo(msg) then
            channel = get_receiver(msg)
            user_id = 'user#id'..matches[2]
            channel_demote(channel, user_id, ok_cb, false)
            return "ok"
        end

        if matches[1] == 'تنزيل ادمن' then
            if not is_momod(msg) then
                return
            end
            if not is_owner(msg) then 
                return 'اهلا وسهلا بك 😻❤️\n '..msg.from.first_name..'\n  🙊💋هِـہٰٖذا الامہٰٖہٰٖر 😐 للہٰٖمہٰٖديہٰٖر #فہٰٖقہٰٖط'
            end 
            if type(msg.reply_id) ~= "nil" then
                local cbreply_extra = {
                    get_cmd = 'تنزيل ادمن',
                    msg = msg
                }
                demote = get_message(msg.reply_id, get_message_callback, cbreply_extra)
            elseif matches[1] == 'تنزيل ادمن' and string.match(matches[2], '^%d+$') then
                local receiver = get_receiver(msg)
                local user_id = "user#id"..matches[2]
                local get_cmd = 'تنزيل ادمن'
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] demoted user#id"..matches[2])
                user_info(user_id, cb_user_info, {receiver = receiver, get_cmd = get_cmd})
            elseif not string.match(matches[2], '^%d+$') then
                local cbres_extra = {
                    channel = get_receiver(msg),
                    get_cmd = 'تنزيل ادمن'
                }
                local username = matches[2]
                local username = string.gsub(matches[2], '@', '')
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] demoted @"..username)
                return resolve_username(username, callbackres, cbres_extra)
            end
        end

        if matches[1] == "ضع اسم" and is_momod(msg) then
            local receiver = get_receiver(msg)
            local set_name = string.gsub(matches[2], '_', '')
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] renamed SuperGroup to: "..matches[2])
            rename_channel(receiver, set_name, ok_cb, false)
        end

        if msg.service and msg.action.type == 'chat_rename' then
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] renamed SuperGroup to: "..msg.to.title)
            data[tostring(msg.to.id)]['settings']['set_name'] = msg.to.title
            save_data(_config.moderation.data, data)
        end

        if matches[1] == "ضع وصف" and is_momod(msg) then
            local receiver = get_receiver(msg)
            local about_text = matches[2]
            local data_cat = 'description'
            local target = msg.to.id
            data[tostring(target)][data_cat] = about_text
            save_data(_config.moderation.data, data)
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup description to: "..about_text)
            channel_set_about(receiver, about_text, ok_cb, false)
            return "تہٰمَ ✔️ حہٰفظّ ألہٰوِصہٰفِّ 📝\n\n"
        end

        if matches[1] == "ضع معرف" and is_admin1(msg) then
            local function ok_username_cb (extra, success, result)
                local receiver = extra.receiver
                if success == 1 then
                 send_large_msg(receiver, "تہٰمَ ✔️ وضہٰع مَعہٰرفِّ 🌀🏃🏿 للَمہٰجمَہٰوِعهِ\n\n")
                elseif success == 0 then
                    send_large_msg(receiver, "لہٰم يہٰتمَ 🚫 وضہٰع مَعہٰرفِّ 🌀🏃🏿 للَمہٰجمَہٰوِعه")
                end
      end

            local username = string.gsub(matches[2], '@', '')
            channel_set_username(receiver, username, ok_username_cb, {receiver=receiver})
        end

        if matches[1] == 'ضع قوانين' and is_momod(msg) then
            rules = matches[2]
            local target = msg.to.id
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] has changed group rules to ["..matches[2].."]")
            return set_rulesmod(msg, data, target)
        end

        if msg.media then
            if msg.media.type == 'photo' and data[tostring(msg.to.id)]['settings']['set_photo'] == 'waiting' and is_momod(msg) then
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] set new SuperGroup photo")
                load_photo(msg.id, set_supergroup_photo, msg)
                return
            end
        end
        if matches[1] == 'ضع صوره' and is_momod(msg) then
            data[tostring(msg.to.id)]['settings']['set_photo'] = 'waiting'
            save_data(_config.moderation.data, data)
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] started setting new SuperGroup photo")
       return 'اهلا وسهلا بك 😻❤️\n '..msg.from.first_name..'\nآرسہٰل 👍🏻 لہٰيے 🙊 صہٰورة 📷  الأنہٰآرسہٰل 👍🏻 لہٰيے 🙊 صہٰورة 📷  الأنہٰ'
        end
        if matches[1] == 'مسح' then
            if not is_momod(msg) then
                return
            end
            if not is_owner(msg) then 
                return 'هيوووووووو😒\n '..msg.from.first_name..'\nهِہٰذّأّ  أّلامہٰر للہٰمہٰدير فہٰقہٰط 🤖📌'
            end
            if matches[2] == 'الادمنيه' then
                if next(data[tostring(msg.to.id)]['moderators']) == nil then
                    return 'لَہٰمَ يتہٰمَ مسہٰحٌهِمَ لَأّنِہٰهِ لَأ يِّوِجِہٰدِ أّدِمنہٰيه 😹🎈'
                end
                for k,v in pairs(data[tostring(msg.to.id)]['moderators']) do
                    data[tostring(msg.to.id)]['moderators'][tostring(k)] = nil
                    save_data(_config.moderation.data, data)
                end
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] cleaned modlist")
                return 'تہٰمَ ✔️مسہٰحٌ جِمَيہٰع أّلَأدِمَنِہٰيه 😹🎈'
            end
            if matches[2] == 'القوانين' then
                local data_cat = 'rules'
                if data[tostring(msg.to.id)][data_cat] == nil then
                    return "لَہٰمَ يتہٰمَ مسہٰحٌهِمَ لَأّنِہٰهِ لَأ يِّوِجِہٰدِ قوانين 😹🎈"
                end
                data[tostring(msg.to.id)][data_cat] = nil
                save_data(_config.moderation.data, data)
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] cleaned rules")
                return 'تہٰمَ ✔️ حہٰذف القہٰوانيہٰن 🤖📌'
            end
            if matches[2] == 'الوصف' then
                local receiver = get_receiver(msg)
                local about_text = ''
                local data_cat = 'description'
                if data[tostring(msg.to.id)][data_cat] == nil then
                    return "لَأّ يہٰوجہٰد وصہٰف لَيہٰتمَ مہٰسہٰحه 🌝🌸"
                end
                data[tostring(msg.to.id)][data_cat] = nil
                save_data(_config.moderation.data, data)
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] cleaned about")
                channel_set_about(receiver, about_text, ok_cb, false)
                return 'تہٰمَ ✔️ مسہٰحٌ أّلَہٰوصہٰف 👍🏿😒'
            end
            if matches[2] == 'المكتومين' then
                chat_id = msg.to.id
                local hash =  'mute_user:'..chat_id
                    redis:del(hash)
                return 'تہٰمَ ✔️ تنہٰظيہٰف قائہٰمه المہٰكتوميہٰن 😹🏃🏿'
            end
            if matches[2] == 'المعرف' and is_admin1(msg) then
                local function ok_username_cb (extra, success, result)
                    local receiver = extra.receiver
                    if success == 1 then
                        send_large_msg(receiver, "تہٰمَ ✔️مسہٰحٌ أّلہٰمہٰعرف 🌀🏃🏿")
                    elseif success == 0 then
                        send_large_msg(receiver, "لَہٰمَ يتہٰمَ مسہٰحٌ أّلہٰمہٰعرف 🌀😹🎈")
                    end
				end
                local username = ""
                channel_set_username(receiver, username, ok_username_cb, {receiver=receiver})
            end
        end

        if matches[1] == 'قفل' and is_momod(msg) then
            local target = msg.to.id
            if matches[2] == 'الروابط' then
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked link posting ")
                return lock_group_links(msg, data, target)
            end
            if matches[2] == 'الكلايش' then
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked spam ")
                return lock_group_spam(msg, data, target)
            end
            if matches[2] == 'التكرار' then
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked flood ")
                return lock_group_flood(msg, data, target)
            end
            if matches[2] == 'العربيه' then
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked arabic ")
                return lock_group_arabic(msg, data, target)
            end
            if matches[2] == 'الاضافه' then
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked member ")
                return lock_group_membermod(msg, data, target)
            end
            if matches[2]:lower() == 'الاضافه الجماعيه' then
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked rtl chars. in names")
                return lock_group_rtl(msg, data, target)
            end
            if matches[2] == 'الملصقات' then
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked sticker posting")
                return lock_group_sticker(msg, data, target)
            end
            if matches[2] == 'جهات الاتصال' then
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked contact posting")
                return lock_group_contacts(msg, data, target)
            end
            if matches[2] == 'الطرد' then
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked enabled strict settings")
                return enable_strict_rules(msg, data, target)
            end
	      		if matches[2] == 'المعرف' then
				        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked username")
				        return lock_group_username(msg, data, target)
			      end
			   		if matches[2] == 'السمايل' then
			        	savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked emoji")
		         		return lock_group_emoji(msg, data, target)
		      	end
		    		if matches[2] == 'التاك' then
			        	savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked tag ")
			        	return lock_group_tag(msg, data, target)
      			end			
     		  	if matches[2] == 'اعاده توجيه' then
			         	savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked fwd")
			        	return lock_group_fwd(msg, data, target)
	       		end
     		  	if matches[2] == 'الشارحه' then
			         	savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked cmd")
			        	return lock_group_cmd(msg, data, target)
	       		end
     		  	if matches[2] == 'الانلاين' then
			         	savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked unsupported")
			        	return lock_group_unsupported(msg, data, target)
	       		end
		      	if matches[2] == 'البوتات' then
			        	savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked bots")
			         	return lock_group_bots(msg, data, target)
			      end
	      		if matches[2] == 'الدخول بالرابط' then
				        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked join ")
				        return lock_group_join(msg, data, target)
			      end
	      		if matches[2] == 'الاشعارات' then
			        	savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked Tgservice Actions")
		        		return lock_group_tgservice(msg, data, target)
	      		end
	      		if matches[2] == 'جميع الروابط' then
				        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked ads ")
				        return lock_group_ads(msg, data, target)
			      end
           end

        if matches[1] == 'فتح' and is_momod(msg) then
            local target = msg.to.id
            if matches[2] == 'الروابط' then
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked link posting")
                return unlock_group_links(msg, data, target)
            end
            if matches[2] == 'الكلايش' then
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked spam")
                return unlock_group_spam(msg, data, target)
            end
            if matches[2] == 'التكرار' then
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked flood")
                return unlock_group_flood(msg, data, target)
            end
            if matches[2] == 'العربيه' then
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked Arabic")
                return unlock_group_arabic(msg, data, target)
            end
            if matches[2] == 'الاضافه' then
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked member ")
                return unlock_group_membermod(msg, data, target)
            end
            if matches[2]:lower() == 'الاضافه الجماعيه' then
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked RTL chars. in names")
                return unlock_group_rtl(msg, data, target)
            end
            if matches[2] == 'الملصقات' then
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked sticker posting")
                return unlock_group_sticker(msg, data, target)
            end
            if matches[2] == 'جهات الاتصال' then
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked contact posting")
                return unlock_group_contacts(msg, data, target)
            end
            if matches[2] == 'الطرد' then
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked disabled strict settings")
                return disable_strict_rules(msg, data, target)
            end
       			if matches[2] == 'المعرف' then
			        	savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked disabled username")
			         	return unlock_group_username(msg, data, target)
			      end
      			if matches[2] == 'السمايل' then
	        			savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked disabled emoji")
	        			return unlock_group_emoji(msg, data, target)
	      		end
	     			if matches[2] == 'التاك' then
			        	savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked tag")
		        		return unlock_group_tag(msg, data, target)
		      	end	
		      	if matches[2] == 'اعاده توجيه' then
			         	savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked fwd")
		        		return unlock_group_fwd(msg, data, target)
		      	end
		      	if matches[2] == 'الشارحه' then
			         	savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked cmd")
		        		return unlock_group_cmd(msg, data, target)
		      	end
		      	if matches[2] == 'الانلاين' then
			         	savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked unsupported")
		        		return unlock_group_unsupported(msg, data, target)
		      	end
    		  	if matches[2] == 'البوتات' then
			         	savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked bots")
			        	return unlock_group_bots(msg, data, target)
			      end
	      		if matches[2] == 'الدخول بالرابط' then
				        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked join")
				        return unlock_group_join(msg, data, target)
			      end
		        if matches[2] == 'الاشعارات' then
				       savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked tgservice actions")
				       return unlock_group_tgservice(msg, data, target)
			      end
	      		if matches[2] == 'جميع الروابط' then
				        savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked ads")
				        return unlock_group_ads(msg, data, target)
			      end
        end

        if matches[1] == 'ضع تكرار' then
            if not is_momod(msg) then
                return
            end
            if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 30 then
              return 'هلا حياتي 😍❤️\n '..msg.from.first_name..'\n🛡 ضہٰع آلہٰتہٰكہٰرآر مہٰن 5 أّلَى 20 ✔️'
         end   
           local flood_max = matches[2]
            data[tostring(msg.to.id)]['settings']['flood_msg_max'] = flood_max
            save_data(_config.moderation.data, data)
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] set flood to ["..matches[2].."]")
            return 'تہٰم 👍🏻 تہٰعيہٰيہٰن آلہٰتہٰكہٰرآر 🚫 آلہٰعہٰدد ⬅️: \n👇\n'..matches[2]
        end
        if matches[1] == 'المراقبه' and is_momod(msg) then
            local target = msg.to.id
            if matches[2] == 'نعم' then
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] set group to: public")
                return set_public_membermod(msg, data, target)
            end
            if matches[2] == 'لا' then
                savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: not public")
                return unset_public_membermod(msg, data, target)
            end
        end

if matches[1] == 'قفل' and is_momod(msg) then
   local chat_id = msg.to.id
   if matches[2] == 'الصوت' then
   local msg_type = 'Audio'
    if not is_muted(chat_id, msg_type..': yes') then
     savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type)
     mute(chat_id, msg_type)
    return 'تمے قفل الصــہٰٰـــوت ⭕️🔐 \n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                else
    return '🛡بالتأكيد تمے قفل🔐 الصــہٰٰـــوت🔇  \n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                end
   end
   if matches[2] == 'الصور' then
   local msg_type = 'Photo'
    if not is_muted(chat_id, msg_type..': yes') then
     savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type)
     mute(chat_id, msg_type)
    return '🛡تمے قفل🔐 الصــہٰٰـــور ⭕️🤖 \n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                else
    return '🛡بالتأكيد تمے قفل🔐 الصــہٰٰـــور ⭕️🤖  \n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                end
   end
   if matches[2] == 'الفيديو' then
  			local msg_type = 'Video'
				if not is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type)
					mute(chat_id, msg_type)
    return 'تمے قفل🔐🎬 الفـہٰٰديـہٰٰو⭕️🤖  \n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                else
    return '🛡بالتأكيد تمے قفل🔐🎬 الفـہٰٰديـہٰٰو⭕️🤖 \n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                end
			end
			if matches[2] == 'المتحركه' then
			local msg_type = 'Gifs'
				if not is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type)
					mute(chat_id, msg_type)
    return 'تمے قفل🔐🔲المـہٰٰـتحـہٰٰـركه⭕️ \n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                else
    return 'بالتأكيد تمے قفل🔐🔲المـہٰٰـتحـہٰٰـركه ⭕️🤖 \n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                end
            end
			if matches[2] == 'الفايلات' then
			local msg_type = 'Documents'
				if not is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type)
					mute(chat_id, msg_type)
    return 'تمے قفل🔒🗃الہٰفہٰايہٰلات📎\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                else
    return '🛡بالتأكيد تمے قفل 🔐🗂 الہٰفہٰايہٰلات📎 \n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                end
            end
			if matches[2] == 'الدردشه' then
			local msg_type = 'Text'
				if not is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type)
					mute(chat_id, msg_type)
    return '😈تہٰم قہٰفہٰل 🔒آلہٰدردشہٰه ✅🇮🇶\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                else
    return '��بالتأكيد تمے قفل🔒 آلہٰدردشہٰه☠☝️\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                end
            end
			if matches[2] == 'المجموعه' then
			local msg_type = 'All'
				if not is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type)
					mute(chat_id, msg_type)
    return 'تمے قفل🔒آلہمٰجمہٰوعہٰۿﮧ 😽☝️  \n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                else
    return '🛡بالتأكيد تمے قفل🔒آلہمٰجمہٰوعہٰۿﮧ 😽☝️\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                end
            end
        end
		if matches[1] == 'فتح' and is_momod(msg) then
			local chat_id = msg.to.id
			if matches[2] == 'الصوت' then
			local msg_type = 'Audio'
				if is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute "..msg_type)
					unmute(chat_id, msg_type)
    return 'تمے فتح ✔️ الصــہٰٰـــوت 🎵↪️ \n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                else
    return '🛡بالتأكيد تمے فتح ✔️ الصــہٰٰـــوت 🎵↪️\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                end
            end
			if matches[2] == 'الصور' then
			local msg_type = 'Photo'
				if is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute "..msg_type)
					unmute(chat_id, msg_type)
    return 'تمے ✔️ فتح الصـہٰـٰہٰٰـور 🏖  \n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                else
    return '🛡بالتأكيد تمے ✔️ فتح الصــہٰٰـــور 🏖   \n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                end
            end
			if matches[2] == 'الفيديو' then
			local msg_type = 'Video'
				if is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute "..msg_type)
					unmute(chat_id, msg_type)
    return 'تمے فتح ✔️🎬 الفديہٰٖو🎐🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                else
    return '🛡بالتأكيد تمے فتح ✔️🎬 الفديہٰٖو🎐🤖\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                end
            end
			if matches[2] == 'المتحركه' then
			local msg_type = 'Gifs'
				if is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute "..msg_type)
					unmute(chat_id, msg_type)
    return 'تمے فتح✔️🔲 المـہٰٰـتحـہٰٰـركه⭕️\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                else
    return '🛡بالتأكيد تمے فتح✔️🔲 المـہٰٰـتحـہٰٰـركه⭕️\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                end
            end
			if matches[2] == 'الفايلات' then
			local msg_type = 'Documents'
				if is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute "..msg_type)
					unmute(chat_id, msg_type)
    return 'تمے فتح ✔️🗃الہٰفہٰايہٰلات📎\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                else
    return '🛡بالتأكيد تمے فتح ✔️🗃الہٰفہٰايہٰلات📎\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                end
            end
			if matches[2] == 'الدردشه' then
			local msg_type = 'Text'
				if is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute message")
					unmute(chat_id, msg_type)
    return 'تمے فتح ✔️ آلہٰدردشہٰه 😎☝️\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                else
    return '🛡بالتأكيد تمے فتح ✔️ آلہٰدردشہٰه😎☝️\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                end
            end
			if matches[2] == 'المجموعه' then
			local msg_type = 'All'
				if is_muted(chat_id, msg_type..': yes') then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute "..msg_type)
					unmute(chat_id, msg_type)
    return 'تمے فتح ✔️ آلہمٰجمہٰوعہٰۿﮧ 😽☝️\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                else
    return '🛡بالتأكيد تمے فتح ✔️ آلہمٰجمہٰوعہٰۿﮧ 😽☝️\n👲🏻#بواسطه (@'..(msg.from.username or 'لا يوجد')..')\n'
                end
			end
		end


        if matches[1] == "كتم" and is_momod(msg) then
            local chat_id = msg.to.id
            local hash = "mute_user"..chat_id
            local user_id = ""
            if type(msg.reply_id) ~= "nil" then
                local receiver = get_receiver(msg)
                local get_cmd = "mute_user"
                muteuser = get_message(msg.reply_id, get_message_callback, {receiver = receiver, get_cmd = get_cmd, msg = msg})
            elseif matches[1] == "كتم" and string.match(matches[2], '^%d+$') then
                local user_id = matches[2]
                if is_muted_user(chat_id, user_id) then
                    unmute_user(chat_id, user_id)
                    savelog(msg.to.id, name_log.." ["..msg.from.id.."] removed ["..user_id.."] from the muted users list")
                    return "["..user_id.."] \n🛡 تمے الغاء ✔️ الكتمہٰٖ 🚷🚏👲🏻 #بواَّسطّهِ"
				elseif is_momod(msg) then
					mute_user(chat_id, user_id)
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] added ["..user_id.."] to the muted users list")
                    return "["..user_id.."] \n🛡 تمے  ✔️ الكتمہٰٖ 🚷🚏"
				end
            elseif matches[1] == "كتم" and not string.match(matches[2], '^%d+$') then
                local receiver = get_receiver(msg)
                local get_cmd = "mute_user"
                local username = matches[2]
                local username = string.gsub(matches[2], '@', '')
                resolve_username(username, callbackres, {receiver = receiver, get_cmd = get_cmd, msg=msg})
            end
        end

        if matches[1] == "اعدادات الوسائط" and is_momod(msg) then
            local chat_id = msg.to.id
            if not has_mutes(chat_id) then
                set_mutes(chat_id)
                return mutes_list(chat_id)
            end
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup muteslist")
            return mutes_list(chat_id)
        end
        if matches[1] == "المكتومين" and is_momod(msg) then
            local chat_id = msg.to.id
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup mutelist")
            return muted_user_list(chat_id)
        end

        if matches[1] == 'الاعدادات' and is_momod(msg) then
            local target = msg.to.id
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup settings ")
            return show_supergroup_settingsmod(msg, target)
        end

        if matches[1] == 'القوانين' then
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group rules")
            return get_rules(msg, data)
        end

        if matches[1] == 'help' and not is_owner(msg) then
            text = "Message /superhelp to @Teleseed in private for SuperGroup help"
            reply_msg(msg.id, text, ok_cb, false)
        elseif matches[1] == 'help' and is_owner(msg) then
            local name_log = user_print_name(msg.from)
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] Used /superhelp")
            return super_help()
        end

        if matches[1] == 'peer_id' and is_admin1(msg)then
            text = msg.to.peer_id
            reply_msg(msg.id, text, ok_cb, false)
            post_large_msg(receiver, text)
        end

        if matches[1] == 'msg.to.id' and is_admin1(msg) then
            text = msg.to.id
            reply_msg(msg.id, text, ok_cb, false)
            post_large_msg(receiver, text)
        end

        --Admin Join Service Message
        if msg.service then
        local action = msg.action.type
            if action == 'chat_add_user_link' then
                if is_owner2(msg.from.id) then
                    local receiver = get_receiver(msg)
                    local user = "user#id"..msg.from.id
                    savelog(msg.to.id, name_log.." Admin ["..msg.from.id.."] joined the SuperGroup via link")
                    channel_set_admin(receiver, user, ok_cb, false)
                end
                if is_support(msg.from.id) and not is_owner2(msg.from.id) then
                    local receiver = get_receiver(msg)
                    local user = "user#id"..msg.from.id
                    savelog(msg.to.id, name_log.." Support member ["..msg.from.id.."] joined the SuperGroup")
                    channel_set_mod(receiver, user, ok_cb, false)
                end
            end
            if action == 'chat_add_user' then
                if is_owner2(msg.action.user.id) then
                    local receiver = get_receiver(msg)
                    local user = "user#id"..msg.action.user.id
                    savelog(msg.to.id, name_log.." Admin ["..msg.action.user.id.."] added to the SuperGroup by [ "..msg.from.id.." ]")
                    channel_set_admin(receiver, user, ok_cb, false)
                end
                if is_support(msg.action.user.id) and not is_owner2(msg.action.user.id) then
                    local receiver = get_receiver(msg)
                    local user = "user#id"..msg.action.user.id
                    savelog(msg.to.id, name_log.." Support member ["..msg.action.user.id.."] added to the SuperGroup by [ "..msg.from.id.." ]")
                    channel_set_mod(receiver, user, ok_cb, false)
                end
            end
        end
        if matches[1] == 'msg.to.peer_id' then
            post_large_msg(receiver, msg.to.peer_id)
        end
    end
end

local function pre_process(msg)
  if not msg.text and msg.media then
    msg.text = '['..msg.media.type..']'
  end
  return msg
end

return {
  patterns = {
    "^(تفعيل)$",
    "^(تعطيل)$",
    "^([Mm]ove) (.*)$",
    "^(معلومات المجموعه)$",
    "^(الاداريين)$",
    "^(مدير المجموعه)$",
    "^(الادمنيه)$",
    "^(كشف بوت)$",
    "^(ايدي الاعضاء)$",
    "^([Kk]icked)$",
  "^(بلوك) (.*)",
    "^(بلوك)",
    "^(ترقيه سوبر)$",
    "^(ايدي)$",
    "^(ايدي) (.*)$",
    "^(زحلكني)$",
    "^[#!/]([Kk]ick) (.*)$",
    "^(تغير الرابط)$",
    "^(ضع رابط)$",
    "^(الرابط)$",
    "^(الايدي) (.*)$",
    "^(رفع اداري) (.*)$",
    "^(رفع اداري)",
    "^(تنزيل اداري) (.*)$",
    "^(تنزيل اداري)",
    "^(رفع المدير) (.*)$",
    "^(رفع المدير)$",
    "^(رفع ادمن) (.*)$",
    "^(رفع ادمن)",
    "^(تنزيل ادمن) (.*)$",
    "^(تنزيل ادمن)",
    "^(ضع اسم) (.*)$",
    "^(ضع وصف) (.*)$",
    "^(ضع قوانين) (.*)$",
    "^(ضع صوره)$",
    "^(ضع معرف) (.*)$",
    "^(احذف)$",
    "^(قفل) (.*)$",
    "^(فتح) (.*)$",
    "^(قفل) ([^%s]+)$",
    "^(فتح) ([^%s]+)$",
    "^(كتم)$",
    "^(كتم) (.*)$",
    "^(المراقبه) (.*)$",
    "^(الاعدادات)$",
    "^(القوانين)$",
    "^(ضع تكرار) (%d+)$",
    "^(مسح) (.*)$",
    "^[#!/]([Hh]elpp)$",
    "^(اعدادات الوسائط)$",
    "^(المكتومين)$",
    "^[#!/](تفعيل)$",
    "^[#!/](تعطيل)$",
    "^[#!/]([Mm]ove) (.*)$",
    "^[#!/](معلومات المجموعه)$",
    "^[#!/](الاداريين)$",
    "^[#!/](مدير المجموعه)$",
    "^[#!/](الادمنيه)$",
    "^[#!/](كشف بوت)$",
    "^[#!/](ايدي الاعضاء)$",
    "^[#!/]([Kk]icked)$",
  "^[#!/](بلوك) (.*)",
    "^[#!/](بلوك)",
    "^[#!/](ترقيه سوبر)$",
    "^[#!/](ايدي)$",
    "^[#!/](ايدي) (.*)$",
    "^[#!/](مغادره)$",
    "^[#!/]([Kk]ick) (.*)$",
    "^[#!/](تغير الرابط)$",
    "^[#!/](ضع رابط)$",
    "^[#!/](الرابط)$",
    "^[#!/](الايدي) (.*)$",
    "^[#!/](رفع اداري) (.*)$",
    "^[#!/](رفع اداري)",
    "^[#!/](تنزيل اداري) (.*)$",
    "^[#!/](تنزيل اداري)",
    "^[#!/](رفع المدير) (.*)$",
    "^[#!/](رفع المدير)$",
    "^[#!/](رفع ادمن) (.*)$",
    "^[#!/](رفع ادمن)",
    "^[#!/](تنزيل ادمن) (.*)$",
    "^[#!/](تنزيل ادمن)",
    "^[#!/](ضع اسم) (.*)$",
    "^[#!/](ضع وصف) (.*)$",
    "^[#!/](ضع قوانين) (.*)$",
    "^[#!/](ضع صوره)$",
    "^[#!/](ضع معرف) (.*)$",
    "^[#!/](احذف)$",
    "^[#!/](قفل) (.*)$",
    "^[#!/](فتح) (.*)$",
    "^[#!/](قفل) ([^%s]+)$",
    "^[#!/](فتح) ([^%s]+)$",
    "^[#!/](كتم)$",
    "^[#!/](كتم) (.*)$",
    "^[#!/](المراقبه) (.*)$",
    "^[#!/](الاعدادات)$",
    "^[#!/](القوانين)$",
    "^[#!/](ضع تكرار) (%d+)$",
    "^[#!/](مسح) (.*)$",
    "^[#!/](اعدادات الوسائط)$",
    "^[#!/](المكتومين)$",
    "[#!/](mp) (.*)",
    "[#!/](md) (.*)",
    "^(https://telegram.me/joinchat/%S+)$",
    "msg.to.peer_id",
    "%[(document)%]",
    "%[(photo)%]",
    "%[(video)%]",
    "%[(audio)%]",
    "%[(contact)%]",
    "^!!tgservice (.+)$",
  },
  run = run,
  pre_process = pre_process
}
--[[ 
    _____    _        _    _    _____    Dev @lIMyIl 
   |_   _|__| |__    / \  | | _| ____|   Dev @li_XxX_il
     | |/ __| '_ \  / _ \ | |/ /  _|     Dev @h_k_a
     | |\__ \ | | |/ ___ \|   <| |___    Dev @Aram_omar22
     |_||___/_| |_/_/   \_\_|\_\_____|   Dev @IXX_I_XXI
               CH > @lTSHAKEl_CH
--]]
