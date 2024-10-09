const fetch = require("node-fetch");
var express = require("express");

var app = express();
var consumer_key    = "";
var consumer_secret = "";
var api_url = "";
const PORT = 3007;

app.get("/address", async function (req, res) {
    api_url =
      "https://sgisapi.kostat.go.kr/OpenAPI3/auth/authentication.json?" 
      + "consumer_key=" + consumer_key 
      + "&consumer_secret=" + consumer_secret;
  
    const response = await fetch(api_url, {
      params: {
        "consumer_key": consumer_key,
        "consumer_secret": consumer_secret,
      },
    });
  
    const tokenRequest = await response.json();
    return res.send(tokenRequest);
  });

  app.listen(PORT, function () {
    console.log(`http://127.0.0.1:${PORT}/address app listening on port ${PORT}`);
  });