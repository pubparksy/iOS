const fetch = require("node-fetch");
var express = require("express");

var app = express();
var client_id = "";
var client_secret = "";
var redirectURI = encodeURI(`http://127.0.0.1:3005/callback`); // 백팁으로 PORT 적으면 안됨
var state = "RAMDOM_STATE";
var api_url = "";
const PORT = 3005;

app.get("/naverlogin", function (req, res) {
  api_url =
    "https://nid.naver.com/oauth2.0/authorize?response_type=code"
    + "&client_id=" + client_id 
    + "&redirect_uri=" + redirectURI 
    + "&state=" + state;

  res.writeHead(200, { "Content-Type": "text/html;charset=utf-8" });
  res.end(
    "<a href='" +
      api_url +
    "'><img height='50' src='http://static.nid.naver.com/oauth/small_g_in.PNG'/></a>"
  );
});


app.get("/callback", async function (req, res) {
  const code = req.query.code;
  const state = req.query.state;
  const api_url =
    "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
    + "&client_id=" + client_id 
    + "&client_secret=" + client_secret 
    + "&redirect_uri=" + redirectURI 
    + "&code=" + code 
    + "&state=" + state;


  const response = await fetch(api_url, {
    headers: {
      "X-Naver-Client-Id": client_id,
      "X-Naver-Client-Secret": client_secret,
    },
  });

  const tokenRequest = await response.json();

  //3단계: access_token으로 사용자 정보 받아오기
  if ("access_token" in tokenRequest) {
    const { access_token } = tokenRequest;
    const apiUrl = "https://openapi.naver.com/v1/nid/me";

    const data = await fetch(apiUrl, {
      headers: {
        Authorization: `Bearer ${access_token}`,
      },
    });

    const userData = await data.json();
    console.log("userData:", userData);
  }

  return res.send("프로필 API 출력");
});

app.listen(PORT, function () {
  console.log(`http://127.0.0.1:${PORT}/naverlogin app listening on port ${PORT}!`);
});