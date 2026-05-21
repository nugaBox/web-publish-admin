<div class="siiru-loginWrap">
	<div class="loginWrap">
		<form id="login" name="login" method="post">
		<input type="hidden" name="pageSe" value="L">
		<input type="hidden" name="siteId" value="<c:out value="${site.siteId}" />">
		<input type="hidden" name="pageId" value="<c:out value="${param.pageId}" />">
		<input type="hidden" name="boardId" value="<c:out value="${param.boardId}" />">
		<input type="hidden" name="actionPage" value="<c:out value="${param.action}" />">
		<input type="hidden" name="redirect" value="<c:out value="${param.redirect}" />">
		<input type="hidden" name="userId" value="">
		<input type="hidden" name="passwd" value="">
		</form>
		<h4>로그인</h4>
		<div class="loginUser-tab">
			<ul>
				<li data-tp="M"><a href="#" data-pagetp="M">회원 로그인</a></li>
				<li data-tp="N"><a href="#" data-pagetp="N">비회원 로그인</a></li>
			</ul>
		</div>
		<section id="M">
			<div class="loginLayer">
				<div class="inputWrap<c:if test="${certAt eq 'N'}"> inputSingle</c:if>">
					<c:if test="${certAt eq 'Y'}"><h5>계정 로그인</h5></c:if>
					<form name="siiru-loginForm" id="siiru-loginForm" method="post">
					<input type="hidden" id="RSAModulus" name="RSAModulus" value="${RSAModulus}">
					<input type="hidden" id="RSAExponent" name="RSAExponent" value="${RSAExponent}">
					<dl>
						<dt><label for="userId">아이디</label></dt>
						<dd>
							<input type="text" id="userId" name="userId" class="alphanumId" value="" placeholder="아이디">
							<input type="checkbox" id="idSave" name="idSave" value="Y">
							<label for="idSave">아이디 저장</label>
						</dd>
					</dl>
					<dl>
						<dt><label for="passwd">비밀번호</label></dt>
						<dd><input type="password" id="passwd" name="passwd" value="" placeholder="비밀번호" autocomplete="off"></dd>
					</dl>
					<div class="siiru-btnSet siiru-tc">
						<button type="submit" id="loginSubmit" class="siiru-btn siiru-btn-primary">로그인</button>
					</div>
					</form>
					<ul class="joinLayer">
						<li><a href="<c:out value="${path.context}" />join.do?pageId=" class="siiru-btn">회원가입</a></li>
						<li><a href="<c:out value="${path.context}" />findUser.do?pageId=" class="siiru-btn">아이디/비밀번호 찾기</a></li>
					</ul>
				</div>
				<c:if test="${certAt eq 'Y'}">
				<div class="certWrap">
					<h5>본인인증을 통한 로그인</h5>
					<div class="kindBoxWrap">
						<div class="kindBox">
							<div class="stepCate">
								<p>휴대폰인증</p>
								<button type="button" class="siiru-btn" data-certtype="NICE">인증하기</button>
							</div>
						</div>
						<div class="kindBox siiru-mr0">
							<div class="stepCate">
								<p>아이핀(I-PIN)</p>
								<button type="button" class="siiru-btn" data-certtype="NICEIPIN">인증하기</button>
							</div>
						</div>
					</div>
					<div class="kindBoxWrap">
						<div class="kindBox">
							<div class="stepCate">
								<p>간편인증</p>
								<button type="button" class="siiru-btn" data-certtype="EASYSIGN">인증하기</button>
							</div>
						</div>
						<div class="kindBox siiru-mr0">
							<div class="stepCate">
								<p>모바일신분증</p>
								<button type="button" class="siiru-btn" data-certtype="MOBILEID">인증하기</button>
							</div>
						</div>
					</div>
					<p class="info">본인인증을 통한 로그인을 이용하기 위해서는 회원으로 가입되어있어야 합니다.<br>(비회원은 본인인증을 통한 로그인을 사용하실 수 없습니다.)<p>
				</div>
				</c:if>
			</div>
		</section>
		<section id="N">
			<c:if test="${certAt eq 'Y'}">
			<div class="certWrap certSingle">
				<div class="kindBoxWrap">
					<div class="kindBox">
						<div class="stepCate">
							<p>휴대폰인증</p>
							<button type="button" class="siiru-btn" data-certtype="NICE">인증하기</button>
						</div>
					</div>
					<div class="kindBox siiru-mr0">
						<div class="stepCate">
							<p>아이핀(I-PIN)</p>
							<button type="button" class="siiru-btn" data-certtype="NICEIPIN">인증하기</button>
						</div>
					</div>
				</div>
				<div class="kindBoxWrap">
					<div class="kindBox siiru-mr0">
						<div class="stepCate">
							<p>모바일신분증</p>
							<button type="button" class="siiru-btn" data-certtype="MOBILEID">인증하기</button>
						</div>
					</div>
				</div>
			</div>
			</c:if>
			<c:if test="${snsAt eq 'Y'}">
			<div class="snsLoginWrap">
				<ul>
					<c:forEach var="cmmn" items="${snsList}" varStatus="status">
					<li><a href="#" class="snsBtn" data-snstype="${cmmn.codeId}"><img src="<c:out value="${path.context}" />home/siiru/images/icon_${cmmn.codeId}.png" alt="${cmmn.codeNm} 로그인"></a></li>
					</c:forEach>
				</ul>
			</div>
			</c:if>
		</section>
	</div>
</div>
<c:if test="${rsaAt eq 'Y'}">
<script src="<c:out value="${path.context}" />siiru/js/rsa/jsbn.js"></script>
<script src="<c:out value="${path.context}" />siiru/js/rsa/rsa.js"></script>
<script src="<c:out value="${path.context}" />siiru/js/rsa/prng4.js"></script>
<script src="<c:out value="${path.context}" />siiru/js/rsa/rng.js"></script>
</c:if>
<script>
<c:if test="${certAt eq 'Y'}">
// 간편인증
var easyPopup = null;
// 초기화 변수
var initVal = false;
var initCount = 0;
// 행안부 간편인증 데이터 통신
window.addEventListener("message", receiveMsg, false);
</c:if>
// 페이지 로드가 완료되면
if (window.addEventListener) window.addEventListener("load", login, false);
else if (window.attachEvent) window.attachEvent("onload", login);
else window.onload = login;
// 회원/비회원 구분값
var liTab = 'M';
function login() {
	// 탭
	$('.loginUser-tab li a').click(function(e) {
		e.preventDefault();
		$(this).parent().addClass('active');
		$(this).parent().siblings('li').removeClass('active');
		$('#'+$(this).data('pagetp')).css('display','block');
		$('#'+$(this).data('pagetp')).siblings('section').css('display','none');
		liTab = $(this).data('pagetp');
	});
	$('.loginUser-tab li[data-tp="'+liTab+'"] a').trigger('click');
	var rsaAt = '<c:out value="${rsaAt}" />';
	$login = $('#login');
	$loginForm = $('#siiru-loginForm');
	var pageSe = $.trim($login.find('input[name="pageSe"]').val());
	var pageId = $.trim($login.find('input[name="pageId"]').val());
	// 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
	$loginForm.find('input[name="userId"]').val($.trim(getCookie('cUserId')));
	if ($.trim($loginForm.find('input[name="userId"]').val()) != '') {
		$('#idSave').attr('checked', true);
	}
	$('#idSave').change(function() {
		if ($(this).is(':checked')) {
			// 7일 동안 쿠키 보관
			setCookie('cUserId', $.trim($loginForm.find('input[name="userId"]').val()), 7);
		} else {
			deleteCookie('cUserId');
		}
	});
	// 로그인 인증
	$('#loginSubmit').click(function(e) {
		e.preventDefault();
		if ($.trim($loginForm.find('input[name="userId"]').val()) == '') {
			alert('아이디를 입력해 주세요.');
			$loginForm.find('input[name="userId"]').focus();
		} else if ($.trim($loginForm.find('input[name="passwd"]').val()) == '') {
			alert('비밀번호를 입력해 주세요.');
			$loginForm.find('input[name="passwd"]').focus();
		} else {
			$login.find('input[name="userId"]').val('');
			$login.find('input[name="passwd"]').val('');
			if (rsaAt == 'Y') {
				// RSA 암호키 생성
				var rsa = new RSAKey();
				rsa.setPublic($('#RSAModulus').val(), $('#RSAExponent').val());
				// 암호화
				$login.find('input[name="userId"]').val(rsa.encrypt($.trim($loginForm.find('input[name="userId"]').val())));
				$login.find('input[name="passwd"]').val(rsa.encrypt($.trim($loginForm.find('input[name="passwd"]').val())));
			} else {
				// 암호화
				$login.find('input[name="userId"]').val($.trim($loginForm.find('input[name="userId"]').val()));
				$login.find('input[name="passwd"]').val($.trim($loginForm.find('input[name="passwd"]').val()));
			}
			// pageSe [L:로그인, E:외부로그인]
			var ajaxUrl = '<c:out value="${path.context}" />loginAction.do';
			if (pageSe == 'E') ajaxUrl = '<c:out value="${path.context}" />loginExtrlAction.do';
			$.post(ajaxUrl, $login.serialize()).done(function(data) {
				if (data.error == 'N') {
					if ($('#idSave').is(':checked')) {
						setCookie('cUserId', $.trim($loginForm.find('input[name="userId"]').val()), 7);
					}
					if (pageSe == 'E') {
						certResponse(data.extrlAdd, '');
					} else {
						// 회원정보 재동의 화면
						if ($.trim(data.loginTy) == 'A') {
							alert('개인정보보호법 및 표준 개인정보보호 보호지침 제60조에 의거 회원정보 재동의 페이지로 이동합니다.');
							window.document.location.href = '<c:out value="${path.context}" />reAgree.do?pageId=&redirect='+encodeURIComponent(redirect());
						// 비밀번호 변경 화면
						} else if ($.trim(data.loginTy) == 'C' || $.trim(data.loginTy) == 'CI') {
							if ($.trim(data.loginTy) == 'CI') {
								alert('비밀번호가 관리자에 의해 초기화 되셨습니다. 보안을 위해 비밀번호를 변경해 주시기 바랍니다.');
							} else {
								alert('장기간 동일한 비밀번호를 사용하여 비밀번호 변경 페이지로 이동합니다.');
							}
							window.document.location.href = '<c:out value="${path.context}" />passChange.do?pageId=';
						} else {
							window.document.location.href = redirect();
						}
					}
				} else {
					alert(data.errorMsg);
				}
			});
		}
		return false;
	});
<c:if test="${certAt eq 'Y'}">
	// 실명인증
	$('.stepCate button').click(function() {
		var w = 480, h = 812;
		var certType = $.trim($(this).data('certtype'));
		if (certType == 'NICEIPIN') {
			w = 445, h = 580;
		} else if (certType == 'KMC') {
			w = 480, h = 812;
		} else if (certType == 'SCI') {
			w = 480, h = 812;
		} else if (certType == 'SCIIPIN') {
			w = 445, h = 580;
		} else if (certType == 'EASYSIGN') {
			w = 838, h = 611;
		} else if (certType == 'MOBILEID') {
			w = 838, h = 611;
		}
		var top = ($(window).height() - h) / 2;
		var left = ($(window).width() - w) / 2;
		// 행안부 간편인증
		if (certType == 'EASYSIGN') {
			if (easyPopup == null || easyPopup.closed == true) {
				// 개발용(중계) 접속안됨 : http://220.76.91.64:5011/esign
				// 실서버용(중계) : https://easysign.anyid.go.kr/esign
				// 행안부 간편인증 중계창 오픈
				easyPopup = window.open('https://easysign.anyid.go.kr/esign','simpleAuth','top='+top+',left='+left+',width='+w+',height='+h+',toolbar=no,scrollbars=no,location=no,resizable=no,status=no,menubar=no');
				// 접속정보 생성 및 전송
				getAccessInfo();
			}
		} else {
			var certUrl = '';
			// 모바일신분증
			if (certType == 'MOBILEID') {
				certUrl = '<c:out value="${path.context}" />mobileidView.do?pageId='+pageId+'&taskSe=L&userSe='+liTab;
			} else {
				certUrl = '<c:out value="${path.context}" />certRequest.do?pageId='+pageId+'&pageSe=L&userKind='+liTab+'&certType='+certType;
				if (certType == 'DOP') certUrl+= '&serviceType='+$(this).data('servicetype');
			}
			// 윈도우 오픈
			openWindow(certUrl,certType+'CertWindow',top,left,w,h,'yes','no');
		}
	});
</c:if>
<c:if test="${snsAt eq 'Y'}">
	// SNS 인증
	$('.snsBtn').click(function(e) {
		e.preventDefault();
		var snsType = $.trim($(this).data('snstype'));
		var w = 633, h = 947;
		if (snsType == 'K') {
			h = 629;
		} else if (snsType == 'F') {
			w = 650, h = 600;
		} else if (snsType == 'G') {
			w = 600, h = 600;
		}
		var top = ($(window).height() - h) / 2;
		var left = ($(window).width() - w) / 2;
		var snsUrl = '<c:out value="${path.context}" />snsAuth.do?pageId='+pageId+'&snsType='+snsType;
		// 윈도우 오픈
		openWindow(snsUrl,snsType+'SnsWindow',top,left,w,h,'yes','no');
	});
</c:if>
}
// 실명인증/외부로그인 리턴
function certResponse(extrlAdd, userSe) {
	if ($.trim(extrlAdd) == 'Y') {
		window.document.location.href = '<c:out value="${path.context}" />extrl.do?pageId=&redirect='+encodeURIComponent(redirect());
	} else {
		if ($.trim(userSe) == 'M') {
			alert('[등록된 회원정보가 없습니다]\n회원으로 가입하지 않은 경우 회원가입 후 본인인증을 이용한 로그인이 가능합니다.');
		} else {
			window.document.location.href = redirect();
		}
	}
}
<c:if test="${certAt eq 'Y'}">
// 행안부 간편인증. 중계서비스 인증화면에서 호출하는 데이터를 받는 함수 
function receiveMsg(event) {
	var data = event.data;
	try {
		var jsonData = JSON.parse(data);
		// window.open 으로 호출한 중계서비스 인증화면의 초기화 상태값을 받는 부분
		if (jsonData.initFlag == 'true') {
			initVal = true;
			return;
		}
		// 인증완료
		if (jsonData.status == 'success' && jsonData.fn == 'authComplete') {
			$.ajax({
				type: 'post',
				url: '<c:out value="${path.context}" />easyLogin.do',
				dataType: 'json',
				contentType: 'application/json; charset=utf-8',
				data: data,
				success: function(data) {
					if (data.error == 'N') {
						if (data.loginTy == 'N') {
							alert('[등록된 회원정보가 없습니다]\n회원으로 가입하지 않은 경우 회원가입 후 본인인증을 이용한 로그인이 가능합니다.');
						} else {
							window.document.location.href = redirect();
						}
					} else {
						alert(data.errorMsg);
					}
				}
			});
		}
	} catch (e) {
		return false;
	}
}
// 간편인증 인증키 획득
function getAccessInfo() {
	$.post('<c:out value="${path.context}" />easyAccessInfo.do').done(function(data) {
		if (data.error == 'N') {
			setTimeout(function() {
				if (initVal) {
					// 간편인증 중계서버로 전송
					easyPopup.postMessage('{"simpleType":"simpleAuth","accKey":"'+$.trim(data.accKey)+'","accToken":"'+$.trim(data.accToken)+'"}',"*");
					initVal = false;
					initCount = 0;
				} else {
					if (initCount > 20) {
						initCount = 0;
						return;
					}
					getAccessInfo();
					initCount++;
				}
			},300);
		} else {
			alert(data.errorMsg);
		}
	});
}
</c:if>
<c:if test="${snsAt eq 'Y'}">
// SNS인증 리턴
function snsResponse(ty, snsLogin) {
	if ($.trim(snsLogin) == 'N') {
		// 회원가입페이지로 이동
		if ($.trim(ty) == 'J') window.document.location.href = '<c:out value="${path.context}" />join.do?pageId=&stepLevel=S2&userKind=S';
	} else {
		// 로그인 섹션생성됨
		window.document.location.href = redirect();
	}
}
</c:if>
// 이동될 페이지
function redirect() {
	$login = $('#login');
	var pageId = $.trim($login.find('input[name="pageId"]').val());
	var boardId = $.trim($login.find('input[name="boardId"]').val());
	var actionPage = $.trim($login.find('input[name="actionPage"]').val());
	var redirect = '<c:out value="${path.sContext}" />';
	// 게시판ID가 있다면
	if (boardId != '') {
		if (actionPage == 'insert') {
			redirect = '<c:out value="${path.sContext}" />board.do?action='+actionPage+'&boardId='+boardId+'&pageId='+pageId;
		} else {
			redirect = '<c:out value="${path.sContext}" />boardList.do?boardId='+boardId+'&pageId='+pageId;
		}
	} else {
		if ($.trim($login.find('input[name="redirect"]').val()) != '') {
			redirect = $.trim($login.find('input[name="redirect"]').val());
		}
	}
	return redirect;
}
</script>
