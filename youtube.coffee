###
This bot-script converts a youtube video to mp3 format.
You can search with a fulltext-term or a dedicated video-id from youtube
###

module.exports = (robot) ->
# define command the bot listens for, in this case .yt
# this function lets the user search by fulltext 
  robot.hear /\.\byt\b/i, (res) ->
    exec = require('child_process').exec
    query = res.message.text.slice(4).replace /^\s+|\s+$/g, ""
    room = res.message.user.roomID
#    res.send "Searching and converting ..."
    exec "/home/hubot/scripts/yt2mp3 \"#{query}\" \"#{room}\"" 

# again define command the bos listens for 
# this command required a youtube video-id
  robot.hear /\.\bytid\b/i, (res) ->
    exec = require('child_process').exec
    query = res.message.text.slice(6).replace /^\s+|\s+$/g, ""
    room = res.message.user.roomID
#    res.send "Searching and converting ..."
# calls an external script - yt2mp3 in bash
    exec "/home/hubot/scripts/yt2mp3 \"#{query}\" \"#{room}\" \"ID\""
