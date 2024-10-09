
// onclick Event return false;
// 태그에 대한 click 이벤트 적용시 href 속성 때문에 js 함수 호출 후 페이지 이동 현상 발생


function registerChk() {
    // let msgElement = document.querySelector("#msg");
    const name = document.getElementById('name').value;
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;

    let isName = (name == null || name == "") ? false : true ;
    let isEmail = (email == null || email == "") ? false : true ;
    let isPw =  (password == null || password == "") ? false : true ;

    if(!isName || !isEmail || !isPw) {
        if(!isName) {
            alert("성명을 정확히 입력해주세요");
            document.getElementById('name').focus();
            return false;
        } else if(!isEmail) {
            alert("이메일을 정확히 입력해주세요");
            document.getElementById('email').focus();
            return false;
        } else if(!isPw) {
            alert("비밀번호를 정확히 입력해주세요");
            document.getElementById('password').focus(); 
            return false;
        }
    }
     else {
        console.log(document.getElementById('name'));
        console.log(document.getElementById('email'));
        console.log(document.getElementById('password'));
        document.forms["register"].submit();
    }
}




const urlParams = new URL(location.href).searchParams;
const isDuplEmail = urlParams.get('duplEmail');
if(isDuplEmail) {
  history.replaceState({}, null, location.pathname); // url 뒤의 params 전부 삭제
  alert("이메일 중복입니다.");
}
