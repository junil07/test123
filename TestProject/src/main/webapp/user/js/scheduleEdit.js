
function titlenameEdit(num) {
	window.open("", "titlenameEdit", "width=540, height=290, left=750, top=300");
	
	document.titlefrm.titlenum.value = num;
	document.titlefrm.target = "titlenameEdit";
	document.titlefrm.action = "popup/titlenameEdit.jsp";
	document.titlefrm.submit();
}

function editContent(num, fknum) {
	window.open("", "titlecontentEdit", "width=1040, height=290, left=450, top=350");
	
	document.contentfrm.num.value = num;
	document.contentfrm.fknum.value = fknum;
	document.contentfrm.target = "titlecontentEdit";
	document.contentfrm.action = "popup/titlecontentEdit.jsp";
	document.contentfrm.submit();
}