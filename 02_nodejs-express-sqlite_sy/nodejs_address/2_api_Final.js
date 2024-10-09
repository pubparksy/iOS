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
  
    const response = await fetch(api_url); 
    // Header에 넣어야하면 api_url, headers: { "key": value } 추가
  
    const tokenRequest = await response.json(); // 그냥은 못 쓰고 json화 필요.

    // access_token으로 단계별 주소 받아오기
    if ("result" in tokenRequest) {
      const { accessToken } = tokenRequest["result"];
      const apiUrl = "https://sgisapi.kostat.go.kr/OpenAPI3/addr/stage.json?"
      + "accessToken=" + accessToken
      ;
  
      const data = await fetch(apiUrl);
      // Header에 넣어야하면 api_url, headers: { "key": value } 추가

      const addrData = await data.json(); // 그냥은 못 쓰고 json화 필요.
      console.log("addrData:", addrData['result']);

    }
  
    return res.send(`주소 API 출력`);
  });
  


  app.listen(PORT, function () {
    console.log(`http://127.0.0.1:${PORT}/address app listening on port ${PORT}`);
  });