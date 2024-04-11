let elId = document.querySelector('.regiid');
let elName = document.querySelector('.reginame');
let elPassWord = document.querySelector('.regipwd');
let elPassWordRetype = document.querySelector('.regipwdretype');
let elEmail = document.querySelector('.regiemail');
let elPhone = document.querySelector('.regiphone');
let idInput = document.querySelector('.registerinput');
let elSpaceMessage = document.querySelector('.space');
let elMismatchMessage = document.querySelector('.mismatch');
let elDuplicateResult = document.querySelector('.duplicateResult');
let elidreturn = document.querySelector('.idreturn');
let elValidateMessage = document.querySelector('.validate');

function noSpace(str) {
    return /^[^\s]*$/.test(str);
}

function validateEmail(email) {
    return /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i.test(email);
}

function isMatch(password1, password2) {
	return password1 === password2;
}

function duplicateCheck() { 
	
	if ( idInput.value.length === 0 ) {
		alert("아이디를 입력해주세요");
		return;
	}
	
	window.open("", "idDuplicate", "width=540, height=490, left=750, top=300");
	
	idfrm.target = "idDuplicate";
	idfrm.action = "popup/checkDuplicateId.jsp";
	idfrm.submit();
	
}

function registerUser() {
	
	var checkbox1 = document.getElementById("checkbox1");
	var checkbox2 = document.getElementById("checkbox2");
	var checkbox3 = document.getElementById("checkbox3");
	
	var value1 = checkbox1.checked ? '1' : '0';
	var value2 = checkbox2.checked ? '1' : '0';
	var value3 = checkbox3.checked ? '1' : '0';
	
	if ( elId.value.length === 0 ) {
		alert("아이디를 입력해주세요");
		return;
	} else if ( elName.value.length == 0 ) {
		alert("이름을 입력해주세요");
		return;
	} else if ( elPassWord.value.length === 0 ) {
		alert("패스워드를 입력해주세요");
		return;
	} else if ( elPassWordRetype.value.length === 0 ) {
		alert("패스워드를 입력해주세요");
		return;
	} else if (/\s/.test(elPassWord.value) || /\s/.test(elPassWordRetype.value) ) {
		alert("공백이 존재합니다");
		return;
	} else if ( elPassWord.value !== elPassWordRetype.value ) {
		alert("패스워드가 다릅니다");
		return;
	} else if ( elEmail.value.length === 0 ) {
		alert("이메일을 입력해주세요");
		return;
	} else if ( validateEmail(elEmail.value) === false ) {
		alert("이메일 형식이 유효하지 않습니다");
		return;
	}
    
    if ( elDuplicateResult.value === "null" ) {
		alert("중복확인을 해주세요");
		return;
	} else if ( elDuplicateResult.value === "false" ) {
		alert("이미 존재하는 아이디입니다.");
		return;
	}
    
    if ( value1 === '0' ) {
		alert("이용약관에 동의해주세요");
		return;
	} else if ( value2 === '0' ) {
		alert("서비스 약관에 동의해주세요");
		return;
	} else if ( value3 === '0' ) {
		alert("개인정보 수집 및 이용에 동의해주세요");
		return;
	}
	
	if ( elidreturn.value !== elId.value ) {
		alert("중복확인을 해주세요");
		return;
	}
	
	var result = confirm("회원가입을 진행하시겠습니까?");
	
	if ( result ) {
		document.idfrm.action = "proc/registerProc.jsp";
		document.idfrm.submit();
	} else {
		alert("취소");
	}
	
	
	
}

elPassWord.onkeyup = function() {
	if ( elPassWord.value.length !== 0 ) {
		if ( noSpace(elPassWord.value) === false ) {
			elSpaceMessage.classList.remove('hide');
		} else {
			elSpaceMessage.classList.add('hide');
		}
	} else {
		elSpaceMessage.classList.add('hide');
	}
}

elEmail.onkeyup = function() {
	if ( elEmail.value.length !== 0 ) {
		if ( validateEmail(elEmail.value) === false ) {
			elValidateMessage.classList.remove('hide');
		} else {
			elValidateMessage.classList.add('hide');
		}
	} else {
		elValidateMessage.classList.add('hide');
	}
}

elPassWordRetype.onkeyup = function() {
	if ( elPassWord.value.length !== 0 ) {
		if ( isMatch(elPassWord.value, elPassWordRetype.value) === false ) {
			elMismatchMessage.classList.remove('hide');
		} else {
			elMismatchMessage.classList.add('hide');
		}
	} else {
		elMismatchMessage.classList.add('hide');
	}
}