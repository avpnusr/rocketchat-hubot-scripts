module.exports = (robot) ->
  robot.hear /\.wetter/i, (res) ->
    query = res.message.text.slice(8)
# You need to provide an own api-key for openweathermap - it's free, no subscription
    apiUrl = "http://api.openweathermap.org/data/2.5/weather?q=" + query + "&appid=YOUR-OWN-OPENWEATHERMAPS-API-KEY-HERE&units=metric&lang=de"
    room = res.message.room
    request = robot.http(apiUrl)
      .get()

    request (err, res, body) ->
      if err
        msg.send("There was some error")
        return

      results = JSON.parse(body)

      reslength = results.length
      if reslength =! 0
        temp = results['main']['temp']
        wind = results['wind']['speed']
        condition = results['weather']['0']['icon']
        weathernow = results['weather']['0']['description']
        name = results['name']
        msg = {}
        msg.attachments = [
                {
                        text: "**_Wetter in " + name + "_**\n **Temperatur: " + temp + "°C**\n **Wind:    " + wind + " m/s**\n **Im Moment: " + weathernow + "**",
                        thumb_url: "https://openweathermap.org/img/wn/" + condition + "@2x.png",
                        color: "#ECFF33"
                }
        ];
        robot.messageRoom room, msg
      else
        robot.messageRoom room, "Sorry there was an error"