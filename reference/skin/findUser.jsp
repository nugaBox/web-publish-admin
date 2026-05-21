<div class="siiru-findUserWrap">
	<div class="findUserWrap">
		<h4>아이디/비밀번호 찾기</h4>
		<div class="findUser-tab">
			<ul>
				<li data-tp="I"><a href="#" data-pagetp="I">아이디 찾기</a></li>
				<li data-tp="P"><a href="#" data-pagetp="P">비밀번호 찾기</a></li>
				<li data-tp="R"><a href="#" data-pagetp="R">로그인 잠금 초기화</a></li>
			</ul>
		</div>
		<section id="I">
			<div class="retIdMsg"></div>
			<div class="findLayer">
				<c:if test="${certAt eq 'Y'}">
				<div class="certWrap">
					<h5>본인인증을 통한 찾기</h5>
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
					<p class="info">간편인증/모바일신분증을 이용하기 위해서는 회원으로 가입되어있어야 합니다.<br>(비회원은 간편인증/모바일신분증을 사용하실 수 없습니다.)<p>
				</div>
				</c:if>
				<div class="inputWrap">
					<form name="siiru-findIdForm" id="siiru-findIdForm" method="post">
					<input type="hidden" name="action" value="I">
					<input type="hidden" name="siteId" value="<c:out value="${site.siteId}" />">
					<input type="hidden" name="pageId" value="<c:out value="${param.pageId}" />">
					<h5>가입정보로 찾기</h5>
					<dl>
						<dt><label for="userNm_I">이름</label></dt>
						<dd><input type="text" class="small" id="userNm_I" name="userNm" value=""></dd>
					</dl>
					<dl>
						<dt><label for="brthdy_I">생년월일</label></dt>
						<dd><input type="text" id="brthdy_I" name="brthdy" class="maskDate nothangul" maxlength="10" value=""></dd>
					</dl>
					<dl>
						<dt><label for="email_I">이메일</label></dt>
						<dd><input type="text" id="email_I" name="email" value=""></dd>
					</dl>
					</form>
					<div class="siiru-btnSet siiru-tc">
						<button type="submit" id="findIdSubmit" class="siiru-btn siiru-btn-primary">아이디 찾기</button>
					</div>
				</div>
			</div>
		</section>
		<section id="P">
			<div class="retPassMsg"></div>
			<div class="findLayer">
				<c:if test="${certAt eq 'Y'}">
				<div class="certWrap">
					<h5>본인인증을 통한 찾기</h5>
					<div class="kindBoxWrap">
						<dl>
							<dt><label for="userId_C">아이디</label></dt>
							<dd><input type="text" id="userId_C" name="userId" value="" class="small alphanumId"></dd>
						</dl>
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
					<p class="info">간편인증/모바일신분증을 이용하기 위해서는 회원으로 가입되어있어야 합니다.<br>(비회원은 간편인증/모바일신분증을 사용하실 수 없습니다.)<p>
				</div>
				</c:if>
				<div class="inputWrap">
					<form name="siiru-findPassForm" id="siiru-findPassForm" method="post">
					<input type="hidden" name="action" value="P">
					<input type="hidden" name="sendAt" value="N">
					<input type="hidden" name="siteId" value="<c:out value="${site.siteId}" />">
					<input type="hidden" name="pageId" value="<c:out value="${param.pageId}" />">
					<h5>가입정보로 찾기</h5>
					<dl>
						<dt><label for="userId_P">아이디</label></dt>
						<dd><input type="text" id="userId_P" name="userId" value="" class="small alphanumId"></dd>
					</dl>
					<dl>
						<dt><label for="userNm_P">이름</label></dt>
						<dd><input type="text" id="userNm_P" name="userNm" value="" class="small"></dd>
					</dl>
					<dl>
						<dt><label for="brthdy_P">생년월일</label></dt>
						<dd><input type="text" id="brthdy_P" name="brthdy" class="maskDate nothangul" maxlength="10" value=""></dd>
					</dl>
					<dl>
						<dt><label for="email_P">이메일</label></dt>
						<dd><input type="text" id="email_P" name="email" value=""></dd>
					</dl>
					</form>
					<div class="siiru-btnSet siiru-tc">
						<button type="submit" id="findPassSubmit" class="siiru-btn siiru-btn-primary">비밀번호 찾기</button>
					</div>
				</div>
			</div>
		</section>
		<section id="R">
			<div class="retInitMsg"></div>
			<div class="findLayer">
				<c:if test="${certAt eq 'Y'}">
				<div class="certWrap">
					<h5>본인인증을 통한 초기화</h5>
					<div class="kindBoxWrap">
						<dl>
							<dt><label for="userId_RC">아이디</label></dt>
							<dd><input type="text" id="userId_RC" name="userId" value="" class="small alphanumId"></dd>
						</dl>
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
					<p class="info">간편인증/모바일신분증을 이용하기 위해서는 회원으로 가입되어있어야 합니다.<br>(비회원은 간편인증/모바일신분증을 사용하실 수 없습니다.)<p>
				</div>
				</c:if>
				<div class="inputWrap">
					<form name="siiru-findInitForm" id="siiru-findInitForm" method="post">
					<input type="hidden" name="action" value="R">
					<input type="hidden" name="siteId" value="<c:out value="${site.siteId}" />">
					<input type="hidden" name="pageId" value="<c:out value="${param.pageId}" />">
					<h5>가입정보로 초기화</h5>
					<dl>
						<dt><label for="userId_R">아이디</label></dt>
						<dd><input type="text" id="userId_R" name="userId" value="" class="small alphanumId"></dd>
					</dl>
					<dl>
						<dt><label for="userNm_R">이름</label></dt>
						<dd><input type="text" id="userNm_R" name="userNm" value="" class="small"></dd>
					</dl>
					<dl>
						<dt><label for="brthdy_R">생년월일</label></dt>
						<dd><input type="text" id="brthdy_R" name="brthdy" class="maskDate nothangul" maxlength="10" value=""></dd>
					</dl>
					<dl>
						<dt><label for="email_R">이메일</label></dt>
						<dd><input type="text" id="email_R" name="email" value=""></dd>
					</dl>
					</form>
					<div class="siiru-btnSet siiru-tc">
						<button type="submit" id="findInitSubmit" class="siiru-btn siiru-btn-primary">로그인 잠금 초기화</button>
					</div>
				</div>
			</div>
		</section>
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
if (window.addEventListener) window.addEventListener("load", findUser, false);
else if (window.attachEvent) window.attachEvent("onload", findUser);
else window.onload = findUser;
// 아이디/비밀번호 찾기 구분값
var liTab = 'I';
function findUser() {
	// 탭
	$('.findUser-tab li a').click(function(e) {
		e.preventDefault();
		$(this).parent().addClass('active');
		$(this).parent().siblings('li').removeClass('active');
		$('#'+$(this).data('pagetp')).css('display','block');
		$('#'+$(this).data('pagetp')).siblings('section').css('display','none');
		liTab = $(this).data('pagetp');
		$('.retIdMsg').hide();
		$('.retPassMsg').hide();
		$('.retInitMsg').hide();
	});
	$('.findUser-tab li[data-tp="'+liTab+'"] a').trigger('click');
	// 아이디 찾기
	$('#findIdSubmit').click(function(e) {
		e.preventDefault();
		$('.retIdMsg').hide();
		$idForm = $('#siiru-findIdForm');
		if ($.trim($idForm.find('input[name="userNm"]').val()) == '') {
			alert('이름을 입력해 주세요.');
			$idForm.find('input[name="userNm"]').focus();
		} else if (($.trim($idForm.find('input[name="brthdy"]').val()) != '') && (!ValidDate($.trim($idForm.find('input[name="brthdy"]').val())))) {
			alert('생년월일 : 잘못된 날짜 형식입니다.');
			$idForm.find('input[name="brthdy"]').focus();
		} else if ($.trim($idForm.find('input[name="email"]').val()) == '') {
			alert('이메일을 입력해 주세요.');
			$idForm.find('input[name="email"]').focus();
		} else if (($.trim($idForm.find('input[name="email"]').val()) != '') && (!ValidEmail($.trim($idForm.find('input[name="email"]').val())))) {
			alert('이메일 : 잘못된 이메일 형식입니다.');
			$idForm.find('input[name="email"]').focus();
		} else {
			$.post('<c:out value="${path.context}" />findUserAction.do', $idForm.serialize()).done(function(data) {
				if (data.error == 'N') {
					var confm = '';
					if ($.trim(data.confmDt) == 'N') confm = '<br>관리자 <span>&quot;승인 대기&quot;</span> 상태입니다.';
					$('.retIdMsg').html('<span>'+$.trim(data.userNm)+'</span>님의 아이디는 <span>&quot;'+$.trim(data.userId)+'&quot;</span> 입니다.'+confm);
					$idForm.find('input[name="userNm"]').val('');
					$idForm.find('input[name="brthdy"]').val('');
					$idForm.find('input[name="email"]').val('');
				} else {
					$('.retIdMsg').html('<span class="text-danger">'+$.trim(data.errorMsg)+'</span>');
				}
				$('.retIdMsg').show();
			});
		}
		return false;
	});
	// 비밀번호 찾기
	$('#findPassSubmit').click(function(e) {
		e.preventDefault();
		$('.retPassMsg').hide();
		$passForm = $('#siiru-findPassForm');
		if ($.trim($passForm.find('input[name="userId"]').val()) == '') {
			alert('아이디를 입력해 주세요.');
			$passForm.find('input[name="userId"]').focus();
		} else if ($.trim($passForm.find('input[name="userNm"]').val()) == '') {
			alert('이름을 입력해 주세요.');
			$passForm.find('input[name="userNm"]').focus();
		} else if (($.trim($passForm.find('input[name="brthdy"]').val()) != '') && (!ValidDate($.trim($passForm.find('input[name="brthdy"]').val())))) {
			alert('생년월일 : 잘못된 날짜 형식입니다.');
			$passForm.find('input[name="brthdy"]').focus();
		} else if ($.trim($passForm.find('input[name="email"]').val()) == '') {
			alert('이메일을 입력해 주세요.');
			$passForm.find('input[name="email"]').focus();
		} else if (($.trim($passForm.find('input[name="email"]').val()) != '') && (!ValidEmail($.trim($passForm.find('input[name="email"]').val())))) {
			alert('이메일 : 잘못된 이메일 형식입니다.');
			$passForm.find('input[name="email"]').focus();
		} else {
			$.post('<c:out value="${path.context}" />findUserAction.do', $passForm.serialize()).done(function(data) {
				if (data.error == 'N') {
					if ($.trim($passForm.find('input[name="sendAt"]').val()) == 'N') {
						$('.retPassMsg').html('<span>'+$.trim(data.userNm)+'</span>님의 임시 비밀번호는 <span>&quot;'+$.trim(data.newPasswd)+'&quot;</span> 입니다.<br>임시로 발급 받으신 비밀번호로 로그인한 후, 새로운 비밀번호로 변경하시기 바랍니다.');
					} else {
						$('.retPassMsg').html('<span>'+$.trim(data.userNm)+'</span>님의 비밀번호를 <span>'+$.trim(data.email)+'</span>로 전송 했습니다.');
					}
					$passForm.find('input[name="userId"]').val('');
					$passForm.find('input[name="userNm"]').val('');
					$passForm.find('input[name="brthdy"]').val('');
					$passForm.find('input[name="email"]').val('');
				} else {
					$('.retPassMsg').html('<span class="text-danger">'+$.trim(data.errorMsg)+'</span>');
				}
				$('.retPassMsg').show();
			});
		}
		return false;
	});
	// 로그인 잠금 초기화
	$('#findInitSubmit').click(function(e) {
		e.preventDefault();
		$('.retInitMsg').hide();
		$initForm = $('#siiru-findInitForm');
		if ($.trim($initForm.find('input[name="userId"]').val()) == '') {
			alert('아이디를 입력해 주세요.');
			$initForm.find('input[name="userId"]').focus();
		} else if ($.trim($initForm.find('input[name="userNm"]').val()) == '') {
			alert('이름을 입력해 주세요.');
			$initForm.find('input[name="userNm"]').focus();
		} else if (($.trim($initForm.find('input[name="brthdy"]').val()) != '') && (!ValidDate($.trim($initForm.find('input[name="brthdy"]').val())))) {
			alert('생년월일 : 잘못된 날짜 형식입니다.');
			$initForm.find('input[name="brthdy"]').focus();
		} else if ($.trim($initForm.find('input[name="email"]').val()) == '') {
			alert('이메일을 입력해 주세요.');
			$initForm.find('input[name="email"]').focus();
		} else if (($.trim($initForm.find('input[name="email"]').val()) != '') && (!ValidEmail($.trim($initForm.find('input[name="email"]').val())))) {
			alert('이메일 : 잘못된 이메일 형식입니다.');
			$initForm.find('input[name="email"]').focus();
		} else {
			$.post('<c:out value="${path.context}" />findUserAction.do', $initForm.serialize()).done(function(data) {
				if (data.error == 'N') {
					$('.retInitMsg').html('<span>'+$.trim(data.userNm)+'</span>님의 로그인 잠김을 성공적으로 초기화 했습니다.<br>비밀번호를 잃어버리셨다면 비밀번호 찾기를 이용해 주세요.');
					$initForm.find('input[name="userId"]').val('');
					$initForm.find('input[name="userNm"]').val('');
					$initForm.find('input[name="brthdy"]').val('');
					$initForm.find('input[name="email"]').val('');
				} else {
					$('.retInitMsg').html('<span class="text-danger">'+$.trim(data.errorMsg)+'</span>');
				}
				$('.retInitMsg').show();
			});
		}
		return false;
	});
<c:if test="${certAt eq 'Y'}">
	// 실명인증
	$('.stepCate button').click(function() {
		var openAt = true;
		$('.retIdMsg').hide();
		$('.retPassMsg').hide();
		$('.retInitMsg').hide();
		// 비밀번호 찾기
		if (liTab == 'P') {
			if ($.trim($('#userId_C').val()) == '') {
				alert('아이디를 입력해 주세요.');
				$('#userId_C').focus();
				openAt = false;
			}
		// 로그인잠금 초기화
		} else if (liTab == 'R') {
			if ($.trim($('#userId_RC').val()) == '') {
				alert('아이디를 입력해 주세요.');
				$('#userId_RC').focus();
				openAt = false;
			}
		}
		if (openAt) {
			var certType = $.trim($(this).data('certtype'));
			var w = 480, h = 812;
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
					certUrl = '<c:out value="${path.context}" />mobileidView.do?pageId='+$.trim($('#siiru-findIdForm').find('input[name="pageId"]').val())+'&taskSe=S&userSe='+liTab;
				} else {
					certUrl = '<c:out value="${path.context}" />certRequest.do?pageId='+$.trim($('#siiru-findIdForm').find('input[name="pageId"]').val())+'&pageSe=S&certType='+certType;
					if (certType == 'DOP') certUrl+= '&serviceType='+$(this).data('servicetype');
				}
				// 윈도우 오픈
				openWindow(certUrl,certType+'CertWindow',top,left,w,h,'yes','no');
			}
		}
	});
</c:if>
}
<c:if test="${certAt eq 'Y'}">
// 본인인증
function certResponse() {
	var msgView = '.retIdMsg';
	var userId = '';
	if (liTab == 'P') {
		msgView = '.retPassMsg';
		userId = $.trim($('#userId_C').val());
	} else if (liTab == 'R') {
		msgView = '.retInitMsg';
		userId = $.trim($('#userId_RC').val());
	}
	$.post('<c:out value="${path.context}" />findUserAction.do', {'action':'C'+liTab,'pageId':$.trim($('#siiru-findIdForm').find('input[name="pageId"]').val()),'sendAt':$.trim($('#siiru-findPassForm').find('input[name="sendAt"]').val()),'userId':userId}).done(function(data) {
		if (data.error == 'N') {
			if (liTab == 'P') {
				if ($.trim($('#siiru-findPassForm').find('input[name="sendAt"]').val()) == 'N') {
					$(msgView).html('<span>'+$.trim(data.userNm)+'</span>님의 임시 비밀번호는 <span>&quot;'+$.trim(data.newPasswd)+'&quot;</span> 입니다.<br>임시로 발급 받으신 비밀번호로 로그인한 후, 새로운 비밀번호로 변경하시기 바랍니다.');
				} else {
					$(msgView).html('<span>'+$.trim(data.userNm)+'</span>님의 비밀번호를 <span>'+$.trim(data.email)+'</span>로 전송 했습니다.');
				}
			} else if (liTab == 'R') {
				$(msgView).html('<span>'+$.trim(data.userNm)+'</span>님의 로그인 잠김을 성공적으로 초기화 했습니다.<br>비밀번호를 잃어버리셨다면 비밀번호 찾기를 이용해 주세요.');
			} else {
				$(msgView).html('<span>'+$.trim(data.userNm)+'</span>님의 아이디는 <span>&quot;'+$.trim(data.userId)+'&quot;</span> 입니다.');
			}
		} else {
			$(msgView).html('<span class="text-danger">'+$.trim(data.errorMsg)+'</span>');
		}
		$('#userId_C').val('');
		$('#userId_RC').val('');
		$(msgView).show();
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
				url: '<c:out value="${path.context}" />easyResult.do?taskSe='+liTab,
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
