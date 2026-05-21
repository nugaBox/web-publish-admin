<c:set var="stepTitle" value="" />
<div class="siiru-joinWrap">
	<div class="stepTab">
		<ul>
		<%-- 회원단계 --%>
		<c:forEach var="code" items="${stepList}" varStatus="status">
			<%-- 단계 타이틀 셋팅 --%>
			<c:if test="${stepLevel eq code.codeId}"><c:set var="stepTitle" value="STEP${(status.index+1)} ${code.codeNm}" /></c:if>
			<%-- 단계 표출 --%>
			<li data-step="<c:out value="${code.codeId}" />"<c:if test="${stepLevel eq code.codeId}"> class="active"</c:if>><a href="#">STEP<c:out value="${(status.index+1)}" />&nbsp;&nbsp;<strong><c:out value="${code.codeNm}" /></strong></a></li>
		</c:forEach>
		</ul>
	</div>
	<section>
		<form id="siiru-joinForm" name="siiru-joinForm" method="post" enctype="multipart/form-data" action="<c:out value="${path.sContext}" />join.do?pageId=<c:out value="${param.pageId}" />">
		<input type="hidden" id="stepLevel" name="stepLevel" value="<c:out value="${stepLevel}" />">
		<input type="hidden" id="userKind" name="userKind" value="<c:out value="${userKind}" />">
<c:choose>
	<%-- 1단계 가입안내 --%>
	<c:when test="${stepLevel eq 'S1'}">
		<h5 class="stepTitle"><c:out value="${stepTitle}" /> <small>회원가입 전 안내 사항을 확인해 주세요.</small></h5>
		<div class="joinWelcome" style="background:#f8f9fa;border:1px solid #dee2e6;border-radius:6px;padding:30px 36px;margin:20px 0;line-height:2;">
			<p style="margin:0 0 8px;font-size:1.05em;font-weight:600;">호남노회 홈페이지에 오신 것을 환영합니다.</p>
			<p style="margin:0 0 8px;">노회원만 가입이 가능하며, 가입 후 관리자(노회 서기)의 승인 후 이용하실 수 있습니다.</p>
			<p style="margin:0;">감사합니다.</p>
		</div>
		<div class="siiru-btnSet siiru-tc" style="margin-top:24px;">
			<button type="button" class="siiru-btn siiru-btn-primary joinStartBtn">가입하기</button>
		</div>
	</c:when>
	<%-- 2단계 회원약관동의 --%>
	<c:when test="${stepLevel eq 'S2'}">
		<h5 class="stepTitle"><c:out value="${stepTitle}" /></h5>
		<div class="agreeBoxWrap">
			<p class="stepSubTitle">회원가입약관 동의</p>
			<div class="agreeBox" style="height:80px;overflow-y:auto;font-size:0.88em;line-height:1.7;">
				<strong>제1조 (목적)</strong><br>
				이 약관은 대한예수교장로회(합동) 호남노회(이하 "노회")가 운영하는 홈페이지(이하 "사이트")가 제공하는 인터넷 관련 서비스의 이용 조건 및 절차에 관한 사항과 기타 필요한 사항을 규정함을 목적으로 합니다.<br><br>
				<strong>제2조 (회원의 정의)</strong><br>
				"회원"이라 함은 노회원으로서 본 사이트에 회원가입 신청을 하여 관리자(노회 서기)의 승인을 받은 자를 말합니다.<br><br>
				<strong>제3조 (가입 자격)</strong><br>
				본 사이트의 회원가입은 노회 소속 교역자 및 노회원에 한하며, 허위 정보 제공 시 가입이 취소될 수 있습니다.<br><br>
				<strong>제4조 (이용 제한)</strong><br>
				다음 각 호에 해당하는 경우 이용이 제한될 수 있습니다.<br>
				1. 타인의 정보를 도용하거나 허위 정보를 등록한 경우<br>
				2. 사이트의 정상적인 운영을 방해한 경우<br>
				3. 노회원 자격을 상실한 경우<br><br>
				<strong>제5조 (서비스 이용)</strong><br>
				회원은 관리자의 승인 후 공지사항, 자료실, 게시판 등 홈페이지에서 제공하는 서비스를 이용할 수 있습니다.
			</div>
			<p class="agreeCheck">
				<input type="checkbox" id="agree1" name="agree1" value="Y">
				<label for="agree1"> 회원약관에 동의합니다.</label>
			</p>
			<p class="stepSubTitle">개인정보보호방침 및 이용약관 동의</p>
			<div class="agreeBox" style="height:80px;overflow-y:auto;font-size:0.88em;line-height:1.7;">
				<strong>제1조 (수집하는 개인정보 항목)</strong><br>
				노회 홈페이지는 회원가입 시 아이디, 비밀번호, 이름, 이메일, 모바일번호 등의 개인정보를 수집합니다.<br><br>
				<strong>제2조 (개인정보 수집 및 이용 목적)</strong><br>
				수집된 개인정보는 회원 관리, 서비스 제공, 공지사항 전달 등의 목적으로만 이용되며, 목적 외 용도로 사용하지 않습니다.<br><br>
				<strong>제3조 (개인정보 보유 및 이용 기간)</strong><br>
				회원 탈퇴 시 또는 개인정보 수집 및 이용 목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 단, 관련 법령에 의한 경우는 예외로 합니다.<br><br>
				<strong>제4조 (개인정보 제3자 제공)</strong><br>
				노회는 이용자의 개인정보를 원칙적으로 외부에 제공하지 않습니다. 다만, 이용자의 동의가 있거나 법률에 특별한 규정이 있는 경우에는 예외로 합니다.<br><br>
				<strong>제5조 (개인정보보호 문의)</strong><br>
				개인정보 처리에 관한 문의사항은 노회 서기에게 연락하시기 바랍니다.
			</div>
			<p class="agreeCheck">
				<input type="checkbox" id="agree2" name="agree2" value="Y">
				<label for="agree2"> 개인정보보호방침에 동의합니다.</label>
			</p>
		</div>
		<div class="siiru-btnSet siiru-tc">
			<button type="button" id="agreeAllBtn" class="siiru-btn siiru-btn-default">모두 동의</button>
			<button type="button" id="joinSubmit" class="siiru-btn siiru-btn-primary siiru-ml10">다음단계</button>
			<button type="button" id="cancelBtn" class="siiru-btn siiru-btn-default siiru-ml10">취소</button>
		</div>
	</c:when>
	<%-- 3단계 본인인증 (설정안됨 — 이 단계는 진입하지 않음) --%>
	<c:when test="${stepLevel eq 'S3'}">
		<c:choose>
			<%-- 이미 가입된 회원 --%>
			<c:when test="${userData.certTypeAt eq 'Y'}">
			<h5 class="stepTitle"><c:out value="${stepTitle}" /></h5>
			<div class="complete"><p>이미 가입된 회원입니다.</p></div>
			<div class="siiru-btnSet siiru-tc">
				<button type="button" id="joinBtn" class="siiru-btn siiru-btn-primary">메인</button>
				<button type="button" id="loginBtn" class="siiru-btn siiru-btn-default siiru-ml10">로그인</button>
			</div>
			</c:when>
			<c:otherwise>
			<p class="well">
				익명 사용자로 인한 피해를 방지하기 위하여 본인확인 절차가 필요하오니, 성명과 핸드폰번호를 입력해 주시기 바랍니다.<br>
				팝업창이 나타나지 않으면 브라우저의 팝업차단을 해제해 주시기 바랍니다.
			</p>
			<h5 class="stepTitle"><c:out value="${stepTitle}" /></h5>
			<div class="kindBoxWrap">
				<input type="hidden" id="selfAt" name="selfAt" value="N">
				<input type="hidden" id="parentsAt" name="parentsAt" value="N">
				<p class="well siiru-tl">
			<c:choose>
				<c:when test="${userKind eq 'A'}">
					내국인(일반) 회원<br>
					- 본인인증 방법을 선택해 주세요.<br>
				</c:when>
				<c:when test="${userKind eq 'C'}">
					내국인(어린이)회원<br>
					- 어린이 회원(만 14세 미만)은 보호자의 동의 절차가 필요합니다.<br>
					- 어린이 회원의 본인 인증 방법을 선택해 주세요.<br>
				</c:when>
				<c:when test="${userKind eq 'F'}">
					외국인 회원<br>
					- 본인인증 방법을 선택해 주세요.<br>
				</c:when>
			</c:choose>
					- 본인인증 방법 선택 후 팝업창이 나타나지 않으면 브라우저의 팝업차단을 해제해 주시기 바랍니다.
				</p>
				<div class="certLayer">
					<div class="kindBox">
						<div class="stepCate">
							<p>휴대폰인증</p>
							<small>&nbsp;</small>
							<button type="button" class="siiru-btn" data-certkind="<c:out value="${userKind}" />" data-certtype="NICE">인증하기</button>
						</div>
					</div>
					<div class="kindBox">
						<div class="stepCate">
							<p>아이핀(I-PIN)</p>
							<small>&nbsp;</small>
							<button type="button" class="siiru-btn" data-certkind="<c:out value="${userKind}" />" data-certtype="NICEIPIN">인증하기</button>
						</div>
					</div>
					<c:if test="${userKind ne 'C'}">
					<div class="kindBox">
						<div class="stepCate">
							<p>모바일신분증</p>
							<small>&nbsp;</small>
							<button type="button" class="siiru-btn" data-certkind="<c:out value="${userKind}" />" data-certtype="MOBILEID">인증하기</button>
						</div>
					</div>
					</c:if>
				</div>
			<c:if test="${userKind eq 'C'}">
				<p class="well siiru-tl">
					내국인(어린이)회원 보호자<br>
					- 보호자의 본인 인증 방법을 선택해 주세요.<br>
					- 본인인증 방법 선택 후 팝업창이 나타나지 않으면 브라우저의 팝업차단을 해제해 주시기 바랍니다.
				</p>
				<div class="parentsLayer">
					<div class="kindBox">
						<div class="stepCate">
							<p>휴대폰인증</p>
							<small>&nbsp;</small>
							<button type="button" class="siiru-btn" data-certkind="P" data-certtype="NICE">인증하기</button>
						</div>
					</div>
					<div class="kindBox">
						<div class="stepCate">
							<p>아이핀(I-PIN)</p>
							<small>&nbsp;</small>
							<button type="button" class="siiru-btn" data-certkind="P" data-certtype="NICEIPIN">인증하기</button>
						</div>
					</div>
					<div class="kindBox">
						<div class="stepCate">
							<p>모바일신분증</p>
							<small>&nbsp;</small>
							<button type="button" class="siiru-btn" data-certkind="P" data-certtype="MOBILEID">인증하기</button>
						</div>
					</div>
				</div>
			</c:if>
			</div>
			<div class="siiru-btnSet siiru-tc">
				<button type="button" id="prevBtn" class="siiru-btn siiru-btn-default">이전단계</button>
				<button type="button" id="cancelBtn" class="siiru-btn siiru-btn-default siiru-ml10">취소</button>
			</div>
			</c:otherwise>
		</c:choose>
	</c:when>
	<%-- 4단계 개인정보입력 --%>
	<c:when test="${stepLevel eq 'S4'}">
		<p class="well">
			회원가입에 필요한 필수 정보를 입력하는 폼입니다.<br>
			아래의 (*)는 필수입력사항 입니다.
		</p>
		<h5 class="stepTitle"><c:out value="${stepTitle}" /></h5>
		<div class="joinForm-write">
			<dl>
				<dt><span class="required">*</span> <label for="userId">아이디</label></dt>
				<dd>
					<input type="text" class="small2 alphanumId nothangul" id="userId" name="userId" maxlength="50" value="">
					<button type="button" class="idCheck siiru-btn siiru-btn-small siiru-ml10"> 아이디 중복확인 </button>
				</dd>
			</dl>
		<c:if test="${userData.passwdChk eq 'Y'}">
			<dl>
				<dt><span class="required">*</span> <label for="passwd">비밀번호</label></dt>
				<dd>
					<input type="password" class="small2 alphanumPass nothangul" id="passwd" name="passwd" maxlength="20" autocomplete="off" value="">
					<small>영문,숫자,특수문자(!@#$%^?*+=_~- 만 허용)를 혼합하여 8~20자 이내</small>
				</dd>
			</dl>
			<dl>
				<dt><span class="required">*</span> <label for="passwdConfirm">비밀번호 확인</label></dt>
				<dd><input type="password" class="small2 alphanumPass nothangul" id="passwdConfirm" name="passwdConfirm" maxlength="20" autocomplete="off" value=""></dd>
			</dl>
		</c:if>
			<dl>
				<dt><span class="required">*</span> <label for="userNm">이름</label></dt>
				<dd>
					<input type="text" class="small2 siiru-mr10" id="userNm" name="userNm" maxlength="50" value="<c:out value="${userData.userNm}" />"${readonly}>
					<input type="hidden" name="sex" value="<c:out value="${userData.sex}" />">
				<c:forEach var="code" items="${sexList}">
					<input type="radio" id="sex_<c:out value="${code.codeId}" />" name="sex" value="<c:out value="${code.codeId}" />"<c:out value="${code.checked}" />>
					<label for="sex_<c:out value="${code.codeId}" />"> <c:out value="${code.codeNm}" /> </label>
				</c:forEach>
				</dd>
			</dl>
			<dl>
				<dt><label for="ncnm">닉네임</label></dt>
				<dd><input type="text" class="small2 siiru-mr10" id="ncnm" name="ncnm" maxlength="50" value="<c:out value="${userData.ncnm}" />"></dd>
			</dl>
			<dl>
				<dt><label for="brthdy">생년월일</label></dt>
				<dd>
					<input type="text" class="maskDate nothangul small siiru-mr10" id="brthdy" name="brthdy" maxlength="10" value="<c:out value="${userData.brthdy}" />"${readonly}>
				<c:forEach var="code" items="${lunSolList}">
					<input type="radio" id="lunSol_<c:out value="${code.codeId}" />" name="lunSol" value="<c:out value="${code.codeId}" />"<c:out value="${code.checked}" />>
					<label for="lunSol_<c:out value="${code.codeId}" />"> <c:out value="${code.codeNm}" /> </label>
				</c:forEach>
				</dd>
			</dl>
			<dl>
				<dt><label for="agrde">연령대</label></dt>
				<dd>
					<select id="agrde" name="agrde" class="siiru-mt0" title="연령대">
						<option value="">연령대 선택</option>
						<c:forEach var="code" items="${agrdeList}">
							<option value="<c:out value="${code.codeId}" />"<c:out value="${code.selected}" />><c:out value="${code.codeNm}" /></option>
						</c:forEach>
					</select>
				</dd>
			</dl>
			<dl>
				<dt><span class="required">*</span> <label for="email">이메일</label></dt>
				<dd><input type="text" id="email" name="email" maxlength="50" value="<c:out value="${userData.email}" />"<c:if test="${not empty userData.email}"> readonly</c:if>></dd>
			</dl>
			<dl>
				<dt><label for="telno">전화번호</label></dt>
				<dd><input type="text" class="small2 nothangul" id="telno" name="telno" maxlength="30" value=""></dd>
			</dl>
			<dl>
				<dt><span class="required">*</span> <label for="mbtlnum">모바일번호</label></dt>
				<dd><input type="text" class="small2 telText nothangul" id="mbtlnum" name="mbtlnum" maxlength="14" value="<c:out value="${userData.mbtlnum}" />"<c:if test="${not empty userData.mbtlnum}"> readonly</c:if>></dd>
			</dl>
			<dl>
				<dt><label for="zip">주소</label></dt>
				<dd>
					<input type="text" class="small telText nothangul" id="zip" name="zip" maxlength="7" value="" title="우편번호">
					<button type="button" class="zipFind siiru-btn siiru-btn-small siiru-ml10"> 우편번호 찾기 </button>
					<input type="text" class="siiru-mt5" id="addr" name="addr" maxlength="50" value="" title="주소">
					<input type="text" class="siiru-mt5" id="detailAddr" name="detailAddr" maxlength="50" value="" title="상세주소">
				</dd>
			</dl>
			<dl>
				<dt><span class="label">지역</span></dt>
				<dd>
					<input type="hidden" id="areaCode" name="areaCode" value="">
					<select id="ctprvn" name="ctprvn" class="areaSelect" data-arease="C" title="시/도">
						<option value="">시/도 선택</option>
					<c:forEach var="code" items="${ctprvnList}">
						<option value="<c:out value="${code.areaCode}" />"<c:out value="${code.selected}" />><c:out value="${code.areaNm}" /></option>
					</c:forEach>
					</select>
					<select id="signgu" name="signgu" class="areaSelect siiru-ml10" data-arease="S" title="시/군/구">
						<option value="">시/군/구 선택</option>
					<c:forEach var="code" items="${signguList}">
						<option value="<c:out value="${code.areaCode}" />"<c:out value="${code.selected}" />><c:out value="${code.areaNm}" /></option>
					</c:forEach>
					</select>
					<select id="emd" name="emd" class="areaSelect siiru-ml10" data-arease="D" title="읍/면/동">
						<option value="">읍/면/동 선택</option>
					<c:forEach var="code" items="${emdList}">
						<option value="<c:out value="${code.areaCode}" />"<c:out value="${code.selected}" />><c:out value="${code.areaNm}" /></option>
					</c:forEach>
					</select>
					<c:if test="${areaTy eq 'L'}">
					<select id="dongli" name="dongli" class="areaSelect siiru-ml10" data-arease="L" title="리">
						<option value="">리 선택</option>
					<c:forEach var="code" items="${dongliList}">
						<option value="<c:out value="${code.areaCode}" />"<c:out value="${code.selected}" />><c:out value="${code.areaNm}" /></option>
					</c:forEach>
					</select>
					</c:if>
				</dd>
			</dl>
			<dl>
				<dt><span class="label">메일링유무</span></dt>
				<dd>
				<c:forEach var="code" items="${emailAtList}">
					<input type="radio" id="emailAt_<c:out value="${code.codeId}" />" name="emailAt" value="<c:out value="${code.codeId}" />"<c:out value="${code.checked}" />>
					<label for="emailAt_<c:out value="${code.codeId}" />"> <c:out value="${code.codeNm}" /> </label>
				</c:forEach>
				</dd>
			</dl>
			<dl>
				<dt><span class="label">SMS 수신여부</span></dt>
				<dd>
				<c:forEach var="code" items="${smsAtList}">
					<input type="radio" id="smsAt_<c:out value="${code.codeId}" />" name="smsAt" value="<c:out value="${code.codeId}" />"<c:out value="${code.checked}" />>
					<label for="smsAt_<c:out value="${code.codeId}" />"> <c:out value="${code.codeNm}" /> </label>
				</c:forEach>
				</dd>
			</dl>
			<dl>
				<dt><span class="label">프로필 이미지</span></dt>
				<dd>
				<c:forEach var="code" items="${proflSeList}">
					<input type="radio" id="proflSe_<c:out value="${code.codeId}" />" name="proflSe" value="<c:out value="${code.codeId}" />"<c:out value="${code.checked}" />>
					<label for="proflSe_<c:out value="${code.codeId}" />"> <c:out value="${code.codeNm}" /> </label>
				</c:forEach>
					<input type="text" id="proflUrl" name="proflUrl" maxlength="150" class="siiru-mt10" value="" title="프로필 링크 URL" placeholder="http://" disabled>
					<input type="file" accept="image/*" id="proflImage" name="proflImage" class="file siiru-mt10" title="프로필 이미지">
				</dd>
			</dl>
	<c:if test="${not empty userItem && fn:length(userItem) > 0}">
		<c:forEach var="item" items="${userItem}" varStatus="status">
			<dl id="cFocus_<c:out value="${item.iemId}" />">
				<dt><c:if test="${item.reqrdAt eq 'Y'}" ><span class="required">*</span> </c:if>
				<c:choose>
					<c:when test="${item.iemSe eq 'T' || item.iemSe eq 'U' || item.iemSe eq 'S' || item.iemSe eq 'D' || item.iemSe eq 'H'}">
					<label for="<c:out value="${item.iemId}" />"><c:out value="${item.iemNm}" /></label>
					</c:when>
					<c:when test="${item.iemSe eq 'L' || item.iemSe eq 'X' || item.iemSe eq 'M' || item.iemSe eq 'Z'}">
					<label for="<c:out value="${item.iemId}" />"><c:out value="${item.iemNm}" /></label>
					</c:when>
					<c:otherwise>
					<c:out value="${item.iemNm}" />
					</c:otherwise>
				</c:choose>
				</dt>
				<dd>
			<c:choose>
				<c:when test="${item.iemSe eq 'T'}">
					<input type="text" id="<c:out value="${item.iemId}" />" name="<c:out value="${item.iemId}" />" maxlength="<c:choose><c:when test="${item.encptAt eq 'Y'}">50</c:when><c:otherwise>100</c:otherwise></c:choose>" value="<c:out value="${item.val}" />">
				</c:when>
				<c:when test="${item.iemSe eq 'U'}">
					<input type="text" id="<c:out value="${item.iemId}" />" name="<c:out value="${item.iemId}" />" maxlength="100" value="<c:out value="${item.val}" />" placeholder="http://">
				</c:when>
				<c:when test="${item.iemSe eq 'L'}">
					<input type="text" class="small20 siiru-mr5" id="<c:out value="${item.iemId}" />_1" name="<c:out value="${item.iemId}" />_1" maxlength="50" value="<c:out value="${item.val1}" />" placeholder="링크명칭" title="링크명칭">
					<input type="text" class="small70" id="<c:out value="${item.iemId}" />_2" name="<c:out value="${item.iemId}" />_2" maxlength="80" value="<c:out value="${item.val2}" />" placeholder="http://" title="링크주소">
					<input type="hidden" id="<c:out value="${item.iemId}" />" name="<c:out value="${item.iemId}" />" value="<c:out value="${item.val}" />">
				</c:when>
				<c:when test="${item.iemSe eq 'R'}">
					<c:forEach var="code" items="${item.codeList}" varStatus="codeStatus">
					<input type="radio" id="<c:out value="${item.iemId}" />_<c:out value="${codeStatus.index}" />" name="<c:out value="${item.iemId}" />" value="<c:out value="${code.codeId}" />"<c:out value="${code.checked}" />>
					<label for="<c:out value="${item.iemId}" />_<c:out value="${codeStatus.index}" />"> <c:out value="${code.codeNm}" /> </label>
					</c:forEach>
				</c:when>
				<c:when test="${item.iemSe eq 'S'}">
					<select id="<c:out value="${item.iemId}" />" name="<c:out value="${item.iemId}" />">
						<option value="">선택</option>
						<c:forEach var="code" items="${item.codeList}" varStatus="codeStatus">
						<option value="<c:out value="${code.codeId}" />"<c:out value="${code.selected}" />><c:out value="${code.codeNm}" /></option>
						</c:forEach>
					</select>
				</c:when>
				<c:when test="${item.iemSe eq 'C'}">
					<c:forEach var="code" items="${item.codeList}" varStatus="codeStatus">
					<input type="checkbox" id="<c:out value="${item.iemId}" />_<c:out value="${codeStatus.index}" />" name="<c:out value="${item.iemId}" />[]" value="<c:out value="${code.codeId}" />"<c:out value="${code.checked}" />>
					<label for="<c:out value="${item.iemId}" />_<c:out value="${codeStatus.index}" />"> <c:out value="${code.codeNm}" /> </label>
					</c:forEach>
					<input type="hidden" id="<c:out value="${item.iemId}" />" name="<c:out value="${item.iemId}" />" value="<c:out value="${item.val}" />">
				</c:when>
				<c:when test="${item.iemSe eq 'X'}">
					<c:forEach var="x" begin="1" end="${item.codeStep}">
						<c:set var="step" value="step${x}" />
						<select name="<c:out value="${item.iemId}" />_codeStep<c:out value="${x}" />" class="codeStepSelect small siiru-mr5" data-name="<c:out value="${item.iemId}" />" data-step="<c:out value="${x}" />" data-maxstep="<c:out value="${item.codeStep}" />">
							<option value="">선택</option>
							<c:forEach var="stepCode" items="${item.codeStepList[step]}">
								<option value="<c:out value="${stepCode.codeId}" />" data-codecl="<c:out value="${stepCode.codeCl}" />" data-codeid="<c:out value="${stepCode.codeId}" />"<c:out value="${stepCode.selected}" />><c:out value="${stepCode.codeNm}" /></option>
							</c:forEach>
						</select>
					</c:forEach>
					<input type="hidden" id="<c:out value="${item.iemId}" />" name="<c:out value="${item.iemId}" />" value="<c:out value="${item.stepVal}" />">
				</c:when>
				<c:when test="${item.iemSe eq 'D'}">
					<input type="text" class="maskDate nothangul small20" id="<c:out value="${item.iemId}" />" name="<c:out value="${item.iemId}" />" autocomplete="off" maxlength="10" placeholder="날짜. YYYY-MM-DD" value="<c:out value="${item.val}" />">
				</c:when>
				<c:when test="${item.iemSe eq 'H'}">
					<input type="text" class="maskTime nothangul small20" id="<c:out value="${item.iemId}" />" name="<c:out value="${item.iemId}" />" autocomplete="off" maxlength="5" placeholder="시분. HH:mm" value="<c:out value="${item.val}" />">
				</c:when>
				<c:when test="${item.iemSe eq 'M'}">
					<input type="text" class="maskDate nothangul small20" id="<c:out value="${item.iemId}" />_1" name="<c:out value="${item.iemId}" />_1" autocomplete="off" maxlength="10" placeholder="날짜. YYYY-MM-DD" value="<c:out value="${item.val1}" />" title="시작 일자">
					<span> ~ </span>
					<input type="text" class="maskDate nothangul small20" id="<c:out value="${item.iemId}" />_2" name="<c:out value="${item.iemId}" />_2" autocomplete="off" maxlength="10" placeholder="날짜. YYYY-MM-DD" value="<c:out value="${item.val2}" />" title="종료 일자">
					<input type="hidden" id="<c:out value="${item.iemId}" />" name="<c:out value="${item.iemId}" />" value="<c:out value="${item.val}" />">
				</c:when>
				<c:when test="${item.iemSe eq 'Z'}">
					<input type="text" class="maskDate nothangul small20" id="<c:out value="${item.iemId}" />_T1" name="<c:out value="${item.iemId}" />_T1" autocomplete="off" maxlength="10" placeholder="날짜. YYYY-MM-DD" value="<c:out value="${item.val1t}" />" title="시작 일자">
					<input type="text" class="maskTime nothangul small20" id="<c:out value="${item.iemId}" />_T2" name="<c:out value="${item.iemId}" />_T2" autocomplete="off" maxlength="5" placeholder="시분. HH:mm" value="<c:out value="${item.val2t}" />" title="시작 시간">
					<span> ~ </span>
					<input type="text" class="maskDate nothangul small20" id="<c:out value="${item.iemId}" />_T3" name="<c:out value="${item.iemId}" />_T3" autocomplete="off" maxlength="10" placeholder="날짜. YYYY-MM-DD" value="<c:out value="${item.val3t}" />" title="종료 일자">
					<input type="text" class="maskTime nothangul small20" id="<c:out value="${item.iemId}" />_T4" name="<c:out value="${item.iemId}" />_T4" autocomplete="off" maxlength="5" placeholder="시분. HH:mm" value="<c:out value="${item.val4t}" />" title="종료 시간">
					<input type="hidden" id="<c:out value="${item.iemId}" />_1" name="<c:out value="${item.iemId}" />_1" value="<c:out value="${item.val1}" />">
					<input type="hidden" id="<c:out value="${item.iemId}" />_2" name="<c:out value="${item.iemId}" />_2" value="<c:out value="${item.val2}" />">
					<input type="hidden" id="<c:out value="${item.iemId}" />" name="<c:out value="${item.iemId}" />" value="<c:out value="${item.val}" />">
					<small>일자 : <c:out value="${currentYYMM}" />-01, 시간 : 18:00</small>
				</c:when>
				<c:when test="${item.iemSe eq 'F'}">
					<input type="file" id="<c:out value="${item.iemId}" />" name="<c:out value="${item.iemId}" />" class="file">
					<c:if test="${not empty item.iemDc or item.iemDc ne ''}">
					<small>허용되는 확장자는 [<c:out value="${item.iemDc}" />] 입니다.</small>
					</c:if>
				</c:when>
			</c:choose>
				<c:if test="${(not empty item.iemDc or item.iemDc ne '') && item.iemSe ne 'F'}">
					<small><c:out value="${item.iemDc}" /></small>
				</c:if>
				</dd>
			</dl>
		</c:forEach>
	</c:if>
		</div>
		<div class="siiru-btnSet siiru-tc siiru-mt10">
			<button type="button" id="joinSubmit" class="siiru-btn siiru-btn-primary">회원가입</button>
			<button type="button" id="cancelBtn" class="siiru-btn siiru-btn-default siiru-ml10">취소</button>
		</div>
	</c:when>
	<%-- 5단계 회원가입완료 --%>
	<c:when test="${stepLevel eq 'S5'}">
		<h5 class="stepTitle"><c:out value="${stepTitle}" /></h5>
		<div class="complete">
			<p>회원가입 신청이 완료되었습니다.<br>관리자(노회 서기) 승인이 완료되면 홈페이지 이용이 가능합니다.<br>감사합니다.</p>
		</div>
		<div class="siiru-btnSet siiru-tc">
			<button type="button" id="joinBtn" class="siiru-btn siiru-btn-primary">메인</button>
			<button type="button" id="loginBtn" class="siiru-btn siiru-btn-default siiru-ml10">로그인</button>
		</div>
	</c:when>
</c:choose>
		</form>
	</section>
</div>
<%-- 4단계 개인정보입력 --%>
<c:if test="${stepLevel eq 'S4'}">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</c:if>
<script>
if (window.addEventListener) window.addEventListener("load", join, false);
else if (window.attachEvent) window.attachEvent("onload", join);
else window.onload = join;
var idCheck = false;
function join() {
	<c:choose>
	<%-- 1단계 가입안내 --%>
	<c:when test="${stepLevel eq 'S1'}">
	$('.joinStartBtn').click(function() {
		$('#stepLevel').val('S2');
		$('#userKind').val('A');
		$('#siiru-joinForm').submit();
	});
	</c:when>
	<%-- 2단계 회원약관동의 --%>
	<c:when test="${stepLevel eq 'S2'}">
	$('#agreeAllBtn').click(function() {
		$(':checkbox[name="agree1"]').prop('checked', true);
		$(':checkbox[name="agree2"]').prop('checked', true);
	});
	$('#joinSubmit').click(function() {
		if (!$(':checkbox[name="agree1"]').is(':checked')) {
			alert('회원약관에 동의하지 않으셨습니다.');
			$(':checkbox[name="agree1"]').focus();
			return false;
		}
		if (!$(':checkbox[name="agree2"]').is(':checked')) {
			alert('개인정보보호방침에 동의하지 않으셨습니다.');
			$(':checkbox[name="agree2"]').focus();
			return false;
		}
		$('#stepLevel').val('S4');
		$('#siiru-joinForm').submit();
	});
	</c:when>
	<%-- 3단계 본인인증 (설정안됨) --%>
	<c:when test="${stepLevel eq 'S3'}">
	$('.stepCate button').click(function() {
		var w = 480, h = 812;
		var certType = $.trim($(this).data('certtype'));
		if (certType == 'NICEIPIN') {
			w = 445, h = 580;
		} else if (certType == 'MOBILEID') {
			w = 838, h = 611;
		}
		var top = ($(window).height() - h) / 2;
		var left = ($(window).width() - w) / 2;
		var certUrl = '';
		if (certType == 'MOBILEID') {
			certUrl = '<c:out value="${path.context}" />mobileidView.do?pageId=<c:out value="${param.pageId}" />&taskSe=J&userSe='+$.trim($(this).data('certkind'));
		} else {
			certUrl = '<c:out value="${path.context}" />certRequest.do?pageId=<c:out value="${param.pageId}" />&pageSe=J&userKind='+$.trim($(this).data('certkind'))+'&certType='+certType;
		}
		openWindow(certUrl,certType+'CertWindow',top,left,w,h,'yes','no');
	});
	$('#prevBtn').click(function() {
		$('#stepLevel').val('S2');
		$('#siiru-joinForm').submit();
	});
	</c:when>
	<%-- 4단계 개인정보입력 --%>
	<c:when test="${stepLevel eq 'S4'}">
	$('.idCheck').click(function() {
		if ($.trim($('#userId').val()) != '') {
			$.post('<c:out value="${path.context}" />joinIdCheck.do', {'userId':$('#userId').val()}).done(function(data) {
				if (data.error == 'N') {
					idCheck = true;
					alert('사용가능한 아이디 입니다.');
					$('#userId').prop('readonly', true);
				} else {
					idCheck = false;
					alert(data.errorMsg);
					$('#userId').prop('readonly', false);
					$('#userId').focus();
				}
			});
		} else {
			idCheck = false;
		}
	});
	$('#brthdy').change(function() {
		var pattern = /[0-9]{4}-[0-9]{2}-[0-9]{2}/;
		var yyyy = new Date().getFullYear();
		var age = 0;
		if (($.trim($(this).val()) != '') && (pattern.test($.trim($(this).val())))) {
			age = yyyy - $.trim($(this).val()).substr(0,4) + 1;
			if (age < 0) age = 0;
			if (age > 100) age = 100;
			$('#agrde option:eq('+parseInt((age/10)+1, 10)+')').prop('selected', true);
		}
	});
	$('.zipFind').click(function() {
		zipFind();
	});
	$('.areaSelect').change(function() {
		var areaSe = $.trim($(this).data('arease'));
		if (areaSe == 'C') {
			$('#areaCode').val($.trim($(this).val()));
			$('#signgu option').not(':first').remove();
			$('#emd option').not(':first').remove();
			if ($('#dongli').length > 0) $('#dongli option').not(':first').remove();
			if ($.trim($(this).val()) != '') findArea('S','signgu');
		} else if (areaSe == 'S') {
			if ($.trim($(this).val()) != '') {
				$('#areaCode').val($.trim($(this).val()));
			} else {
				$('#areaCode').val($.trim($('#ctprvn option:selected').val()));
			}
			$('#emd option').not(':first').remove();
			if ($('#dongli').length > 0) $('#dongli option').not(':first').remove();
			if ($.trim($(this).val()) != '') findArea('D','emd');
		} else if (areaSe == 'D') {
			if ($.trim($(this).val()) != '') {
				$('#areaCode').val($.trim($(this).val()));
			} else {
				$('#areaCode').val($.trim($('#signgu option:selected').val()));
			}
			if ($('#dongli').length > 0) {
				$('#dongli option').not(':first').remove();
				if ($.trim($(this).val()) != '') findArea('L','dongli');
			}
		} else if (areaSe == 'L') {
			if ($.trim($(this).val()) != '') {
				$('#areaCode').val($.trim($(this).val()));
			} else {
				$('#areaCode').val($.trim($('#emd option:selected').val()));
			}
		}
	});
	$(':radio[name="proflSe"]').change(function() {
		if ($(this).val() == 'L') {
			$('#proflUrl').prop('disabled', false);
			$('.file').prop('disabled', true);
		} else {
			$('#proflUrl').prop('disabled', true);
			$('.file').prop('disabled', false);
		}
	});
	$('.codeStepSelect').change(function() {
		var selectData = $(this).data();
		var itemName = $.trim(selectData.name);
		var selectName = $.trim(selectData.name)+'_codeStep';
		var codeStep = parseInt(selectData.step,10);
		var codeStepMax = parseInt(selectData.maxstep,10);
		var selData = $(this).find(':selected').data();
		var selStep = codeStep+1;
		for (var i=selStep; i<=codeStepMax; i++) {
			$('select[name="'+selectName+''+i+'"] option').not(':first').remove();
		}
		if ($.trim($(this).val()) != '') {
			$.post('<c:out value="${path.context}" />getCodeStep.do', {'codeCl':$.trim(selData.codecl),'codeStep':selStep,'upperCodeId':$.trim(selData.codeid)}).done(function(data) {
				if (data.error == 'N') {
					$.each(data.dataList, function(key, values) {
						$('select[name="'+selectName+''+selStep+'"]').append('<option value="'+values.codeId+'" data-codecl="'+values.codeCl+'" data-codeid="'+values.codeId+'">'+values.codeNm+'</option>');
					});
				}
			});
		}
		if ($.trim($(this).val()) != '') {
			$('#'+itemName).val($.trim($(this).val()));
		} else {
			if (codeStep > 1) {
				$('#'+itemName).val($.trim($('select[name="'+selectName+''+(codeStep-1)+'"] option:selected').val()));
			} else {
				$('#'+itemName).val('');
			}
		}
	});
	$('#joinSubmit').click(function(e) {
		e.preventDefault();
		if ($.trim($('#userId').val()) == '') {
			alert('아이디를 입력해 주세요.');
			$('#userId').focus();
		} else if (!idCheck) {
			alert('아이디 중복확인을 해주세요.');
			$('#userId').focus();
	<c:if test="${userData.passwdChk eq 'Y'}">
		} else if ($.trim($('#passwd').val()) == '') {
			alert('비밀번호를 입력해 주세요.');
			$('#passwd').focus();
		} else if ($.trim($('#passwdConfirm').val()) == '') {
			alert('비밀번호를 한번 더 입력해 주세요.');
			$('#passwdConfirm').focus();
		} else if ($.trim($('#passwd').val()) != $.trim($('#passwdConfirm').val())) {
			alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.');
			$('#passwdConfirm').val('').focus();
		} else if (!ValidPasswd($('#passwd').val())) {
			alert('비밀번호 유효성 검사를 통과하지 못했습니다.');
			$('#passwd').val('').focus();
			$('#passwdConfirm').val('');
	</c:if>
		} else if ($.trim($('#userNm').val()) == '') {
			alert('이름을 입력해 주세요.');
			$('#userNm').focus();
		} else if (!($('#ncnm').val() == '' || $('#ncnm').val().trim().length != 0)) {
			alert('닉네임 : 공백(Space)은 입력할 수 없습니다.');
			$('#ncnm').focus();
		} else if (($.trim($('#brthdy').val()) != '') && (!ValidDate($.trim($('#brthdy').val())))) {
			alert('생년월일 : 잘못된 날짜 형식입니다.');
			$('#brthdy').focus();
		} else if ($.trim($('#email').val()) == '') {
			alert('이메일을 입력해 주세요.');
			$('#email').focus();
		} else if (($.trim($('#email').val()) != '') && (!ValidEmail($.trim($('#email').val())))) {
			alert('이메일 : 잘못된 이메일 형식입니다.');
			$('#email').focus();
		} else if (($.trim($('#telno').val()) != '') && (!ValidTel($.trim($('#telno').val())))) {
			alert('전화번호 : 잘못된 전화번호 형식입니다.');
			$('#telno').focus();
		} else if ($.trim($('#mbtlnum').val()) == '') {
			alert('모바일번호를 입력해 주세요.');
			$('#mbtlnum').focus();
		} else if (($.trim($('#mbtlnum').val()) != '') && (!ValidMobile($.trim($('#mbtlnum').val())))) {
			alert('모바일번호 : 잘못된 모바일번호 형식입니다.');
			$('#mbtlnum').focus();
		} else if (($.trim($('#ctprvn').val()) != '') && ($.trim($('#signgu').val()) == '')) {
			alert('시/군/구 : 필수 항목입니다.');
			$('#signgu').focus();
		} else {
			if ($.trim($(':radio[name="proflSe"]:checked').val()) == 'L') {
				if (($('#proflUrl').val() != '') && ($.inArray($('#proflUrl').val().split('.').pop().toLowerCase(), ['gif','jpg','jpeg','png']) == -1)) {
					alert('이미지 파일만 링크 하실 수 있습니다.');
					$userForm.find('input[name="proflUrl"]').focus();
					return false;
				}
			} else {
				if (($('#proflImage').val() != '') && ($.inArray($('#proflImage').val().split('.').pop().toLowerCase(), ['gif','jpg','jpeg','png']) == -1)) {
					alert('이미지 파일만 업로드 하실 수 있습니다.');
					return false;
				}
			}
			<%-- 항목관리 설정값에 의해 필수입력값 체크 --%>
			<c:if test="${not empty userItem && fn:length(userItem) > 0}">
				<c:forEach var="item" items="${userItem}">
					<c:choose>
						<c:when test="${item.iemSe eq 'L'}">
							<c:if test="${item.reqrdAt eq 'Y'}">
						// ${item.iemNm}
						if ($.trim($('#<c:out value="${item.iemId}" />_1').val()) == '') {
							alert('링크명칭 : 필수 항목입니다.');
							$('#<c:out value="${item.iemId}" />_1').focus();
							return false;
						}
						if ($.trim($('#<c:out value="${item.iemId}" />_2').val()) == '') {
							alert('링크주소 : 필수 항목입니다.');
							$('#<c:out value="${item.iemId}" />_2').focus();
							return false;
						}
							</c:if>
						if ($.trim($('#<c:out value="${item.iemId}" />_2').val()) != '') {
							if (!ValidUrl($('#<c:out value="${item.iemId}" />_2').val())) {
								alert('<c:out value="${item.iemNm}" /> : 잘못된 URL 형식입니다.');
								$('#<c:out value="${item.iemId}" />_2').focus();
								return false;
							}
						}
						</c:when>
						<c:when test="${item.iemSe eq 'R' && item.reqrdAt eq 'Y'}">
						// ${item.iemNm}
						if (!$(':radio[name="<c:out value="${item.iemId}" />"]').is(':checked')) {
							alert('<c:out value="${item.iemNm}" /> : 필수 항목입니다.');
							$('html,body').animate({scrollTop:$('#cFocus_<c:out value="${item.iemId}" />').offset().top},0);
							return false;
						}
						</c:when>
						<c:when test="${item.iemSe eq 'C' && item.reqrdAt eq 'Y'}">
						// ${item.iemNm}
						if ($(':checkbox[name="<c:out value="${item.iemId}" />[]"]:checked').length == 0) {
							alert('<c:out value="${item.iemNm}" /> : 필수 항목입니다.');
							$('html,body').animate({scrollTop:$('#cFocus_<c:out value="${item.iemId}" />').offset().top},0);
							return false;
						}
						</c:when>
						<c:when test="${item.iemSe eq 'M'}">
							<c:if test="${item.reqrdAt eq 'Y'}">
						// ${item.iemNm} 필수체크
						if ($.trim($('#<c:out value="${item.iemId}" />_1').val()) == '') {
							alert('시작 일자 : 필수 항목입니다.');
							$('#<c:out value="${item.iemId}" />_1').focus();
							return false;
						}
						if ($.trim($('#<c:out value="${item.iemId}" />_2').val()) == '') {
							alert('종료 일자 : 필수 항목입니다.');
							$('#<c:out value="${item.iemId}" />_2').focus();
							return false;
						}
							</c:if>
						if ($.trim($('#<c:out value="${item.iemId}" />_1').val()) != '') {
							if (!ValidDate($('#<c:out value="${item.iemId}" />_1').val())) {
								alert('시작 일자 : 잘못된 날짜 형식입니다.');
								$('#<c:out value="${item.iemId}" />_1').focus();
								return false;
							}
						}
						if ($.trim($('#<c:out value="${item.iemId}" />_2').val()) != '') {
							if (!ValidDate($('#<c:out value="${item.iemId}" />_2').val())) {
								alert('종료 일자 : 잘못된 날짜 형식입니다.');
								$('#<c:out value="${item.iemId}" />_2').focus();
								return false;
							}
						}
						if (($.trim($('#<c:out value="${item.iemId}" />_1').val()) != '') || ($.trim($('#<c:out value="${item.iemId}" />_2').val()) != '')) {
							var beginDt = '';
							var endDt = '';
							if ($.trim($('#<c:out value="${item.iemId}" />_1').val()) != '') {
								beginDt = $('#<c:out value="${item.iemId}" />_1').val()+' 00:00:00';
							}
							if ($.trim($('#<c:out value="${item.iemId}" />_2').val()) != '') {
								endDt = $('#<c:out value="${item.iemId}" />_2').val()+' 00:00:00';
							}
							if ((beginDt != '') && (endDt != '')) {
								var startDate = new Date(beginDt);
								var stopDate = new Date(endDt);
								if (startDate > stopDate) {
									alert('<c:out value="${item.iemNm}" /> : 시작일자가 종료일자 보다 큽니다.');
									$('html,body').animate({scrollTop:$('#cFocus_<c:out value="${item.iemId}" />').offset().top},0);
									return false;
								}
							}
						}
						</c:when>
						<c:when test="${item.iemSe eq 'Z'}">
							<c:if test="${item.reqrdAt eq 'Y'}">
						// ${item.iemNm} 필수체크
						if ($.trim($('#<c:out value="${item.iemId}" />_T1').val()) == '') {
							alert('시작 일자 : 필수 항목입니다.');
							$('#<c:out value="${item.iemId}" />_T1').focus();
							return false;
						}
						if ($.trim($('#<c:out value="${item.iemId}" />_T2').val()) == '') {
							alert('시작 시간 : 필수 항목입니다.');
							$('#<c:out value="${item.iemId}" />_T2').focus();
							return false;
						}
						if ($.trim($('#<c:out value="${item.iemId}" />_T3').val()) == '') {
							alert('종료 일자 : 필수 항목입니다.');
							$('#<c:out value="${item.iemId}" />_T3').focus();
							return false;
						}
						if ($.trim($('#<c:out value="${item.iemId}" />_T4').val()) == '') {
							alert('종료 시간 : 필수 항목입니다.');
							$('#<c:out value="${item.iemId}" />_T4').focus();
							return false;
						}
							</c:if>
						if (($('#<c:out value="${item.iemId}" />_T1').val() == '') && ($('#<c:out value="${item.iemId}" />_T2').val() != '')) {
							alert('<c:out value="${item.iemNm}" /> : 필수 항목입니다.');
							$('#<c:out value="${item.iemId}" />_T1').focus();
							return false;
						}
						if (($('#<c:out value="${item.iemId}" />_T3').val() == '') && ($('#<c:out value="${item.iemId}" />_T4').val() != '')) {
							alert('<c:out value="${item.iemNm}" /> : 필수 항목입니다.');
							$('#<c:out value="${item.iemId}" />_T3').focus();
							return false;
						}
						if ($.trim($('#<c:out value="${item.iemId}" />_T1').val()) != '') {
							if (!ValidDate($('#<c:out value="${item.iemId}" />_T1').val())) {
								alert('시작 일자 : 잘못된 날짜 형식입니다.');
								$('#<c:out value="${item.iemId}" />_T1').focus();
								return false;
							}
						}
						if ($.trim($('#<c:out value="${item.iemId}" />_T2').val()) != '') {
							if (!ValidTime($('#<c:out value="${item.iemId}" />_T2').val())) {
								alert('시작 시간 : 잘못된 시간 형식입니다.');
								$('#<c:out value="${item.iemId}" />_T2').focus();
								return false;
							}
						}
						if ($.trim($('#<c:out value="${item.iemId}" />_T3').val()) != '') {
							if (!ValidDate($('#<c:out value="${item.iemId}" />_T3').val())) {
								alert('종료 일자 : 잘못된 날짜 형식입니다.');
								$('#<c:out value="${item.iemId}" />_T3').focus();
								return false;
							}
						}
						if ($.trim($('#<c:out value="${item.iemId}" />_T4').val()) != '') {
							if (!ValidTime($('#<c:out value="${item.iemId}" />_T4').val())) {
								alert('종료 시간 : 잘못된 시간 형식입니다.');
								$('#<c:out value="${item.iemId}" />_T4').focus();
								return false;
							}
						}
						if (($.trim($('#<c:out value="${item.iemId}" />_T1').val()) != '') || ($.trim($('#<c:out value="${item.iemId}" />_T3').val()) != '')) {
							var beginDt = '';
							var endDt = '';
							if ($.trim($('#<c:out value="${item.iemId}" />_T1').val()) != '') {
								if ($.trim($('#<c:out value="${item.iemId}" />_T2').val()) != '') {
									beginDt = $('#<c:out value="${item.iemId}" />_T1').val()+' '+$('#<c:out value="${item.iemId}" />_T2').val()+':00';
								} else {
									beginDt = $('#<c:out value="${item.iemId}" />_T1').val()+' 00:00:00';
								}
							}
							if ($.trim($('#<c:out value="${item.iemId}" />_T3').val()) != '') {
								if ($.trim($('#<c:out value="${item.iemId}" />_T4').val()) != '') {
									endDt = $('#<c:out value="${item.iemId}" />_T3').val()+' '+$('#<c:out value="${item.iemId}" />_T4').val()+':00';
								} else {
									endDt = $('#<c:out value="${item.iemId}" />_T3').val()+' 00:00:00';
								}
							}
							if ((beginDt != '') && (endDt != '')) {
								var startDate = new Date(beginDt);
								var stopDate = new Date(endDt);
								if (startDate > stopDate) {
									alert('<c:out value="${item.iemNm}" /> : 시작일시가 종료일시 보다 큽니다.');
									$('html,body').animate({scrollTop:$('#cFocus_<c:out value="${item.iemId}" />').offset().top},0);
									return false;
								}
							}
						}
						</c:when>
						<c:when test="${item.iemSe eq 'F'}">
							<c:if test="${item.reqrdAt eq 'Y'}">
						// ${item.iemNm} 필수체크
						if ($.trim($('#<c:out value="${item.iemId}" />').val()) == '') {
							if ($.trim($('#old_<c:out value="${item.iemId}" />').val()) == '' || $(':checkbox[name="del_<c:out value="${item.iemId}" />"]').is(':checked')) {
								alert('<c:out value="${item.iemNm}" /> : 필수 항목입니다.');
								$('#<c:out value="${item.iemId}" />').focus();
								return false;
							}
						}
							</c:if>
							<c:if test="${not empty item.iemDc or item.iemDc ne ''}">
						// ${item.iemNm} 확장자
						if ($.trim($('#<c:out value="${item.iemId}" />').val()) != '' && $.inArray($.trim($('#<c:out value="${item.iemId}" />').val()).split('.').pop().toLowerCase(), [<c:out value="${item.iemExt}" escapeXml="false" />]) == -1) {
							alert('<c:out value="${item.iemNm}" /> : 허용되는 확장자[<c:out value="${item.iemDc}" />]만 업로드 하실 수 있습니다.');
							$('#<c:out value="${item.iemId}" />').focus();
							return false;
						}
							</c:if>
						</c:when>
						<c:otherwise>
							<c:if test="${item.reqrdAt eq 'Y'}">
						// ${item.iemNm}
						if ($.trim($('#<c:out value="${item.iemId}" />').val()) == '') {
							alert('<c:out value="${item.iemNm}" /> : 필수 항목입니다.');
							$('#<c:out value="${item.iemId}" />').focus();
							return false;
						}
							</c:if>
							<c:choose>
								<c:when test="${item.iemSe eq 'U'}">
						if ($.trim($('#<c:out value="${item.iemId}" />').val()) != '') {
							if (!ValidUrl($('#<c:out value="${item.iemId}" />').val())) {
								alert('<c:out value="${item.iemNm}" /> : 잘못된 URL 형식입니다.');
								$('#<c:out value="${item.iemId}" />').focus();
								return false;
							}
						}
								</c:when>
								<c:when test="${item.iemSe eq 'D'}">
						if ($.trim($('#<c:out value="${item.iemId}" />').val()) != '') {
							if (!ValidDate($('#<c:out value="${item.iemId}" />').val())) {
								alert('<c:out value="${item.iemNm}" /> : 잘못된 날짜 형식입니다.');
								$('#<c:out value="${item.iemId}" />').focus();
								return false;
							}
						}
								</c:when>
								<c:when test="${item.iemSe eq 'H'}">
						if ($.trim($('#<c:out value="${item.iemId}" />').val()) != '') {
							if (!ValidTime($('#<c:out value="${item.iemId}" />').val())) {
								alert('<c:out value="${item.iemNm}" /> : 잘못된 시간 형식입니다.');
								$('#<c:out value="${item.iemId}" />').focus();
								return false;
							}
						}
								</c:when>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</c:if>
			<c:if test="${not empty userItem && fn:length(userItem) > 0}">
				<c:forEach var="item" items="${userItem}">
					<c:if test="${item.iemSe eq 'L'}">
					// ${item.iemNm}
					if (($.trim($('#<c:out value="${item.iemId}" />_1').val()) != '') || ($.trim($('#<c:out value="${item.iemId}" />_2').val()) != '')) {
						$('#<c:out value="${item.iemId}" />').val($.trim($('#<c:out value="${item.iemId}" />_1').val())+'|'+$.trim($('#<c:out value="${item.iemId}" />_2').val()));
					} else {
						$('#<c:out value="${item.iemId}" />').val('');
					}
					</c:if>
					<c:if test="${item.iemSe eq 'C'}">
					// ${item.iemNm}
					var <c:out value="${item.iemId}" />Arr = [];
					$(':checkbox[name="<c:out value="${item.iemId}" />[]"]:checked').each(function() {
						<c:out value="${item.iemId}" />Arr.push($(this).val());
					});
					$('#<c:out value="${item.iemId}" />').val(<c:out value="${item.iemId}" />Arr);
					</c:if>
					<c:if test="${item.iemSe eq 'M'}">
					// ${item.iemNm}
					if ($.trim($('#<c:out value="${item.iemId}" />_1').val()) != '' || $.trim($('#<c:out value="${item.iemId}" />_2').val()) != '') {
						$('#<c:out value="${item.iemId}" />').val($.trim($('#<c:out value="${item.iemId}" />_1').val())+' ~ '+$.trim($('#<c:out value="${item.iemId}" />_2').val()));
					} else {
						$('#<c:out value="${item.iemId}" />').val('');
					}
					</c:if>
					<c:if test="${item.iemSe eq 'Z'}">
					// ${item.iemNm}
					if ($.trim($('#<c:out value="${item.iemId}" />_T1').val()) != '') {
						if ($.trim($('#<c:out value="${item.iemId}" />_T2').val()) != '') {
							$('#<c:out value="${item.iemId}" />_1').val($('#<c:out value="${item.iemId}" />_T1').val()+' '+$('#<c:out value="${item.iemId}" />_T2').val());
						} else {
							$('#<c:out value="${item.iemId}" />_1').val($('#<c:out value="${item.iemId}" />_T1').val()+' 00:00');
						}
					} else {
						$('#<c:out value="${item.iemId}" />_1').val('');
					}
					if ($.trim($('#<c:out value="${item.iemId}" />_T3').val()) != '') {
						if ($.trim($('#<c:out value="${item.iemId}" />_T4').val()) != '') {
							$('#<c:out value="${item.iemId}" />_2').val($('#<c:out value="${item.iemId}" />_T3').val()+' '+$('#<c:out value="${item.iemId}" />_T4').val());
						} else {
							$('#<c:out value="${item.iemId}" />_2').val($('#<c:out value="${item.iemId}" />_T3').val()+' 00:00');
						}
					} else {
						$('#<c:out value="${item.iemId}" />_2').val('');
					}
					if ($.trim($('#<c:out value="${item.iemId}" />_1').val()) != '' || $.trim($('#<c:out value="${item.iemId}" />_2').val()) != '') {
						$('#<c:out value="${item.iemId}" />').val($.trim($('#<c:out value="${item.iemId}" />_1').val())+' ~ '+$.trim($('#<c:out value="${item.iemId}" />_2').val()));
					} else {
						$('#<c:out value="${item.iemId}" />').val('');
					}
					</c:if>
				</c:forEach>
			</c:if>
			var formData = new FormData($('#siiru-joinForm')[0]);
			formData.append('action', 'I');
			ajaxForm('<c:out value="${path.context}" />joinAction.do', formData, function(data) {
				if (data.error == 'N') {
					$('#stepLevel').val('S5');
					$('#siiru-joinForm').submit();
				}
			});
		}
		return false;
	});
	</c:when>
	</c:choose>
	// 메인
	$('#joinBtn').click(function() {
		window.document.location.href = '<c:out value="${path.sContext}" />';
	});
	// 로그인
	$('#loginBtn').click(function() {
		window.document.location.href = '<c:out value="${path.context}" />login.do?pageId=';
	});
	// 취소
	$('#cancelBtn').click(function() {
		window.document.location.href = '<c:out value="${path.sContext}" />join.do?pageId=<c:out value="${param.pageId}" />';
	});
}
<%-- 3단계 본인인증 (설정안됨) --%>
<c:if test="${stepLevel eq 'S3'}">
function certResponse(certKind) {
	if (certKind == 'P' || certKind == 'C') {
		if (certKind == 'P' && $.trim($('#parentsAt').val()) != 'Y') {
			$('#parentsAt').val('Y');
			$('.parentsLayer').html('보호자 인증이 완료되었습니다.');
		}
		if (certKind == 'C' && $.trim($('#selfAt').val()) != 'Y') {
			$('#selfAt').val('Y');
			$('.certLayer').html('본인 인증이 완료되었습니다.');
		}
		if ($.trim($('#parentsAt').val()) == 'Y' && $.trim($('#selfAt').val()) == 'Y') {
			$('#stepLevel').val('S4');
			$('#siiru-joinForm').submit();
		}
	} else {
		$('#stepLevel').val('S4');
		$('#siiru-joinForm').submit();
	}
}
</c:if>
<%-- 4단계 개인정보입력 --%>
<c:if test="${stepLevel eq 'S4'}">
function findArea(areaSe, areaId) {
	$('#'+areaId+' option').not(':first').remove();
	$.post('<c:out value="${path.context}" />getAreaList.do', {'areaSe':areaSe, 'areaCode':$.trim($('#areaCode').val())}).done(function(data) {
		if (data.error == 'N') {
			$.each(data.dataList, function(key, values) {
				$('#'+areaId).append('<option value="'+$.trim(values.areaCode)+'">'+$.trim(values.areaNm)+'</option>');
			});
		}
	});
}
function zipFind() {
	new daum.Postcode({
		oncomplete: function(data) {
			var extraAddr = '';
			var fullAddr = $.trim(data.roadAddress);
			if ($.trim(data.bname) !== '') extraAddr+= $.trim(data.bname);
			if ($.trim(data.buildingName) !== '') extraAddr+= (extraAddr !== '' ? ', '+$.trim(data.buildingName) : $.trim(data.buildingName));
			fullAddr+= (extraAddr !== '' ? ' ('+extraAddr+')' : '');
			$('#zip').val($.trim(data.zonecode));
			$('#addr').val(fullAddr);
			$('#detailAddr').focus();
		}
	}).open();
}
</c:if>
</script>
