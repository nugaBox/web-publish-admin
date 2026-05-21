<div class="siiru-passwdWrap">
	<div class="passwdWrap">
		<form name="siiru-passwdForm" id="siiru-passwdForm" method="post">
			<input type="hidden" name="siteId" value="<c:out value="${site.siteId}" />">
			<input type="hidden" name="pageId" value="<c:out value="${param.pageId}" />">
			<input type="hidden" name="redirect" value="<c:out value="${param.redirect}" />">
			<h4>비밀번호 변경</h4>
			<ul>
				<li>1. 이름, 생년월일, 전화번호 등 쉽게 타인이 유추할 수 있는 정보로 비밀번호를 사용하지 마십시오.</li>
				<li>2. 현재 사용 중인 비밀번호가 아닌 다른 비밀번호로 변경하시기 바랍니다.</li>
				<li>3. 1234, qwer와 같은 단순한 문자열, 1111처럼 연속되는 단순 문자열, 또는 love, happy 와 같은 단어로 구성된 비밀번호의 사용은 위험합니다.</li>
				<li>4. 비밀번호는 3개월에 한번씩 또는 그보다 자주 변경하는 것이 좋습니다.</li>
				<li>5. 비밀번호 등 개인정보를 타인에게 절대 알려주지 마십시오.</li>
				<li>6. 영문,숫자,특수문자(!@#$%^?*+=_~- 만 허용)를 혼합하여 8~20자 이내</li>
				<li>7. 공백(Space)는 입력할수 없습니다.</li>
			</ul>
			<dl>
				<dt><label for="passwd">현재 비밀번호</label></dt>
				<dd><input type="password" id="passwd" name="passwd" class="alphanumPass nothangul" maxlength="20" autocomplete="off" value=""></dd>
			</dl>
			<dl>
				<dt><label for="newPasswd">새 비밀번호</label></dt>
				<dd><input type="password" id="newPasswd" name="newPasswd" class="alphanumPass nothangul" maxlength="20" autocomplete="off" value=""></dd>
			</dl>
			<dl>
				<dt><label for="newPasswdConfirm">새 비밀번호 확인</label></dt>
				<dd><input type="password" id="newPasswdConfirm" name="newPasswdConfirm" class="alphanumPass nothangul" maxlength="20" autocomplete="off" value=""></dd>
			</dl>
			<div class="siiru-btnSet siiru-tc">
				<button type="button" id="passwdSubmit" class="siiru-btn siiru-btn-primary">비밀번호 변경</button>
				<button type="button" id="cancelBtn" class="siiru-btn siiru-btn-default siiru-ml10">다음에 변경</button>
			</div>
		</form>
	</div>
</div>
<script>
// 페이지 로드가 완료되면
if (window.addEventListener) window.addEventListener("load", passChange, false);
else if (window.attachEvent) window.attachEvent("onload", passChange);
else window.onload = passChange;
// 비밀번호 변경
function passChange() {
	// 비밀번호 변경
	$('#passwdSubmit').click(function(e) {
		$passForm = $('#siiru-passwdForm');
		var passwd = $passForm.find('input[name="passwd"]');
		var newPasswd = $passForm.find('input[name="newPasswd"]');
		var newPasswdConfirm = $passForm.find('input[name="newPasswdConfirm"]');
		if ($.trim($(passwd).val()) == '') {
			alert('현재 비밀번호를 입력해 주세요.');
			$(passwd).focus();
		} else if ($.trim($(newPasswd).val()) == '') {
			alert('새 비밀번호를 입력해 주세요.');
			$(newPasswd).focus();
		} else if ($.trim($(newPasswdConfirm).val()) == '') {
			alert('새 비밀번호를 한번 더 입력해 주세요.');
			$(newPasswdConfirm).focus();
		} else if ($.trim($(newPasswd).val()) != $.trim($(newPasswdConfirm).val())) {
			alert('새 비밀번호가 일치하지 않습니다.');
			$(newPasswdConfirm).val('').focus();
		} else if ($.trim($(passwd).val()) == $.trim($(newPasswd).val())) {
			alert('현재 비밀번호와 새 비밀번호가 동일합니다.\n다른 비밀번호로 변경해 주세요.');
			$(newPasswd).val('').focus();
			$(newPasswdConfirm).val('');
		} else if (!ValidPasswd($(newPasswd).val())) {
			alert('비밀번호 유효성 검사를 통과하지 못했습니다.');
			$(newPasswd).val('').focus();
			$(newPasswdConfirm).val('');
		} else {
			$.post('<c:out value="${path.context}" />passChangeAction.do', $passForm.serialize()).done(function(data) {
				if (data.error == 'N') {
					alert("정상적으로 비밀번호가 변경 되었습니다.\n비밀번호는 정기적으로 변경하시기 바랍니다.");
					redirect();
				} else {
					alert(data.errorMsg);
				}
			});
		}
	});
	// 다음에 변경
	$('#cancelBtn').click(function(e) {
		redirect();
	});
}
// 페이지 이동
function redirect() {
	var redirect = '<c:out value="${path.sContext}" />';
	if ($.trim($('#siiru-passwdForm').find('input[name="redirect"]').val()) != '') redirect = $.trim($('#siiru-agreeForm').find('input[name="redirect"]').val());
	window.document.location.href = redirect;
}
</script>
