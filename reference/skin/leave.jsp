<div class="siiru-userWrap">
	<section class="leaveForm">
		<h4>회원 탈퇴</h4>
		<div class="findLayer">
			<c:if test="${certAt eq 'Y'}">
			<div class="certWrap">
				<h5>본인인증을 통한 탈퇴</h5>
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
			</div>
			</c:if>
			<div class="inputWrap">
		<c:choose>
			<c:when test="${snsUser eq 'Y'}">
				<h5>SNS 회원 탈퇴</h5>
				<div class="siiru-btnSet siiru-tc">
					<button type="button" id="leaveBtn" class="siiru-btn siiru-btn-primary">회원 탈퇴</button>
				</div>
			</c:when>
			<c:otherwise>
				<h5>비밀번호를 통한 탈퇴</h5>
				<form name="siiru-leaveForm" id="siiru-leaveForm" method="post">
				<input type="hidden" name="action" value="L">
				<input type="hidden" name="siteId" value="<c:out value="${site.siteId}" />">
				<input type="hidden" name="pageId" value="<c:out value="${param.pageId}" />">
				<div class="pwCert">
					<input type="password" id="passwd" name="passwd" value="" title="비밀번호" autocomplete="off">
				</div>
				</form>
				<div class="siiru-btnSet siiru-tc">
					<button type="button" id="acceptBtn" class="siiru-btn siiru-btn-primary">회원 탈퇴</button>
				</div>
			</c:otherwise>
		</c:choose>
			</div>
		</div>
	</section>
	<div class="leaveWrap">
		<p>회원탈퇴 처리가 완료되었습니다.</p>
		<div class="siiru-btnSet siiru-tc">
			<button type="button" id="mainBtn" class="siiru-btn siiru-btn-primary">메인화면</button>
		</div>
	</div>
</div>
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
if (window.addEventListener) window.addEventListener("load", leave, false);
else if (window.attachEvent) window.attachEvent("onload", leave);
else window.onload = leave;
// 회원 탈퇴
function leave() {
	$('.leaveWrap').hide();
	// 비밀번호 확인
	$('#acceptBtn').click(function(e) {
		e.preventDefault();
		// 비밀번호 체크
		if ($.trim($('#siiru-leaveForm').find('input[name="passwd"]').val()) == '') {
			alert('비밀번호를 입력해 주세요.');
			$('#siiru-leaveForm').find('input[name="passwd"]').focus();
		} else {
			$.post('<c:out value="${path.context}" />leaveAction.do', $('#siiru-leaveForm').serialize()).done(function(data) {
				if (data.error == 'N') {
					$('.leaveForm').hide();
					$('.leaveWrap').show();
				} else {
					alert(data.errorMsg);
				}
			});
		}
		return false;
	});
<c:if test="${snsUser eq 'Y'}">
	// SNS 회원탈퇴
	$('#leaveBtn').click(function(e) {
		e.preventDefault();
		if (confirm('회원탈퇴를 진행하시겠습니까?')) {
			$.post('<c:out value="${path.context}" />leaveAction.do', {'action':'S','pageId':'<c:out value="${param.pageId}" />'}).done(function(data) {
				if (data.error == 'N') {
					$('.leaveForm').hide();
					$('.leaveWrap').show();
				} else {
					alert(data.errorMsg);
				}
			});
		}
	});
</c:if>
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
				certUrl = '<c:out value="${path.context}" />mobileidView.do?pageId=<c:out value="${param.pageId}" />&taskSe=S&userSe=X';
			} else {
				certUrl = '<c:out value="${path.context}" />certRequest.do?pageId=<c:out value="${param.pageId}" />&pageSe=S&certType='+certType;
				if (certType == 'DOP') certUrl+= '&serviceType='+$(this).data('servicetype');
			}
			// 윈도우 오픈
			openWindow(certUrl,certType+'CertWindow',top,left,w,h,'yes','no');
		}
	});
</c:if>
	// 메인 버튼
	$('#mainBtn').click(function(e) {
		window.document.location.href = '<c:out value="${path.sContext}" />';
	});
}
<c:if test="${certAt eq 'Y'}">
// 본인인증
function certResponse() {
	$.post('<c:out value="${path.context}" />leaveAction.do', {'action':'C','pageId':'<c:out value="${param.pageId}" />'}).done(function(data) {
		if (data.error == 'N') {
			$('.leaveForm').hide();
			$('.leaveWrap').show();
		} else {
			alert(data.errorMsg);
		}
	});
}
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
				url: '<c:out value="${path.context}" />easyResult.do?taskSe=X',
				dataType: 'json',
				contentType: 'application/json; charset=utf-8',
				data: data,
				success: function(data) {
					if (data.error == 'N') {
						certResponse();
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
</script>
