-- music.lua
--
-- Brandon Amos <http://bamos.io/>
-- 2014.05.15
require 'os'
require 'io'
require 'string'

-- Helper function to execute a command and return the output as a string.
-- Reference: http://stackoverflow.com/questions/132397
function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  return string.sub(s, 0, -2) -- Use string.sub to trim the trailing newline.
end

-- Global variables for deleting/restoring the current track.
deleted_tmp = "/tmp/mpv-deleted"
last_deleted_track = ""

-- Delete the current track by moving it to the `deleted_tmp` location.
function delete_current_track()
  last_deleted_track = mp.get_property("path")
  os.execute("mv '" .. last_deleted_track .. "' '" .. deleted_tmp .. "'")
  print("'" .. last_deleted_track .. "' deleted.")
end

-- Restore the last deleted track.
-- This can be done to restore an arbitrary number of tracks by
-- using a queue rather than a single file.
function restore_prev_track()
  if last_deleted_track ~= "" then
    os.execute("mv '" .. deleted_tmp .. "' '" .. last_deleted_track .. "'")
    print("Successfully recovered '" .. last_deleted_track .. "'")
    last_deleted_track = ""
  else
    print("No track to recover.")
  end
end

-- Move the current track into a `good` directory.
function mark_good()
  last_deleted_track = mp.get_property("path")
  os.execute("mkdir -p good")
  os.execute("mv '" .. mp.get_property("path") .. "' '" .. "good" .. "'")
  print("Marked '" .. last_deleted_track .. "' as good.")
end

-- Print the current track's artist and title in the following format.
--
-- [music] ---------------
-- [music] Title: Marche Slave
-- [music] Artist: Tchaikovsky
-- [music] ---------------
function print_info()
  local info = os.capture(
    'exiftool -json ' .. mp.get_property("path") ..
    ' | grep \'^ *"\\(Artist\\|Title\\)\' ' ..
    ' | sed \'s/^ *"\\(Artist\\|Title\\)": "\\(.*\\)",$/\\1: \\2/g\'; '
  )
  print(string.rep("-", 15))
  print(info)
  print(string.rep("-", 15))
end

-- Use zenity and mutt to share the current track's information with a friend.
-- This can be modified to send the message with any command-line email client
-- or used to interface directly with an SMTP server.
function share_info()
  local email = os.capture(
    'zenity --entry --title "Email to share with?" --text ""'
  )
  if email == "" then
    print("Error: No email input.")
    return
  end
  local content = os.capture(
    'zenity --entry --title "Optional message body?" --text ""'
  )
  local artist = os.capture(
    'exiftool -json ' .. mp.get_property("path") ..
    ' | grep \'^ *"Artist\' ' ..
    ' | sed \'s/^ *"Artist": "\\(.*\\)",$/\\1/g\'; '
  )
  local title = os.capture(
    'exiftool -json ' .. mp.get_property("path") ..
    ' | grep \'^ *"Title\' ' ..
    ' | sed \'s/^ *"Title": "\\(.*\\)",$/\\1/g\'; '
  )
  local info = 'Hi, check out ' .. title .. ' by ' .. artist
  os.capture("echo '" .. content .. "' | " ..
    "mutt -s '" .. info .. "'" .. " -- '" .. email .. "'")
end

-- Set key bindings.
mp.add_key_binding("d", "delete_current_track", delete_current_track)
mp.add_key_binding("r", "restore_prev_track", restore_prev_track)
mp.add_key_binding("g", "mark_good", mark_good)
mp.add_key_binding("i", "print_info", print_info)
mp.add_key_binding("s", "share", share_info)
