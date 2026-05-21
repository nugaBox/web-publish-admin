<%@ include file="/WEB-INF/jsp/home/siiru/include/header.jsp" %>
<%-- 레이아웃 상단 출력 --%>
<c:if test="${headerUrl != null}"><jsp:include page="${headerUrl}" /></c:if>
<div class="siiru-boardWrap">
<%-- 게시판 상단 출력 --%>
<c:if test="${not empty boardMaster.hderCn}">
	<div class="siiru-clr"><jsp:include page="${hderCn}" /></div>
</c:if>
	<%-- 페이지/게시판 정보 및 검색정보/페이지번호를 가지고 다니기 위해 --%>
	<form id="boardSearchForm" name="boardSearchForm" method="post">
		<input type="hidden" name="pageId" value="<c:out value="${param.pageId}" />">
		<input type="hidden" id="movePage" name="movePage" value="<c:out value="${param.movePage}" />">
		<input type="hidden" id="boardId" name="boardId" value="<c:out value="${param.boardId}" />">
		<input type="hidden" id="searchCtgry" name="searchCtgry" value="<c:out value="${param.searchCtgry}" />">
		<input type="hidden" id="searchCtgryNm" name="searchCtgryNm" value="<c:out value="${param.searchCtgryNm}" />">
		<c:if test="${not empty boardMaster.listDe}"><input type="hidden" id="searchBase" name="searchBase" value="<c:out value="${param.searchBase}" />"></c:if>
		<input type="hidden" id="searchSDe" name="searchSDe" value="<c:out value="${param.searchSDe}" />">
		<input type="hidden" id="searchEDe" name="searchEDe" value="<c:out value="${param.searchEDe}" />">
		<input type="hidden" id="searchPrcs" name="searchPrcs" value="<c:out value="${param.searchPrcs}" />">
		<input type="hidden" id="searchTy" name="searchTy" value="<c:out value="${param.searchTy}" />">
		<input type="hidden" id="searchQuery" name="searchQuery" value="<c:out value="${param.searchQuery}" />">
	</form>
	<%-- 게시글 등록 정보 --%>
	<form id="boardForm" name="boardForm" method="post" enctype="multipart/form-data">
	<input type="hidden" id="action" name="action" value="<c:out value="${boardData.pageAction}" />">
	<input type="hidden" id="seq" name="seq" value="<c:out value="${boardData.seq}" />">
	<input type="hidden" id="levelSn" name="levelSn" value="<c:out value="${boardData.levelSn}" />">
	<input type="hidden" id="beginDt" name="beginDt" value="">
	<input type="hidden" id="endDt" name="endDt" value="">
	<input type="hidden" id="noticeBeginDt" name="noticeBeginDt" value="">
	<input type="hidden" id="noticeEndDt" name="noticeEndDt" value="">
	<div class="siiruBoard-write">
	<%-- 분류가 활성화 일경우. 답변글은 비활성화됨. --%>
	<c:if test="${form.ctgryAt eq 'Y'}">
		<dl>
			<dt><span>*</span> <label for="ctgrySn"><c:out value="${boardFieldNm.ctgryNm}" /></label></dt>
			<dd>
				<select id="ctgrySn" name="ctgrySn">
					<option value=""><spring:message code="info.choose" /></option>
			<c:if test="${not empty ctgryList and fn:length(ctgryList) > 0}">
				<c:forEach var="ctgry" items="${ctgryList}">
					<option value="<c:out value="${ctgry.value}" />"<c:out value="${ctgry.selected}" />><c:out value="${ctgry.name}" /></option>
				</c:forEach>
			</c:if>
				</select>
			</dd>
		</dl>
	</c:if>
		<%-- 제목 --%>
		<dl>
			<dt><span>*</span> <label for="boardSj"><c:out value="${boardFieldNm.boardSj}" /></label></dt>
			<dd><input type="text" id="boardSj" name="boardSj" maxlength="200" value="<c:out value="${boardData.boardSj}" />"></dd>
		</dl>
		<%-- 작성자. 로그인 사용자는 변경할 수 없다. 관리자는 제외 --%>
		<dl>
			<dt><span>*</span> <label for="userNm"><c:out value="${boardFieldNm.userNm}" /></label></dt>
			<dd><input type="text" class="small2" id="userNm" name="userNm" maxlength="50" value="<c:out value="${boardData.userNm}" />"<c:if test="${form.userReadOnly eq 'Y'}"> readonly</c:if>></dd>
		</dl>
	<%-- 비밀번호 활성화 일경우. 게시판 쓰기 권한이 전체일경우 --%>
	<c:if test="${form.passwdAt eq 'Y'}">
		<dl>
			<dt><span>*</span> <label for="passwd"><spring:message code="info.passwd" /></label></dt>
			<dd><input type="password" id="passwd" name="passwd" maxlength="20" value="" autocomplete="off"></dd>
		</dl>
	</c:if>
	<%-- 자동등록방지가 활성화 일경우 --%>
	<c:if test="${form.captchaAt eq 'Y'}">
		<dl>
			<dt><span>*</span> <label for="captcha"><spring:message code="info.captcha" /></label></dt>
			<dd>
				<div id="captchaAudio" class="siiru-hidden"></div>
				<img src="<c:url value="${path.context}captcha.do" />" class="captchaImg" alt="<spring:message code="info.captcha.img" />">
				<button class="captchaBtn siiru-btn siiru-btn-small" type="button"><spring:message code="info.reload" /></button>
				<button class="captchaAudioBtn siiru-btn siiru-btn-small" type="button"><spring:message code="info.audio" /></button>
				<input type="text" class="small2" id="captcha" name="captcha" value="" autocomplete="off" placeholder="<spring:message code="info.captcha.msg" />">
			</dd>
		</dl>
	</c:if>
	<%-- 메인노출이 활성화 일경우. 답변글은 비활성화됨. --%>
	<c:if test="${form.mainExpsrAt eq 'Y'}">
		<dl>
			<dt><label for="mainExpsrAt"><spring:message code="info.mainExpsr" /></label></dt>
			<dd>
				<input type="checkbox" id="mainExpsrAt" name="mainExpsrAt" value="Y"<c:if test="${boardData.mainExpsrAt eq 'Y'}"> checked</c:if>>
				<label for="mainExpsrAt"> <spring:message code="info.mainExpsr" /> </label>
			</dd>
		</dl>
	</c:if>
	<%-- 비밀글이 활성화 일경우. 답변글은 비활성화됨. --%>
	<c:if test="${form.secretAt eq 'Y'}">
		<dl>
			<dt><label for="secretAt"><spring:message code="info.secret" /></label></dt>
			<dd>
				<input type="checkbox" id="secretAt" name="secretAt" value="Y"<c:if test="${boardData.secretAt eq 'Y'}"> checked</c:if>>
				<label for="secretAt"> <spring:message code="info.secret" /> </label>
			</dd>
		</dl>
	</c:if>
	<%-- 게시기간이 활성화 일경우. 답변글은 비활성화됨. 관리자만 표출 --%>
	<c:if test="${form.pdAt eq 'Y'}">
		<dl id="dtFocus">
			<dt><label for="beginDate"><spring:message code="info.postDt" /></label></dt>
			<dd>
				<input type="text" class="maskDate nothangul small" id="beginDate" name="beginDate" maxlength="10" value="<c:out value="${boardData.beginDate}" />" placeholder="<spring:message code="info.beginDt.dt" />" title="<spring:message code="info.beginDt.dt" />">
				<input type="text" class="maskTime nothangul small" id="beginTime" name="beginTime" maxlength="5" value="<c:out value="${boardData.beginTime}" />" placeholder="<spring:message code="info.beginDt.tm" />" title="<spring:message code="info.beginDt.tm" />">
				<span class="separator"> ~ </span>
				<input type="text" class="maskDate nothangul small" id="endDate" name="endDate" maxlength="10" value="<c:out value="${boardData.endDate}" />" placeholder="<spring:message code="info.endDt.dt" />" title="<spring:message code="info.endDt.dt" />">
				<input type="text" class="maskTime nothangul small" id="endTime" name="endTime" maxlength="5" value="<c:out value="${boardData.endTime}" />" placeholder="<spring:message code="info.endDt.tm" />" title="<spring:message code="info.endDt.tm" />">
				<small><spring:message code="info.date" /> : <c:out value="${currentYYMM}" />-01, <spring:message code="info.time" /> : 18:00</small>
			</dd>
		</dl>
	</c:if>
	<%-- 공지사항이 활성화 일경우. 답변글은 비활성화됨. 관리자만 표출 --%>
	<c:if test="${form.noticeAt eq 'Y'}">
		<dl id="ndtFocus">
			<dt><label for="noticeAt"><spring:message code="info.notice" /></label></dt>
			<dd>
				<input type="checkbox" id="noticeAt" name="noticeAt" value="Y"<c:if test="${boardData.noticeAt eq 'Y'}"> checked</c:if>>
				<label for="noticeAt"> <spring:message code="info.notice" /> </label>
				<div>
					<input type="text" class="maskDate nothangul small" id="noticeBeginDate" name="noticeBeginDate" maxlength="10" value="<c:out value="${boardData.noticeBeginDate}" />" placeholder="<spring:message code="info.noticeBeginDt.dt" />" title="<spring:message code="info.noticeBeginDt.dt" />"<c:if test="${boardData.noticeAt ne 'Y'}"> disabled</c:if>>
					<input type="text" class="maskTime nothangul small" id="noticeBeginTime" name="noticeBeginTime" maxlength="5" value="<c:out value="${boardData.noticeBeginTime}" />" placeholder="<spring:message code="info.noticeBeginDt.tm" />" title="<spring:message code="info.noticeBeginDt.tm" />"<c:if test="${boardData.noticeAt ne 'Y'}"> disabled</c:if>>
					<span class="separator"> ~ </span>
					<input type="text" class="maskDate nothangul small" id="noticeEndDate" name="noticeEndDate" maxlength="10" value="<c:out value="${boardData.noticeEndDate}" />" placeholder="<spring:message code="info.noticeEndDt.dt" />" title="<spring:message code="info.noticeEndDt.dt" />"<c:if test="${boardData.noticeAt ne 'Y'}"> disabled</c:if>>
					<input type="text" class="maskTime nothangul small" id="noticeEndTime" name="noticeEndTime" maxlength="5" value="<c:out value="${boardData.noticeEndTime}" />" placeholder="<spring:message code="info.noticeEndDt.tm" />" title="<spring:message code="info.noticeEndDt.tm" />"<c:if test="${boardData.noticeAt ne 'Y'}"> disabled</c:if>>
					<small><spring:message code="info.date" /> : <c:out value="${currentYYMM}" />-01, <spring:message code="info.time" /> : 18:00</small>
				</div>
			</dd>
		</dl>
	</c:if>
	<%-- 게시판 항목관리 설정값에 의해 표출됨. --%>
	<c:if test="${not empty boardItem && fn:length(boardItem) > 0}">
		<c:forEach var="item" items="${boardItem}">
		<dl id="cFocus_<c:out value="${item.iemId}" />">
			<dt><c:if test="${item.reqrdAt eq 'Y'}" ><span>*</span> </c:if><label for="<c:out value="${item.iemId}" />"><c:out value="${item.iemNm}" /></label></dt>
			<dd>
			<c:choose>
				<%-- 한줄입력칸/URL/이메일 형식일때 --%>
				<c:when test="${item.iemSe eq 'T' || item.iemSe eq 'U' || item.iemSe eq 'V' || item.iemSe eq 'E'}">
					<input type="text" id="<c:out value="${item.iemId}" />" name="<c:out value="${item.iemId}" />" maxlength="100" value="<c:out value="${item.val}" />"<c:if test="${item.iemSe eq 'U' || item.iemSe eq 'V'}"> placeholder="http://"</c:if>>
				</c:when>
				<%-- URL(링크명 포함) 형식 --%>
				<c:when test="${item.iemSe eq 'L'}">
					<input type="text" class="small20 siiru-mr10" id="<c:out value="${item.iemId}" />_1" name="<c:out value="${item.iemId}" />_1" maxlength="50" value="<c:out value="${item.val1}" />" title="<spring:message code="info.url.nm" />">
					<input type="text" class="small75" id="<c:out value="${item.iemId}" />_2" name="<c:out value="${item.iemId}" />_2" maxlength="80" value="<c:out value="${item.val2}" />" placeholder="http://" title="<spring:message code="info.url.addr" />">
					<input type="hidden" id="<c:out value="${item.iemId}" />" name="<c:out value="${item.iemId}" />" value="<c:out value="${item.val}" />">
				</c:when>
				<%-- 전화번호 형식일때 --%>
				<c:when test="${item.iemSe eq 'P'}">
					<input type="text" class="numeric nothangul small" id="<c:out value="${item.iemId}" />_1" name="<c:out value="${item.iemId}" />_1" maxlength="4" value="<c:out value="${item.val1}" />" title="<spring:message code="info.phone.area" />">
					<span class="separator"> - </span>
					<input type="text" class="numeric nothangul small" id="<c:out value="${item.iemId}" />_2" name="<c:out value="${item.iemId}" />_2" maxlength="4" value="<c:out value="${item.val2}" />" title="<spring:message code="info.phone.mid" />">
					<span class="separator"> - </span>
					<input type="text" class="numeric nothangul small" id="<c:out value="${item.iemId}" />_3" name="<c:out value="${item.iemId}" />_3" maxlength="4" value="<c:out value="${item.val3}" />" title="<spring:message code="info.phone.last" />">
					<input type="hidden" id="<c:out value="${item.iemId}" />" name="<c:out value="${item.iemId}" />" value="<c:out value="${item.val}" />">
					<small><spring:message code="info.phone.msg" /></small>
				</c:when>
				<%-- 주소 형식일때 --%>
				<c:when test="${item.iemSe eq 'J'}">
					<input type="text" class="small telText nothangul" id="<c:out value="${item.iemId}" />_1" name="<c:out value="${item.iemId}" />_1" maxlength="7" value="<c:out value="${item.val1}" />" title="<spring:message code="info.address.zip" />">
					<button type="button" class="zipFind siiru-btn siiru-btn-small siiru-ml10" data-iem="<c:out value="${item.iemId}" />"> <spring:message code="info.address.find" /> </button>
					<input type="text" class="siiru-mt5" id="<c:out value="${item.iemId}" />_2" name="<c:out value="${item.iemId}" />_2" maxlength="100" value="<c:out value="${item.val2}" />" title="<spring:message code="info.address" />">
					<input type="text" class="siiru-mt5" id="<c:out value="${item.iemId}" />_3" name="<c:out value="${item.iemId}" />_3" maxlength="100" value="<c:out value="${item.val3}" />" title="<spring:message code="info.address.detail" />">
					<input type="hidden" id="<c:out value="${item.iemId}" />" name="<c:out value="${item.iemId}" />" value="<c:out value="${item.val}" />">
				</c:when>
				<%-- 여러 줄 입력칸(textarea) 형식일때 --%>
				<c:when test="${item.iemSe eq 'A'}">
					<textarea id="<c:out value="${item.iemId}" />" name="<c:out value="${item.iemId}" />" maxlength="1000" rows="4"><c:out value="${item.val}" /></textarea>
				</c:when>
				<%-- 단일선택(radio) 형식일때 --%>
				<c:when test="${item.iemSe eq 'R'}">
					<c:forEach var="code" items="${item.codeList}" varStatus="codeStatus">
					<input type="radio" id="<c:out value="${item.iemId}" />_<c:out value="${codeStatus.index}" />" name="<c:out value="${item.iemId}" />" value="<c:out value="${code.codeId}" />"<c:out value="${code.checked}" />>
					<label for="<c:out value="${item.iemId}" />_<c:out value="${codeStatus.index}" />"> <c:out value="${code.codeNm}" /> </label>
					</c:forEach>
				</c:when>
				<%-- 단일선택(single select) 형식일때 --%>
				<c:when test="${item.iemSe eq 'S'}">
					<select id="<c:out value="${item.iemId}" />" name="<c:out value="${item.iemId}" />">
						<option value="">선택</option>
						<c:forEach var="code" items="${item.codeList}" varStatus="codeStatus">
						<option value="<c:out value="${code.codeId}" />"<c:out value="${code.selected}" />><c:out value="${code.codeNm}" /></option>
						</c:forEach>
					</select>
				</c:when>
				<%-- 다중선택(checkbox) 형식일때 --%>
				<c:when test="${item.iemSe eq 'C'}">
					<c:forEach var="code" items="${item.codeList}" varStatus="codeStatus">
					<input type="checkbox" id="<c:out value="${item.iemId}" />_<c:out value="${codeStatus.index}" />" name="<c:out value="${item.iemId}" />[]" value="<c:out value="${code.codeId}" />"<c:out value="${code.checked}" />>
					<label for="<c:out value="${item.iemId}" />_<c:out value="${codeStatus.index}" />"> <c:out value="${code.codeNm}" /> </label>
					</c:forEach>
					<input type="hidden" id="<c:out value="${item.iemId}" />" name="<c:out value="${item.iemId}" />" value="<c:out value="${item.val}" />">
				</c:when>
				<%-- 코드단계(select) 형식일때 --%>
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
				<%-- 일자(년월일) 형식일때 --%>
				<c:when test="${item.iemSe eq 'D'}">
					<input type="text" class="dateForm maskDate nothangul small" id="<c:out value="${item.iemId}" />" name="<c:out value="${item.iemId}" />" maxlength="10" value="<c:out value="${item.val}" />">
				</c:when>
				<%-- 시간(시분) 형식일때 --%>
				<c:when test="${item.iemSe eq 'H'}">
					<input type="text" class="maskTime nothangul small" id="<c:out value="${item.iemId}" />" name="<c:out value="${item.iemId}" />" maxlength="5" value="<c:out value="${item.val}" />">
				</c:when>
				<%-- 기간(시작일자 ~ 종료일자) --%>
				<c:when test="${item.iemSe eq 'M'}">
					<input type="text" class="dateForm maskDate nothangul small" id="<c:out value="${item.iemId}" />_1" name="<c:out value="${item.iemId}" />_1" maxlength="10" value="<c:out value="${item.val1}" />" title="<spring:message code="info.beginDt.dt" />">
					<span class="separator"> ~ </span>
					<input type="text" class="dateForm maskDate nothangul small" id="<c:out value="${item.iemId}" />_2" name="<c:out value="${item.iemId}" />_2" maxlength="10" value="<c:out value="${item.val2}" />" title="<spring:message code="info.endDt.tm" />">
					<input type="hidden" id="<c:out value="${item.iemId}" />" name="<c:out value="${item.iemId}" />" value="<c:out value="${item.val}" />">
				</c:when>
				<%-- 기간(시작일시 ~ 종료일시) --%>
				<c:when test="${item.iemSe eq 'Z'}">
					<input type="text" class="beginDate dateForm maskDate nothangul small" id="<c:out value="${item.iemId}" />_T1" name="<c:out value="${item.iemId}" />_T1" maxlength="10" value="<c:out value="${item.val1t}" />" title="<spring:message code="info.beginDt.dt" />">
					<input type="text" class="beginTime maskTime nothangul small" id="<c:out value="${item.iemId}" />_T2" name="<c:out value="${item.iemId}" />_T2" maxlength="5" value="<c:out value="${item.val2t}" />" title="<spring:message code="info.beginDt.tm" />">
					<span class="separator"> ~ </span>
					<input type="text" class="endDate dateForm maskDate nothangul small" id="<c:out value="${item.iemId}" />_T3" name="<c:out value="${item.iemId}" />_T3" maxlength="10" value="<c:out value="${item.val3t}" />" title="<spring:message code="info.endDt.dt" />">
					<input type="text" class="endTime maskTime nothangul small" id="<c:out value="${item.iemId}" />_T4" name="<c:out value="${item.iemId}" />_T4" maxlength="5" value="<c:out value="${item.val4t}" />" title="<spring:message code="info.endDt.tm" />">
					<input type="hidden" id="<c:out value="${item.iemId}" />_1" name="<c:out value="${item.iemId}" />_1" value="<c:out value="${item.val1}" />">
					<input type="hidden" id="<c:out value="${item.iemId}" />_2" name="<c:out value="${item.iemId}" />_2" value="<c:out value="${item.val2}" />">
					<input type="hidden" id="<c:out value="${item.iemId}" />" name="<c:out value="${item.iemId}" />" value="<c:out value="${item.val}" />">
					<small><spring:message code="info.date" /> : <c:out value="${currentYYMM}" />-01, <spring:message code="info.time" /> : 18:00</small>
				</c:when>
			</c:choose>
			</dd>
		</dl>
		</c:forEach>
	</c:if>
	<%-- 공공누리가 활성화 일경우. 답변글은 비활성화됨. --%>
	<c:if test="${form.koglAt eq 'Y'}">
		<dl id="kFocus">
			<dt class="siiru-pt10"><span>*</span> <spring:message code="info.koglSe" /></dt>
			<dd>
			<%-- 공공누리 설명글. 사이트 언어가 한글일 경우만 표출 --%>
			<small>
				저작권법 24조의2에 따라 국가나 지방자치단체, 공공기관이 업무상 작성하여 공표한 저작물이나 저작재산권 전부를 보유한 저작물은 국민이 허락 없이 이용할 수 있으며, 이에 따라 개방기관은 공공저작물 자유이용에 관한 표시를 하여야 합니다. <a href="http://www.kogl.or.kr/info/freeUse.do" class="blue" target="_blank">상세내용 : 공공누리 홈페이지 참조</a><br>
				- 공공누리 제2~4유형의 적용은 공동저작물 등 제3자의 권리가 포함된 저작물에 한하여 제3자의 이용허락 범위에 따라 제한적으로 적용<br>
				- 공공저작권 관련 상담센터 : 전화 1670-0052<br>
				- <a href="https://www.kogl.or.kr/info/license.do" class="blue" target="_blank">공공누리 소개 - 유형안내</a><br>
				- <a href="https://www.law.go.kr/법령/저작권법" class="blue" target="_blank">저작권법 제24조의2 제1항 제1호~제4호의 경우</a>
			</small>
			<c:if test="${not empty koglList and fn:length(koglList) > 0}">
				<c:forEach var="kogl" items="${koglList}" varStatus="status">
				<div class="radioBlock">
					<input type="radio" id="koglSe${kogl.codeId}" name="koglSe" value="${kogl.codeId}"${kogl.checked}>
					<label for="koglSe${kogl.codeId}"> <c:if test="${kogl.codeId ne '0'}"><img src="${path.context}home/siiru/images/img_opencode${kogl.codeId}.png" style="height:40px;" alt="${kogl.codeNm}"></c:if> <c:out value="${kogl.codeNm}" /> </label>
				</div>
				</c:forEach>
			</c:if>
			</dd>
		</dl>
	</c:if>
	<%-- 첨부파일이 활성화 일경우 --%>
	<c:if test="${form.fileAt eq 'Y'}">
		<dl>
			<dt class="siiru-pt10"><c:out value="${boardFieldNm.file}" /> <span class="btnLayer"><button class="fileAdd siiru-btn siiru-btn-small" type="button"><spring:message code="info.add" /></button></span></dt>
			<dd class="fileChk">
				<div class="fileLayer">
					<%-- 등록일 경우 기본 폼. 수정일 경우 첫번째 첨부파일 --%>
					<div class="fileInfo">
						<input type="hidden" name="fileSn[]" value="<c:out value="${boardFile.file.fileSn}" />">
						<input type="hidden" name="rlFileOldNm[]" value="<c:out value="${boardFile.file.rlFileNm}" />">
						<input type="hidden" name="fileOldNm[]" value="<c:out value="${boardFile.file.fileNm}" />">
						<input type="hidden" name="insrtAt[]" value="<c:out value="${boardFile.file.insrtAt}" default="N" />">
						<input type="hidden" name="thumbAt[]" value="<c:out value="${boardFile.file.thumbAt}" default="N" />">
						<input type="hidden" name="fileDelAt[]" value="N">
						<span class="fileView"><a href="<c:out value="${boardFile.file.fileUrl}" />" target="_blank"><c:out value="${boardFile.file.fileNm}" /></a></span>
						<input type="checkbox" class="fileCheckbox" id="delFile0" name="fileDelChk[]" data-input="fileDel" value="Y" title="Delete Files">
						<label for="delFile0"> Delete Files </label>
					</div>
					<input type="file" name="fileNm0" class="file" title="<spring:message code="info.file.select" />">
					<input type="checkbox" id="insrtFile0" name="insrtChk[]" data-input="insrt" class="fileCheckbox" value="Y"<c:if test="${boardFile.file.insrtAt eq 'Y'}"> checked</c:if>>
					<label for="insrtFile0">본문에삽입</label>
					<textarea name="fileAlt[]" rows="3" class="siiru-mt10" title="<spring:message code="info.file.textarea" />"><c:out value="${boardFile.file.fileAlt}" /></textarea>
					<small><spring:message code="info.file.msg" /></small>
				</div>
				<div id="fileForm">
				<%-- 수정일 경우 두번째 첨부파일 부터 --%>
				<c:if test="${not empty boardFile.fileList && fn:length(boardFile.fileList) > 0}">
					<c:forEach var="file" items="${boardFile.fileList}" varStatus="status">
					<div class="fileLayer siiru-mt10">
						<div class="fileInfo">
							<input type="hidden" name="fileSn[]" value="<c:out value="${file.fileSn}" />">
							<input type="hidden" name="rlFileOldNm[]" value="<c:out value="${file.rlFileNm}" />">
							<input type="hidden" name="fileOldNm[]" value="<c:out value="${file.fileNm}" />">
							<input type="hidden" name="insrtAt[]" value="<c:out value="${file.insrtAt}" default="N" />">
							<input type="hidden" name="thumbAt[]" value="<c:out value="${file.thumbAt}" default="N" />">
							<input type="hidden" name="fileDelAt[]" value="N">
							<span class="fileView"><a href="<c:out value="${file.fileUrl}" />" target="_blank"><c:out value="${file.fileNm}" /></a></span>
							<input type="checkbox" class="fileCheckbox" id="delFile${(status.index+1)}" name="fileDelChk[]" data-input="fileDel" value="Y" title="Delete Files">
							<label for="delFile${(status.index+1)}"> Delete Files </label>
						</div>
						<input type="file" name="fileNm${(status.index+1)}" class="file" title=""<spring:message code="info.file.select" />">
						<input type="checkbox" id="insrtFile${(status.index+1)}" name="insrtChk[]" data-input="insrt" class="fileCheckbox" value="Y"<c:if test="${file.insrtAt eq 'Y'}"> checked</c:if>>
						<label for="insrtFile${(status.index+1)}">본문에삽입</label>
						<textarea name="fileAlt[]" rows="3" class="siiru-mt10" title="<spring:message code="info.file.textarea" />"><c:out value="${file.fileAlt}" /></textarea>
						<small><spring:message code="info.file.msg" /></small>
					</div>
					</c:forEach>
				</c:if>
				</div>
			</dd>
		</dl>
	</c:if>
		<%-- 내용. 에디터 포함 --%>
		<dl>
			<dt class="siiru-hidden"><spring:message code="info.contents" /></dt>
			<dd class="fullCont">
				<textarea id="boardCn" name="boardCn" rows="20" style="width:98%;height:400px" title="<spring:message code="info.contents" />"><c:out value="${boardData.boardCn}" /></textarea>
			</dd>
		</dl>
	</div>
	<%-- 저장/리스트 버튼 --%>
	<div class="siiru-tc siiru-mb20">
		<input type="submit" class="siiru-btn siiru-btn-primary" value="<spring:message code="button.save" />">
		<a href="<c:out value="${listLink}" />" class="siiru-btn siiru-ml10"><spring:message code="button.list" /></a>
	</div>
	</form>
<%-- 게시판 하단 출력 --%>
<c:if test="${not empty boardMaster.fterCn}">
	<div class="siiru-clr"><jsp:include page="${fterCn}" /></div>
</c:if>
</div>
<c:if test="${form.addressAt eq 'Y'}">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</c:if>
<script>
// 페이지 로드가 완료되면
if (window.addEventListener) window.addEventListener("load", board, false);
else if (window.attachEvent) window.attachEvent("onload", board);
else window.onload = board;
// 저장 버튼 중복 클릭을 막기 위해
var submitYN = 'N';
// 등록
function board() {
	// 게시기간 날짜 변경시 시간자동 표출
	$('#beginDate').change(function() {
		if ($('#beginTime').val() == '') $('#beginTime').val('00:00');
	});
	$('#endDate').change(function() {
		if ($('#endTime').val() == '') $('#endTime').val('23:59');
	});
	// 공지사항 날짜 변경시 시간자동 표출
	$('#noticeBeginDate').change(function() {
		if ($('#noticeBeginTime').val() == '') $('#noticeBeginTime').val('00:00');
	});
	$('#noticeEndDate').change(function() {
		if ($('#noticeEndTime').val() == '') $('#noticeEndTime').val('23:59');
	});
	// 공지사항 체크시 공지기간 입력 활성화
	$(':checkbox[name="noticeAt"]').change(function() {
		if ($(this).is(':checked')) {
			$('#noticeBeginDate').prop('disabled', false);
			$('#noticeBeginTime').prop('disabled', false);
			$('#noticeEndDate').prop('disabled', false);
			$('#noticeEndTime').prop('disabled', false);
		} else {
			$('#noticeBeginDate').prop('disabled', true);
			$('#noticeBeginTime').prop('disabled', true);
			$('#noticeEndDate').prop('disabled', true);
			$('#noticeEndTime').prop('disabled', true);
		}
	});
	// 날짜 변경시 시간자동 표출 (기간)
	$('.beginDate').change(function() {
		$beginTime = $(this).closest('dd').find('.beginTime');
		if ($beginTime.val() == '') $beginTime.val('00:00');
	});
	$('.endDate').change(function() {
		$endTime = $(this).closest('dd').find('.endTime');
		if ($endTime.val() == '') $endTime.val('23:59');
	});
	// 파일 유무에 따른 정보 표출
	$('input[name="rlFileOldNm[]"]').each(function() {
		if ($(this).val() != '') $(this).closest('.fileLayer').find('.fileInfo').show();
	});
	// 파일 삭제/본문에삽입/썸네일로사용 체크 시
	$('.fileChk').on('click', '.fileCheckbox', function() {
		if ($(this).is(':checked')) {
			$(this).closest('.fileLayer').find('input[name="'+$.trim($(this).data('input'))+'At[]"]').val('Y');
		} else {
			$(this).closest('.fileLayer').find('input[name="'+$.trim($(this).data('input'))+'At[]"]').val('N');
		}
	});
	// 파일 추가
	$('.fileAdd').click(function() {
		var fileLength = $('.fileChk .file').length;
		var fileForm = '<div class="fileLayer siiru-mt10">';
		fileForm+= '<input type="hidden" name="fileSn[]" value="0">';
		fileForm+= '<input type="hidden" name="rlFileOldNm[]" value="">';
		fileForm+= '<input type="hidden" name="fileOldNm[]" value="">';
		fileForm+= '<input type="hidden" name="insrtAt[]" value="N">';
		fileForm+= '<input type="hidden" name="thumbAt[]" value="N">';
		fileForm+= '<input type="hidden" name="fileDelAt[]" value="N">';
		fileForm+= '<input type="hidden" name="fileDelChk[]" value="">';
		fileForm+= '<input type="file" name="fileNm'+(fileLength)+'" class="file" title="<spring:message code="info.file.select" />">';
		fileForm+= '<input type="checkbox" id="insrtFile'+(fileLength)+'" name="insrtChk[]" data-input="insrt" class="fileCheckbox" value="Y">';
		fileForm+= '<label for="insrtFile'+(fileLength)+'"> 본문에삽입</label>';
		fileForm+= '<textarea name="fileAlt[]" rows="3" class="siiru-mt10" title="<spring:message code="info.file.textarea" />"></textarea>';
		fileForm+= '<small><spring:message code="info.file.msg" /></small>';
		fileForm+= '</div>';
		$('#fileForm').append(fileForm);
	});
<%-- 에디터 활성일경우 --%>
<c:if test="${form.editrAt eq 'Y'}">
	var oEditors = CKEDITOR.replace('boardCn', {
		height:300,
		filebrowserImageUploadUrl:'${path.context}ckImageUpload.do?folder1=bb&folder2='+$.trim($('#boardId').val())
	});
</c:if>
<c:if test="${form.addressAt eq 'Y'}">
	// 우편번호 찾기 버튼
	$('.zipFind').click(function() {
		zipFind($.trim($(this).data('iem')));
	});
</c:if>
	// 코드선택
	$('.codeStepSelect').change(function() {
		var selectData = $(this).data();
		var itemName = $.trim(selectData.name);
		var selectName = $.trim(selectData.name)+'_codeStep';
		var codeStep = parseInt(selectData.step,10);
		var codeStepMax = parseInt(selectData.maxstep,10);
		var selData = $(this).find(':selected').data();
		var selStep = codeStep+1;
		// 하위단계코드 초기화
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
		// 코드값 삽입
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
	// 저장버튼 클릭시
	$('#boardForm').submit(function(e) {
		// 중복클릭시
		if (submitYN == 'Y') {
			alert('<spring:message code="info.wait.msg" />');
			return false;
		}
	<c:if test="${form.ctgryAt eq 'Y'}">
		// 분류
		if ($.trim($('#ctgrySn').val()) == '') {
			alert('<spring:message code="errors.required" arguments="${alertMsg.ctgryNm}" />');
			$('#ctgrySn').focus();
			return false;
		}
	</c:if>
		// 제목
		if ($.trim($('#boardSj').val()) == '') {
			alert('<spring:message code="errors.required" arguments="${alertMsg.boardSj}" />');
			$('#boardSj').focus();
			return false;
		}
		// 작성자
		if ($.trim($('#userNm').val()) == '') {
			alert('<spring:message code="errors.required" arguments="${alertMsg.userNm}" />');
			$('#userNm').focus();
			return false;
		}
	<c:if test="${form.passwdAt eq 'Y'}">
		// 비밀번호
		if ($.trim($('#passwd').val()) == '') {
			alert('<spring:message code="errors.required" arguments="${alertMsg.passwd}" />');
			$('#passwd').focus();
			return false;
		}
	</c:if>
	<c:if test="${form.captchaAt eq 'Y'}">
		// 캡차코드
		if ($.trim($('#captcha').val()) == '') {
			alert('<spring:message code="errors.required" arguments="${alertMsg.captcha}" />');
			$('#captcha').focus();
			return false;
		}
	</c:if>
	<c:if test="${form.pdAt eq 'Y'}">
		// 게시 기간
		if (($.trim($('#beginDate').val()) == '') && ($.trim($('#beginTime').val()) != '')) {
			alert('<spring:message code="errors.required" arguments="${alertMsg.beginDt}" />');
			$('html,body').animate({scrollTop:$('#dtFocus').offset().top},0);
			return false;
		}
		if ($.trim($('#beginDate').val()) != '') {
			if (!ValidDate($('#beginDate').val())) {
				alert('<spring:message code="errors.date" arguments="${alertMsg.beginDate}" />');
				$('#beginDate').focus();
				return false;
			}
		}
		if (($.trim($('#endDate').val()) == '') && ($.trim($('#endTime').val()) != '')) {
			alert('<spring:message code="errors.required" arguments="${alertMsg.endDt}" />');
			$('html,body').animate({scrollTop:$('#dtFocus').offset().top},0);
			return false;
		}
		if ($.trim($('#endDate').val()) != '') {
			if (!ValidDate($('#endDate').val())) {
				alert('<spring:message code="errors.date" arguments="${alertMsg.endDate}" />');
				$('#endDate').focus();
				return false;
			}
		}
		// 게시 일시 기간 체크
		if (($.trim($('#beginDate').val()) != '') || ($.trim($('#endDate').val()) != '')) {
			if ($.trim($('#beginDate').val()) != '') {
				if ($.trim($('#beginTime').val()) != '') {
					$('#beginDt').val($('#beginDate').val()+' '+$('#beginTime').val()+':00');
				} else {
					$('#beginDt').val($('#beginDate').val()+' 00:00:00');
				}
			}
			if ($.trim($('#endDate').val()) != '') {
				if ($.trim($('#endTime').val()) != '') {
					$('#endDt').val($('#endDate').val()+' '+$('#endTime').val()+':00');
				} else {
					$('#endDt').val($('#endDate').val()+' 00:00:00');
				}
			}
			if (($.trim($('#beginDt').val()) != '') && ($.trim($('#endDt').val()) != '')) {
				var startDate = new Date($('#beginDt').val());
				var stopDate = new Date($('#endDt').val());
				if (startDate > stopDate) {
					alert('<spring:message code="errors.compare" arguments="${alertMsg.postDt}" />');
					$('html,body').animate({scrollTop:$('#dtFocus').offset().top},0);
					return false;
				}
			}
		}
	</c:if>
	<c:if test="${form.noticeAt eq 'Y'}">
		// 공지사항 기간
		if ($(':checkbox[name="noticeAt"]').is(':checked')) {
			if (($.trim($('#noticeBeginDate').val()) == '') && ($.trim($('#noticeBeginTime').val()) != '')) {
				alert('<spring:message code="errors.required" arguments="${alertMsg.noticeBeginDt}" />');
				$('html,body').animate({scrollTop:$('#ndtFocus').offset().top},0);
				return false;
			}
			if ($.trim($('#noticeBeginDate').val()) != '') {
				if (!ValidDate($('#noticeBeginDate').val())) {
					alert('<spring:message code="errors.date" arguments="${alertMsg.noticeBeginDate}" />');
					$('#noticeBeginDate').focus();
					return false;
				}
			}
			if (($.trim($('#noticeEndDate').val()) == '') && ($.trim($('#noticeEndTime').val()) != '')) {
				alert('<spring:message code="errors.required" arguments="${alertMsg.noticeEndDt}" />');
				$('html,body').animate({scrollTop:$('#ndtFocus').offset().top},0);
				return false;
			}
			if ($.trim($('#noticeEndDate').val()) != '') {
				if (!ValidDate($('#noticeEndDate').val())) {
					alert('<spring:message code="errors.date" arguments="${alertMsg.noticeEndDate}" />');
					$('#noticeEndDate').focus();
					return false;
				}
			}
			// 공지사항 기간 체크
			if (($.trim($('#noticeBeginDate').val()) != '') || ($.trim($('#noticeEndDate').val()) != '')) {
				if ($.trim($('#noticeBeginDate').val()) != '') {
					if ($.trim($('#noticeBeginTime').val()) != '') {
						$('#noticeBeginDt').val($('#noticeBeginDate').val()+' '+$('#noticeBeginTime').val()+':00');
					} else {
						$('#noticeBeginDt').val($('#noticeBeginDate').val()+' 00:00:00');
					}
				}
				if ($.trim($('#noticeEndDate').val()) != '') {
					if ($.trim($('#noticeEndTime').val()) != '') {
						$('#noticeEndDt').val($('#noticeEndDate').val()+' '+$('#noticeEndTime').val()+':00');
					} else {
						$('#noticeEndDt').val($('#noticeEndDate').val()+' 00:00:00');
					}
				}
				if (($('#noticeBeginDt').val() != '') && ($('#noticeEndDt').val() != '')) {
					var startDate = new Date($('#noticeBeginDt').val());
					var stopDate = new Date($('#noticeEndDt').val());
					if (startDate > stopDate) {
						alert('<spring:message code="errors.compare" arguments="${alertMsg.noticeDt}" />');
						$('html,body').animate({scrollTop:$('#ndtFocus').offset().top},0);
						return false;
					}
				}
			}
		}
	</c:if>
	<%-- 게시판 항목관리 설정값에 의해 필수입력값 체크 --%>
	<c:if test="${not empty boardItem && fn:length(boardItem) > 0}">
		<c:forEach var="item" items="${boardItem}">
			<c:choose>
				<%-- URL(링크명 포함) 형식 --%>
				<c:when test="${item.iemSe eq 'L'}">
					<c:if test="${item.reqrdAt eq 'Y'}">
		// ${item.iemNm}
		if ($.trim($('#<c:out value="${item.iemId}" />_1').val()) == '') {
			alert('<spring:message code="errors.required" arguments="${alertMsg.urlNm}" />');
			$('#<c:out value="${item.iemId}" />_1').focus();
			return false;
		}
		if ($.trim($('#<c:out value="${item.iemId}" />_2').val()) == '') {
			alert('<spring:message code="errors.required" arguments="${alertMsg.urlAddr}" />');
			$('#<c:out value="${item.iemId}" />_2').focus();
			return false;
		}
					</c:if>
		if ($.trim($('#<c:out value="${item.iemId}" />_2').val()) != '') {
			if (!ValidUrl($('#<c:out value="${item.iemId}" />_2').val())) {
				alert('<spring:message code="errors.url" arguments="${alertMsg[item.iemId]}" />');
				$('#<c:out value="${item.iemId}" />_2').focus();
				return false;
			}
		}
				</c:when>
				<%-- 전화번호가 필수일경우 --%>
				<c:when test="${item.iemSe eq 'P'}">
					<c:if test="${item.reqrdAt eq 'Y'}">
		// ${item.iemNm}
		if ($.trim($('#<c:out value="${item.iemId}" />_1').val()) == '') {
			alert('<spring:message code="errors.required" arguments="${alertMsg.phoneArea}" />');
			$('#<c:out value="${item.iemId}" />_1').focus();
			return false;
		}
		if ($.trim($('#<c:out value="${item.iemId}" />_2').val()) == '') {
			alert('<spring:message code="errors.required" arguments="${alertMsg.phoneMid}" />');
			$('#<c:out value="${item.iemId}" />_2').focus();
			return false;
		}
		if ($.trim($('#<c:out value="${item.iemId}" />_3').val()) == '') {
			alert('<spring:message code="errors.required" arguments="${alertMsg.phoneLast}" />');
			$('#<c:out value="${item.iemId}" />_3').focus();
			return false;
		}
					</c:if>
		if (($.trim($('#<c:out value="${item.iemId}" />_1').val()) != '') || ($.trim($('#<c:out value="${item.iemId}" />_2').val()) != '') || ($.trim($('#<c:out value="${item.iemId}" />_3').val()) != '')) {
			var tel = $.trim($('#<c:out value="${item.iemId}" />_1').val())+'-'+$.trim($('#<c:out value="${item.iemId}" />_2').val())+'-'+$.trim($('#<c:out value="${item.iemId}" />_3').val());
			if (!ValidTel(tel)) {
				alert('<spring:message code="errors.tel" arguments="${alertMsg[item.iemId]}" />');
				$('#<c:out value="${item.iemId}" />_1').focus();
				return false;
			}
		}
				</c:when>
				<%-- 주소가 필수일경우 --%>
				<c:when test="${item.iemSe eq 'J'}">
					<c:if test="${item.reqrdAt eq 'Y'}">
		// ${item.iemNm}
		if ($.trim($('#<c:out value="${item.iemId}" />_1').val()) == '') {
			alert('<spring:message code="errors.required" arguments="${alertMsg.addressZip}" />');
			$('#<c:out value="${item.iemId}" />_1').focus();
			return false;
		}
		if ($.trim($('#<c:out value="${item.iemId}" />_2').val()) == '') {
			alert('<spring:message code="errors.required" arguments="${alertMsg.address}" />');
			$('#<c:out value="${item.iemId}" />_2').focus();
			return false;
		}
					</c:if>
				</c:when>
				<%-- 단일선택(radio)가 필수일경우 --%>
				<c:when test="${item.iemSe eq 'R' && item.reqrdAt eq 'Y'}">
		// ${item.iemNm}
		if (!$(':radio[name="<c:out value="${item.iemId}" />"]').is(':checked')) {
			alert('<spring:message code="errors.required" arguments="${alertMsg[item.iemId]}" />');
			$('html,body').animate({scrollTop:$('#cFocus_<c:out value="${item.iemId}" />').offset().top},0);
			return false;
		}
				</c:when>
				<%-- 다중선택(checkbox)가 필수일경우 --%>
				<c:when test="${item.iemSe eq 'C' && item.reqrdAt eq 'Y'}">
		// ${item.iemNm}
		if ($(':checkbox[name="<c:out value="${item.iemId}" />[]"]:checked').length == 0) {
			alert('<spring:message code="errors.required" arguments="${alertMsg[item.iemId]}" />');
			$('html,body').animate({scrollTop:$('#cFocus_<c:out value="${item.iemId}" />').offset().top},0);
			return false;
		}
				</c:when>
				<%-- 기간(시작일자 ~ 종료일자) --%>
				<c:when test="${item.iemSe eq 'M'}">
					<c:if test="${item.reqrdAt eq 'Y'}">
		// ${item.iemNm} 필수체크
		if ($.trim($('#<c:out value="${item.iemId}" />_1').val()) == '') {
			alert('<spring:message code="errors.required" arguments="${alertMsg[item.iemId]}" />');
			$('#<c:out value="${item.iemId}" />_1').focus();
			return false;
		}
		if ($.trim($('#<c:out value="${item.iemId}" />_2').val()) == '') {
			alert('<spring:message code="errors.required" arguments="${alertMsg[item.iemId]}" />');
			$('#<c:out value="${item.iemId}" />_2').focus();
			return false;
		}
					</c:if>
		if ($.trim($('#<c:out value="${item.iemId}" />_1').val()) != '') {
			if (!ValidDate($('#<c:out value="${item.iemId}" />_1').val())) {
				alert('<spring:message code="errors.date" arguments="${alertMsg[item.iemId]}" />');
				$('#<c:out value="${item.iemId}" />_1').focus();
				return false;
			}
		}
		if ($.trim($('#<c:out value="${item.iemId}" />_2').val()) != '') {
			if (!ValidDate($('#<c:out value="${item.iemId}" />_2').val())) {
				alert('<spring:message code="errors.date" arguments="${alertMsg[item.iemId]}" />');
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
					alert('<spring:message code="errors.compare" arguments="${alertMsg[item.iemId]}" />');
					$('html,body').animate({scrollTop:$('#cFocus_<c:out value="${item.iemId}" />').offset().top},0);
					return false;
				}
			}
		}
				</c:when>
				<%-- 기간(시작일시 ~ 종료일시) --%>
				<c:when test="${item.iemSe eq 'Z'}">
					<c:if test="${item.reqrdAt eq 'Y'}">
		// ${item.iemNm} 필수체크
		if ($.trim($('#<c:out value="${item.iemId}" />_T1').val()) == '') {
			alert('<spring:message code="errors.required" arguments="${alertMsg[item.iemId]}" />');
			$('#<c:out value="${item.iemId}" />_T1').focus();
			return false;
		}
		if ($.trim($('#<c:out value="${item.iemId}" />_T2').val()) == '') {
			alert('<spring:message code="errors.required" arguments="${alertMsg[item.iemId]}" />');
			$('#<c:out value="${item.iemId}" />_T2').focus();
			return false;
		}
		if ($.trim($('#<c:out value="${item.iemId}" />_T3').val()) == '') {
			alert('<spring:message code="errors.required" arguments="${alertMsg[item.iemId]}" />');
			$('#<c:out value="${item.iemId}" />_T3').focus();
			return false;
		}
		if ($.trim($('#<c:out value="${item.iemId}" />_T4').val()) == '') {
			alert('<spring:message code="errors.required" arguments="${alertMsg[item.iemId]}" />');
			$('#<c:out value="${item.iemId}" />_T4').focus();
			return false;
		}
					</c:if>
		if (($('#<c:out value="${item.iemId}" />_T1').val() == '') && ($('#<c:out value="${item.iemId}" />_T2').val() != '')) {
			alert('<spring:message code="errors.required" arguments="${alertMsg[item.iemId]}" />');
			$('#<c:out value="${item.iemId}" />_T1').focus();
			return false;
		}
		if (($('#<c:out value="${item.iemId}" />_T3').val() == '') && ($('#<c:out value="${item.iemId}" />_T4').val() != '')) {
			alert('<spring:message code="errors.required" arguments="${alertMsg[item.iemId]}" />');
			$('#<c:out value="${item.iemId}" />_T3').focus();
			return false;
		}
		if ($.trim($('#<c:out value="${item.iemId}" />_T1').val()) != '') {
			if (!ValidDate($('#<c:out value="${item.iemId}" />_T1').val())) {
				alert('<spring:message code="errors.date" arguments="${alertMsg[item.iemId]}" />');
				$('#<c:out value="${item.iemId}" />_T1').focus();
				return false;
			}
		}
		if ($.trim($('#<c:out value="${item.iemId}" />_T2').val()) != '') {
			if (!ValidTime($('#<c:out value="${item.iemId}" />_T2').val())) {
				alert('<spring:message code="errors.time" arguments="${alertMsg[item.iemId]}" />');
				$('#<c:out value="${item.iemId}" />_T2').focus();
				return false;
			}
		}
		if ($.trim($('#<c:out value="${item.iemId}" />_T3').val()) != '') {
			if (!ValidDate($('#<c:out value="${item.iemId}" />_T3').val())) {
				alert('<spring:message code="errors.date" arguments="${alertMsg[item.iemId]}" />');
				$('#<c:out value="${item.iemId}" />_T3').focus();
				return false;
			}
		}
		if ($.trim($('#<c:out value="${item.iemId}" />_T4').val()) != '') {
			if (!ValidTime($('#<c:out value="${item.iemId}" />_T4').val())) {
				alert('<spring:message code="errors.time" arguments="${alertMsg[item.iemId]}" />');
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
					alert('<spring:message code="errors.compare" arguments="${alertMsg[item.iemId]}" />');
					$('html,body').animate({scrollTop:$('#cFocus_<c:out value="${item.iemId}" />').offset().top},0);
					return false;
				}
			}
		}
				</c:when>
				<%-- 기타 항목 필수일경우 --%>
				<c:otherwise>
					<c:if test="${item.reqrdAt eq 'Y'}">
		// ${item.iemNm}
		if ($.trim($('#<c:out value="${item.iemId}" />').val()) == '') {
			alert('<spring:message code="errors.required" arguments="${alertMsg[item.iemId]}" />');
			$('#<c:out value="${item.iemId}" />').focus();
			return false;
		}
					</c:if>
					<c:choose>
						<%-- 이메일 유효성 체크 --%>
						<c:when test="${item.iemSe eq 'E'}">
		if ($.trim($('#<c:out value="${item.iemId}" />').val()) != '') {
			if (!ValidEmail($('#<c:out value="${item.iemId}" />').val())) {
				alert('<spring:message code="errors.email" arguments="${alertMsg[item.iemId]}" />');
				$('#<c:out value="${item.iemId}" />').focus();
				return false;
			}
		}
						</c:when>
						<%-- URL 유효성 체크 --%>
						<c:when test="${item.iemSe eq 'U'}">
		if ($.trim($('#<c:out value="${item.iemId}" />').val()) != '') {
			if (!ValidUrl($('#<c:out value="${item.iemId}" />').val())) {
				alert('<spring:message code="errors.url" arguments="${alertMsg[item.iemId]}" />');
				$('#<c:out value="${item.iemId}" />').focus();
				return false;
			}
		}
						</c:when>
						<%-- DATE 유효성 체크 --%>
						<c:when test="${item.iemSe eq 'D'}">
		if ($.trim($('#<c:out value="${item.iemId}" />').val()) != '') {
			if (!ValidDate($('#<c:out value="${item.iemId}" />').val())) {
				alert('<spring:message code="errors.date" arguments="${alertMsg[item.iemId]}" />');
				$('#<c:out value="${item.iemId}" />').focus();
				return false;
			}
		}
						</c:when>
						<%-- 시간 유효성 체크 --%>
						<c:when test="${item.iemSe eq 'H'}">
		if ($.trim($('#<c:out value="${item.iemId}" />').val()) != '') {
			if (!ValidTime($('#<c:out value="${item.iemId}" />').val())) {
				alert('<spring:message code="errors.time" arguments="${alertMsg[item.iemId]}" />');
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
	<c:if test="${form.koglAt eq 'Y'}">
		// 공공누리
		if (!$(':radio[name="koglSe"]').is(':checked')) {
			alert('<spring:message code="errors.required" arguments="${alertMsg.koglSe}" />');
			$('html,body').animate({scrollTop:$('#kFocus').offset().top},0);
			return false;
		}
	</c:if>
		// 저장 폼 정리
	<%-- 게시판 항목관리 설정값에 의해 등록 폼 정리 --%>
	<c:if test="${not empty boardItem && fn:length(boardItem) > 0}">
		<c:forEach var="item" items="${boardItem}">
			<%-- URL(링크명 포함) 형식. 명칭|URL --%>
			<c:if test="${item.iemSe eq 'L'}">
		// ${item.iemNm}
		if (($.trim($('#<c:out value="${item.iemId}" />_1').val()) != '') || ($.trim($('#<c:out value="${item.iemId}" />_2').val()) != '')) {
			$('#<c:out value="${item.iemId}" />').val($.trim($('#<c:out value="${item.iemId}" />_1').val())+'|'+$.trim($('#<c:out value="${item.iemId}" />_2').val()));
		} else {
			$('#<c:out value="${item.iemId}" />').val('');
		}
			</c:if>
			<%-- 전화번호 일경우 입력값을 전화번호 형식에 맞게 정리. 0000-0000-0000 --%>
			<c:if test="${item.iemSe eq 'P'}">
		// ${item.iemNm}
		if (($.trim($('#<c:out value="${item.iemId}" />_1').val()) != '') || ($.trim($('#<c:out value="${item.iemId}" />_2').val()) != '') || ($.trim($('#<c:out value="${item.iemId}" />_3').val()) != '')) {
			$('#<c:out value="${item.iemId}" />').val($.trim($('#<c:out value="${item.iemId}" />_1').val())+'-'+$.trim($('#<c:out value="${item.iemId}" />_2').val())+'-'+$.trim($('#<c:out value="${item.iemId}" />_3').val()));
		} else {
			$('#<c:out value="${item.iemId}" />').val('');
		}
			</c:if>
			<%-- 주소 일경우 형식. 우편번호|주소|상세주소 --%>
			<c:if test="${item.iemSe eq 'J'}">
		// ${item.iemNm}
		if (($.trim($('#<c:out value="${item.iemId}" />_1').val()) != '') || ($.trim($('#<c:out value="${item.iemId}" />_2').val()) != '') || ($.trim($('#<c:out value="${item.iemId}" />_3').val()) != '')) {
			$('#<c:out value="${item.iemId}" />').val($.trim($('#<c:out value="${item.iemId}" />_1').val())+'|'+$.trim($('#<c:out value="${item.iemId}" />_2').val())+'|'+$.trim($('#<c:out value="${item.iemId}" />_3').val()));
		} else {
			$('#<c:out value="${item.iemId}" />').val('');
		}
			</c:if>
			<%-- 다중선택(checkbox) 일경우 선택값을 문자열로 정리. **,**,** --%>
			<c:if test="${item.iemSe eq 'C'}">
		// ${item.iemNm}
		var <c:out value="${item.iemId}" />Arr = [];
		$(':checkbox[name="<c:out value="${item.iemId}" />[]"]:checked').each(function() {
			<c:out value="${item.iemId}" />Arr.push($(this).val());
		});
		$('#<c:out value="${item.iemId}" />').val(<c:out value="${item.iemId}" />Arr);
			</c:if>
			<%-- 기간(시작일자 ~ 종료일자) 일경우 --%>
			<c:if test="${item.iemSe eq 'M'}">
		// ${item.iemNm}
		if (($.trim($('#<c:out value="${item.iemId}" />_1').val()) != '') || ($.trim($('#<c:out value="${item.iemId}" />_2').val()) != '')) {
			$('#<c:out value="${item.iemId}" />').val($.trim($('#<c:out value="${item.iemId}" />_1').val())+' ~ '+$.trim($('#<c:out value="${item.iemId}" />_2').val()));
		} else {
			$('#<c:out value="${item.iemId}" />').val('');
		}
			</c:if>
			<%-- 기간(시작일시 ~ 종료일시) 일경우 --%>
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
		if (($.trim($('#<c:out value="${item.iemId}" />_1').val()) != '') || ($.trim($('#<c:out value="${item.iemId}" />_2').val()) != '')) {
			$('#<c:out value="${item.iemId}" />').val($.trim($('#<c:out value="${item.iemId}" />_1').val())+' ~ '+$.trim($('#<c:out value="${item.iemId}" />_2').val()));
		} else {
			$('#<c:out value="${item.iemId}" />').val('');
		}
			</c:if>
		</c:forEach>
	</c:if>
	<c:if test="${form.editrAt eq 'Y'}">
		// 에디터값 셋팅
		$('#boardCn').val(oEditors.getData());
	</c:if>
		var confm = true;
	<c:if test="${boardMaster.confmAt eq 'Y'}">
		confm = confirm('<spring:message code="info.saveConfm" />');
	</c:if>
		if (confm) {
			// 저장 대기 체크
			submitYN = 'Y';
			// 게시글 등록
			var formData = new FormData($('#boardForm')[0]);
				$.each($('#boardSearchForm').serializeArray(), function() {
					formData.append(this.name, this.value);
				});
			ajaxForm('${path.context}setBoardMerge.do', formData, function(data) {
				if (data.error == 'Y') {
					// 저장 대기 초기화
					submitYN = 'N';
				}
			});
		}
		return false;
	});
}
<c:if test="${form.addressAt eq 'Y'}">
// 우편번호
function zipFind(iem) {
	new daum.Postcode({
		oncomplete: function(data) {
			var extraAddr = ''; // 조합형 주소 변수
			// 도로명 주소로만 가져온다.
			var fullAddr = $.trim(data.roadAddress);
			// 법정동명이 있을 경우 추가한다.
			if ($.trim(data.bname) !== '') extraAddr+= $.trim(data.bname);
			// 건물명이 있을 경우 추가한다.
			if ($.trim(data.buildingName) !== '') extraAddr+= (extraAddr !== '' ? ', '+$.trim(data.buildingName) : $.trim(data.buildingName));
			// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
			fullAddr+= (extraAddr !== '' ? ' ('+extraAddr+')' : '');
			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			$('#'+iem+'_1').val($.trim(data.zonecode));
			$('#'+iem+'_2').val(fullAddr);
			$('#'+iem+'_3').focus();
		}
	}).open();
}
</c:if>
</script>
<%-- 레이아웃 하단 출력 --%>
<c:if test="${footerUrl != null}"><jsp:include page="${footerUrl}" /></c:if>
<%@ include file="/WEB-INF/jsp/home/siiru/include/footer.jsp" %>