<%@ include file="/WEB-INF/jsp/home/siiru/include/header.jsp" %>
<%-- 레이아웃 상단 출력 --%>
<c:if test="${headerUrl != null}"><jsp:include page="${headerUrl}" /></c:if>
<div class="siiru-boardWrap">
<%-- 게시판 상단 출력 --%>
<c:if test="${not empty boardMaster.hderCn}">
	<div class="siiru-clr"><jsp:include page="${hderCn}" /></div>
</c:if>
	<%-- 페이지/게시판 정보 및 검색정보/페이지번호를 가지고 다니기 위해 --%>
	<form id="boardSearchForm" name="boardSearchForm" method="post" action="${path.sContext}boardList.do">
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
	<div class="siiruBoard-view">
		<form id="boardForm" name="boardForm" method="post">
		<%-- 게시글 키값 --%>
		<input type="hidden" id="seq" name="seq" value="<c:out value="${param.seq}" />">
		<%-- 게시글 정보 및 분류/비밀글/제목 표출 --%>
		<h4<c:if test="${boardData.state eq 'D' || boardData.state eq 'A'}"> class="text-danger"</c:if>>
			<c:if test="${boardData.noticeAt eq 'Y'}"><span class="notice">Notice</span> </c:if>
			<c:if test="${not empty boardData.stateNm && boardData.stateNm ne ''}">[<c:out value="${boardData.stateNm}" />] </c:if>
			<c:if test="${not empty boardData.mainExpsrNm && boardData.mainExpsrNm ne ''}">[<c:out value="${boardData.mainExpsrNm}" />] </c:if>
			<c:if test="${boardData.secretAt eq 'Y'}"><img src="${path.context}home/siiru/images/icon-secret.png" alt="<spring:message code="info.secret" />" class="secret"> </c:if>
			<c:if test="${not empty boardData.ctgryNm && boardData.ctgryNm ne ''}">[<c:out value="${boardData.ctgryNm}" />] </c:if>
			<c:out value="${boardData.boardSj}" />
		</h4>
		<div class="siiruBoardInfo">
			<%-- 작성자/작성일/조회수 --%>
			<div class="boardInfo-view">
				<span><c:out value="${boardFieldNm.userNm}" /> : <c:out value="${boardData.userNm}" /></span>
				<span><c:out value="${boardFieldNm.regDt}" /> : <c:out value="${boardData.regDt}" /></span>
				<span><c:out value="${boardData.rdcnt}" /></span>
			</div>
			<%-- 게시기간이 있을경우 --%>
			<c:if test="${not empty boardData.viewDate && boardData.viewDate ne ''}">
			<dl>
				<dt><spring:message code="info.postDate" /></dt>
				<dd><c:out value="${boardData.viewDate}" /></dd>
			</dl>
			</c:if>
			<%-- 공지기간이 있을경우 --%>
			<c:if test="${not empty boardData.noticeDate && boardData.noticeDate ne ''}">
			<dl>
				<dt><spring:message code="info.noticeDate" /></dt>
				<dd><c:out value="${boardData.noticeDate}" /></dd>
			</dl>
			</c:if>
			<%-- 게시판 항목관리 설정값에 의해 표출 --%>
			<c:if test="${not empty boardItem && fn:length(boardItem) > 0}">
				<c:forEach var="item" items="${boardItem}">
			<dl>
				<dt><c:out value="${item.iemNm}" /></dt>
				<dd<c:if test="${(item.iemSe eq 'T' || item.iemSe eq 'P' || item.iemSe eq 'E' || item.iemSe eq 'J') && item.encptAt eq 'Y'}"> class="privacyHidden"</c:if>><c:out value="${item.val}" escapeXml="false" /></dd>
			</dl>
				</c:forEach>
			</c:if>
			<%-- 첨부파일이 있을 경우 --%>
			<c:if test="${boardMaster.fileAt eq 'Y' && (not empty boardFile && fn:length(boardFile) > 0)}">
			<dl>
				<dt><c:out value="${boardFieldNm.file}" /></dt>
				<dd>
					<ul>
					<c:forEach var="file" items="${boardFile}">
						<li>
							<a href="<c:out value="${file.fileUrl}" />"><c:out value="${file.fileNm}" /></a>
							<small>[size: <c:out value="${file.fileSizeStr}" default="0 bytes" />, Download: <c:out value="${file.dwldCnt}" />]</small>
							<c:if test="${boardMaster.prevewAt ne 'N' && file.filePreViewUrl ne ''}"> <a href="<c:out value="${file.filePreViewUrl}" />" class="filePreview siiru-btn siiru-btn-small" target="_blank"><spring:message code="info.file.preview" /></a> </c:if>
						</li>
					</c:forEach>
					</ul>
					<%-- 첨부파일 압축이 활성화 일경우 모든 첨부파일 압축 후 다운로드 --%>
					<c:if test="${zipFile ne ''}">
					<a href="<c:out value="${zipFile}" />" class="siiru-btn siiru-btn-small"><spring:message code="info.file.download" /></a>
					</c:if>
				</dd>
			</dl>
			</c:if>
		</div>
		<div class="siiruBoardBody">
		<%-- 문서미리보기가 있을경우 --%>
		<c:if test="${not empty previewList && fn:length(previewList) > 0 && boardMaster.prevewAt ne 'N'}">
			<c:forEach var="preview" items="${previewList}">
				<div class="insrtPreView">
					<div>
					<c:choose>
						<c:when test="${not empty preview.fileAlt && preview.fileAlt ne ''}">
							<c:out value="${preview.fileAlt}" escapeXml="false" />
						</c:when>
						<c:otherwise>
							<c:out value="${preview.fileNm}" escapeXml="false" />
						</c:otherwise>
					</c:choose>
					</div>
					<iframe src="<c:out value="${preview.fileSrc}" escapeXml="false" />"></iframe>
				</div>
			</c:forEach>
		</c:if>
		<%-- 첨부파일에 이미지가 있을경우 --%>
		<c:if test="${not empty imageList && fn:length(imageList) > 0}">
			<div class="imageView">
			<c:forEach var="image" items="${imageList}">
				<img src="<c:out value="${image.fileSrc}" />" alt="<c:out value="${image.fileImgAlt}" />">
				<c:if test="${not empty image.fileAlt && image.fileAlt ne ''}"><small><c:out value="${image.fileAlt}" escapeXml="false" /></small></c:if>
			</c:forEach>
			</div>
		</c:if>
		<%-- 첨부파일에 동영상 파일이 있을경우 --%>
		<c:if test="${not empty videoList && fn:length(videoList) > 0}">
			<div class="videoView">
			<c:forEach var="video" items="${videoList}">
				<video src="<c:out value="${video.fileSrc}" />" controls></video>
				<c:if test="${not empty video.fileAlt && video.fileAlt ne ''}"><small><c:out value="${video.fileAlt}" escapeXml="false" /></small></c:if>
			</c:forEach>
			</div>
		</c:if>
		<%-- 첨부파일에 오디오 파일이 있을경우 --%>
		<c:if test="${not empty audioList && fn:length(audioList) > 0}">
			<div class="audioView">
			<c:forEach var="audio" items="${audioList}">
				<audio src="<c:out value="${audio.fileSrc}" />" controls></audio>
				<c:if test="${not empty audio.fileAlt && audio.fileAlt ne ''}"><small><c:out value="${audio.fileAlt}" escapeXml="false" /></small></c:if>
			</c:forEach>
			</div>
		</c:if>
			<%-- 내용 표출 --%>
			<div class="boardContents siiru-clr">
				<c:out value="${boardData.boardCn}" escapeXml="false" />
			</div>
		<%-- 공공누리 활성화 일경우 --%>
		<c:if test="${boardMaster.koglAt eq 'Y' && boardData.koglSe ne '0'}">
			<div class="koglSeView siiru-clr">
				<img src="${path.context}home/siiru/images/img_opencode<c:out value="${boardData.koglSe}" />.png" alt="<c:out value="${boardData.koglSeNm}" />">
				<small>
				<c:choose>
					<c:when test="${boardData.koglSe eq '1'}">
						본 공공저작물은 공공누리 &quot;출처표시&quot; 조건에 따라 이용할 수 있습니다. <a href="https://www.kogl.or.kr/info/license.do" class="blue" target="_blank">공공누리 유형안내</a>
					</c:when>
					<c:when test="${boardData.koglSe eq '2'}">
						본 공공저작물은 공공누리 &quot;출처표시 + 상업적이용금지&quot; 조건에 따라 이용할 수 있습니다. <a href="https://www.kogl.or.kr/info/license.do" class="blue" target="_blank">공공누리 유형안내</a>
					</c:when>
					<c:when test="${boardData.koglSe eq '3'}">
						본 공공저작물은 공공누리 &quot;출처표시 + 변경금지&quot; 조건에 따라 이용할 수 있습니다. <a href="https://www.kogl.or.kr/info/license.do" class="blue" target="_blank">공공누리 유형안내</a>
					</c:when>
					<c:when test="${boardData.koglSe eq '4'}">
						본 공공저작물은 공공누리 &quot;출처표시 + 상업적이용금지 + 변경금지&quot; 조건에 따라 이용할 수 있습니다. <a href="https://www.kogl.or.kr/info/license.do" class="blue" target="_blank">공공누리 유형안내</a>
					</c:when>
					<c:when test="${boardData.koglSe eq '9'}">
						본 공공저작물은 공공누리 &quot;자유이용&quot; 조건에 따라 이용할 수 있습니다. <a href="https://www.kogl.or.kr/info/license.do" class="blue" target="_blank">공공누리 유형안내</a>
					</c:when>
					<c:when test="${boardData.koglSe eq '5'}">
						자유이용 불가 (저작권법 제24조의2 제1항 제1호~제4호 중 어느 하나에 해당됨). <a href="https://www.law.go.kr/법령/저작권법" class="blue" target="_blank">해당사항 확인 (국가법령정보센터)</a>
					</c:when>
				</c:choose>
				</small>
			</div>
		</c:if>
		<%-- 게시판 관리자일경우 수정/삭제/이동 정보 표출 --%>
		<c:if test="${boardAuth.manageAuth eq 'Y'}">
			<div class="manageInfo siiru-clr">
				<small>Write : <c:if test="${not empty boardData.regId && boardData.regId ne ''}"><c:out value="${boardData.regNm}" /> (<c:out value="${boardData.regId}" />) </c:if> <c:out value="${boardData.regDt}" /> [<c:out value="${boardData.regIp}" />]</small>
				<c:if test="${not empty boardData.updtDt && boardData.updtDt ne ''}">
					<small>Update : <c:if test="${not empty boardData.updtId && boardData.updtId ne ''}"><c:out value="${boardData.updtNm}" /> (<c:out value="${boardData.updtId}" />) </c:if> <c:out value="${boardData.updtDt}" /> [<c:out value="${boardData.updtIp}" />]</small>
				</c:if>
				<c:if test="${not empty boardData.delDt && boardData.delDt ne ''}">
					<small>Delete : <c:if test="${not empty boardData.delId && boardData.delId ne ''}"><c:out value="${boardData.delNm}" /> (<c:out value="${boardData.delId}" />) </c:if> <c:out value="${boardData.delDt}" /> [<c:out value="${boardData.delIp}" />]</small>
				</c:if>
				<c:if test="${boardData.moveAt eq 'O'}">
					<small><spring:message code="info.movedTo" arguments="${boardData.moveBoardNm}" /> <c:out value="${boardData.moveUserNm}" /> (<c:out value="${boardData.moveUserId}" />) <c:out value="${boardData.moveDt}" /></small>
				</c:if>
				<c:if test="${boardData.moveAt eq 'M'}">
					<small><spring:message code="info.movedFrom" arguments="${boardData.moveBoardNm}" /> <c:out value="${boardData.moveUserNm}" /> (<c:out value="${boardData.moveUserId}" />) <c:out value="${boardData.moveDt}" /></small>
				</c:if>
			</div>
		</c:if>
		</div>
		</form>
		<%-- 게시판 버튼 정보 --%>
		<div class="siiruBoardBtnInfo">
			<div class="siiru-fl">
			<%-- 이동버튼. 관리자 일경우 --%>
			<c:if test="${btn.moveBtn eq 'Y'}">
				<button class="moveBtn siiru-btn siiru-btn-warning" data-modal="#moveModal" type="button"><spring:message code="button.move" /></button>
			</c:if>
			<%-- 작성일수정버튼. 관리자 일경우 --%>
			<c:if test="${btn.regBtn eq 'Y'}">
				<button class="regBtn siiru-btn siiru-btn-warning siiru-ml5" data-modal="#regModal" type="button"><spring:message code="button.regDt" /></button>
			</c:if>
			<%-- 게시승인버튼. 관리자이고 게시승인사용이면 --%>
			<c:if test="${btn.confmBtn eq 'Y'}">
				<button class="confmBtn siiru-btn siiru-btn-success siiru-ml5" data-action="AU" type="button"><spring:message code="button.confm" /></button>
			</c:if>
			<%-- 게시승인취소버튼. 관리자이고 게시승인사용이면 --%>
			<c:if test="${btn.confmCancelBtn eq 'Y'}">
				<button class="confmCancelBtn siiru-btn siiru-btn-danger siiru-ml5" data-action="AC" type="button"><spring:message code="button.confmCancel" /> <small> [<c:out value="${boardData.confmDt}" />]</small></button>
			</c:if>
			</div>
			<div class="siiru-fr">
			<%-- 답글버튼 --%>
			<c:if test="${btn.replyBtn eq 'Y'}">
				<a href="<c:out value="${btn.replyLink}" />" class="siiru-btn siiru-btn-primary siiru-ml5"><spring:message code="button.reply" /></a>
			</c:if>
			<%-- 수정버튼 --%>
			<c:if test="${btn.updtBtn eq 'Y'}">
				<a href="<c:out value="${btn.updtLink}" />" class="siiru-btn siiru-btn-warning siiru-ml5"><spring:message code="button.modify" /></a>
			</c:if>
			<%-- 삭제버튼 --%>
			<c:if test="${btn.delBtn eq 'Y'}">
				<button class="delBtn siiru-btn siiru-btn-danger siiru-ml5" data-action="D" type="button"><spring:message code="button.delete" /></button>
			</c:if>
			<%-- 복원버튼. 관리자 일경우 --%>
			<c:if test="${btn.restrBtn eq 'Y'}">
				<button class="restrBtn siiru-btn siiru-btn-warning siiru-ml5" data-action="DR" type="button"><spring:message code="button.restore" /></button>
				<button class="realDelBtn siiru-btn siiru-btn-danger siiru-ml5" data-action="DD" type="button"><spring:message code="button.delete" /></button>
			</c:if>
				<%-- 목록버튼 --%>
				<a href="<c:out value="${btn.listLink}" />" class="siiru-btn siiru-ml5"><spring:message code="button.list" /></a>
			</div>
		</div>
		<div id="privacyModal" class="siiruModal modal" style="display:none;">
			<div class="siiruModalHeader"><p>개인정보 열람</p></div>
			<div class="siiruModalBody">
				<p class="privacy">
					민원인 정보 등 개인정보와 민원내용은 	민원처리 목적으로만<br>
					사용하여야 하며, <span class="text-info">정보주체의 동의</span> 없이 <span class="text-danger">무단으로 제3자에게</span><br>
					<span class="text-danger">제공</span> 한 경우에는 <span class="text-danger">5년 이하의 징역 또는 5천만원 이하의 벌금</span><br>
					에 처할 수 있습니다.
				</p>
			</div>
			<div class="siiruModalFooter siiru-tr">
				<input type="checkbox" id="privacyCookie" name="privacyCookie" value="<c:out value="${param.boardId}" />">
				<label for="privacyCookie"> 하루동안 이창을 다시 열지않음 </label>
				<a href="#close" class="siiru-btn siiru-btn-small siiru-btn-danger siiru-ml10" rel="modal:close"><spring:message code="button.close" /></a>
			</div>
		</div>
	<%-- 관리자이고 이동버튼이 활성화 이면 게시글 이동을 위한 모달 폼 --%>
	<c:if test="${btn.moveBtn eq 'Y'}">
		<div id="moveModal" class="siiruModal modal" style="display:none;">
			<div class="siiruModalHeader"><p><spring:message code="info.move" /></p></div>
			<div class="siiruModalBody">
				<div>
					<div style="display:inline-block;">
						<input type="checkbox" id="removeAt" name="removeAt" value="Y" checked>
						<label for="removeAt"><spring:message code="info.movedDelete" /></label>
					</div>
					<input type="text" id="boardTable-filter" name="boardTable-filter" placeholder="Search for table data..." value="" style="display:inline-block;width:78%">
				</div>
				<div id="board" class="boardFindView">
					<div class="scroll-container">
						<table id="boardTable">
						<caption><spring:message code="info.moveList" /></caption>
						<tbody>
							<tr><td class="nodata"><spring:message code="info.moveList.nodata" /></td></tr>
						</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="siiruModalFooter siiru-tr">
				<span id="moveBoardView" class="moveBoard"></span>
				<input type="hidden" id="moveBoardId" name="moveBoardId" value="">
				<button class="moveSBtn siiru-btn siiru-btn-small siiru-btn-primary" data-action="M" type="button"><spring:message code="info.move" /></button>
				<a href="#close" class="siiru-btn siiru-btn-small siiru-btn-danger siiru-ml5" rel="modal:close"><spring:message code="button.close" /></a>
			</div>
		</div>
	</c:if>
	<%-- 관리자이면 작성일 수정을 위한 모달 폼 --%>
	<c:if test="${btn.regBtn eq 'Y'}">
		<div id="regModal" class="siiruModal modal" style="display:none;">
			<div class="siiruModalHeader"><p><spring:message code="info.reg" /></p></div>
			<div class="siiruModalBody">
				<form id="regForm" name="regForm" method="post">
				<dl>
					<dt><span>*</span> <label for="regDate"><spring:message code="info.date" /></label></dt>
					<dd>
						<input type="text" id="regDate" name="regDate" class="maskDate small" maxlength="10" value="<c:out value="${boardData.regDate}" />">
						<small> <c:out value="${currentYYMM}" />-01</small>
					</dd>
				</dl>
				<dl class="noborder">
					<dt><span>*</span> <label for="regTime"><spring:message code="info.time" /></label></dt>
					<dd>
						<input type="text" id="regTime" name="regTime" class="maskFullTime small" maxlength="8" value="<c:out value="${boardData.regTime}" />">
						<small> 09:00:00</small>
					</dd>
				</dl>
				</form>
			</div>
			<div class="siiruModalFooter siiru-tr">
				<button class="regSBtn siiru-btn siiru-btn-small siiru-btn-primary" data-action="DU" type="button"><spring:message code="button.save" /></button>
				<a href="#close" class="siiru-btn siiru-btn-small siiru-btn-danger siiru-ml5" rel="modal:close"><spring:message code="button.close" /></a>
			</div>
		</div>
	</c:if>
	<%-- 댓글이 활성화 이면 --%>
	<c:if test="${boardMaster.comtAt eq 'Y'}">
		<div class="siiruBoardComt">
			<dl>
				<%-- 댓글 정보 및 버튼 --%>
				<dt>
					<span><spring:message code="info.comment" /> (<small id="comtMCount">0</small>)</span>
				<c:if test="${btn.comtBtn eq 'Y'}">
					<button class="comtBtn siiru-btn siiru-btn-small siiru-btn-primary" data-modal="#comtMModal" data-action="MI" type="button"><spring:message code="button.create" /></button>
				</c:if>
				</dt>
				<dd>
					<%-- 댓글 리스트 --%>
					<ul id="boardComtList" class="siiru-clr">
						<li><p class="nodata"><spring:message code="info.comment.nodata" /></p></li>
					</ul>
				</dd>
			</dl>
			<%-- 댓글 등록/수정/삭제를 위한 모달 폼 --%>
			<div id="comtMModal" class="siiruModal modal" style="display:none;">
				<div class="siiruModalHeader"><p id="comtMTitle"><spring:message code="info.comment.create" /></p></div>
				<div class="siiruModalBody">
					<form id="comtFormM" name="comtFormM" method="post" enctype="multipart/form-data">
					<input type="hidden" id="comtMAction" name="comtMAction" value="MI">
					<input type="hidden" id="comtSn_m" name="comtSn" value="">
					<input type="hidden" id="passwdView" name="passwdView" value="N">
					<dl>
						<dt><span>*</span> <label for="userNm_m"><spring:message code="info.writer" /></label></dt>
						<dd>
							<input type="text" id="userNm_m" name="userNm" class="small" maxlength="60" value="<c:out value="${form.userNm}" />"<c:if test="${form.userReadOnly eq 'Y'}"> readonly</c:if>>
							<%-- 게시판 설정이 비밀글 사용일 경우 로그인 상태일경우만 활성화 됨 --%>
							<div class="secretForm">
								<input type="checkbox" id="secretAt_m" name="secretAt" value="Y">
								<label for="secretAt_m"><spring:message code="info.secret" /></label>
							</div>
						</dd>
					</dl>
					<%-- 로그인 상태가 아니면 비밀번호 폼 활성화 --%>
					<dl class="passwdForm">
						<dt><span>*</span> <label for="passwd"><spring:message code="info.passwd" /></label></dt>
						<dd><input type="password" id="passwd" name="passwd" class="small" value="" autocomplete="off"></dd>
					</dl>
					<%-- 자동등록방지가 활성화 이면 --%>
					<c:if test="${form.captchaAt eq 'Y'}">
					<dl>
						<dt><span>*</span> <label for="captcha"><spring:message code="info.captcha" /></label></dt>
						<dd>
							<div id="captchaAudio" class="siiru-hidden"></div>
							<img src="<c:url value="${path.context}captcha.do" />" class="captchaImg" alt="<spring:message code="info.captcha.img" />">
							<div class="btnLayer">
								<button class="captchaBtn siiru-btn siiru-btn-small" type="button"><spring:message code="info.reload" /></button>
								<button class="captchaAudioBtn siiru-btn siiru-btn-small siiru-ml10" type="button"><spring:message code="info.audio" /></button>
							</div>
							<input type="text" id="captcha" name="captcha" class="small2" value="" autocomplete="off" placeholder="<spring:message code="info.captcha.msg" />">
						</dd>
					</dl>
					</c:if>
					<%-- 댓글 내용 --%>
					<dl class="fullCont">
						<dt class="siiru-hidden"><spring:message code="info.contents" /></dt>
						<dd>
							<textarea id="comtCn_m" name="comtCn" rows="7"></textarea>
						</dd>
					</dl>
					</form>
				</div>
				<%-- 댓글 버튼 --%>
				<div class="siiruModalFooter siiru-tr">
					<button class="comtMBtn siiru-btn siiru-btn-small siiru-btn-primary" type="button"><spring:message code="button.save" /></button>
					<a href="#close" class="siiru-btn siiru-btn-small siiru-btn-danger siiru-ml10" rel="modal:close"><spring:message code="button.close" /></a>
				</div>
			</div>
		</div>
	</c:if>
		<%-- 다음글/이전글 정보 --%>
		<div class="siiruBoardList">
			<ul>
				<%-- 다음글 --%>
				<li>
					<span><spring:message code="info.next" /></span>
					<c:choose>
						<c:when test="${empty nextViewData}"><spring:message code="info.next.msg" /></c:when>
						<c:otherwise>
							<c:if test="${nextViewData.levelSn > 0}"><img src="${path.context}home/siiru/images/icon-reply.png" alt="<spring:message code="info.reply" />" class="reply"> </c:if>
							<c:if test="${nextViewData.stateNm ne ''}">[<c:out value="${nextViewData.stateNm}" />] </c:if>
							<c:if test="${nextViewData.secretAt eq 'Y'}"><img src="${path.context}home/siiru/images/icon-secret.png" alt="<spring:message code="info.secret" />" class="secret"> </c:if>
							<a href="<c:out value="${nextViewData.href}" />"><c:out value="${nextViewData.boardSj}" /></a>
							<small><c:out value="${nextViewData.regDt}" default="" /></small>
						</c:otherwise>
					</c:choose>
				</li>
				<%-- 이전글 --%>
				<li>
					<span><spring:message code="info.prev" /></span>
					<c:choose>
						<c:when test="${empty prevViewData}"><spring:message code="info.prev.msg" /></c:when>
						<c:otherwise>
							<c:if test="${prevViewData.levelSn > 0}"><img src="${path.context}home/siiru/images/icon-reply.png" alt="<spring:message code="info.reply" />" class="reply"> </c:if>
							<c:if test="${prevViewData.stateNm ne ''}">[<c:out value="${prevViewData.stateNm}" />] </c:if>
							<c:if test="${prevViewData.secretAt eq 'Y'}"><img src="${path.context}home/siiru/images/icon-secret.png" alt="<spring:message code="info.secret" />" class="secret"> </c:if>
							<a href="<c:out value="${prevViewData.href}" />"><c:out value="${prevViewData.boardSj}" /></a>
							<small><c:out value="${prevViewData.regDt}" default="" /></small>
						</c:otherwise>
					</c:choose>
				</li>
			</ul>
		</div>
	<%-- 본문에 목록 출력일 경우 리스트 파일을 불러온다. --%>
	<c:if test="${boardMaster.listAt eq 'Y'}">
		<c:if test="${listPageUrl != null}"><div class="siiruBoardViewlist"><jsp:include page="${listPageUrl}" /></div></c:if>
	</c:if>
	</div>
<%-- 게시판 하단 출력 --%>
<c:if test="${not empty boardMaster.fterCn}">
	<div class="siiru-clr"><jsp:include page="${fterCn}" /></div>
</c:if>
</div>
<script>
// 페이지 로드가 완료되면
if (window.addEventListener) window.addEventListener("load", boardView, false);
else if (window.attachEvent) window.attachEvent("onload", boardView);
else window.onload = boardView;
// 뷰
function boardView() {
	// 추가된 항목 중 비디오가 있을경우
	if ($('[data-video]').length > 0) {
		$('[data-video]').each(function() {
			if ($.trim($(this).data('video')) != '') $(this).append(videoUrl($.trim($(this).data('video')), '', 560, 315));
		});
	}
	<%-- 전화번호, 이메일이 포함되면 개인정보 열람 경고 레이어 --%>
	<c:if test="${boardData.privacyAt eq 'Y'}">
	// 개인정보 경고
	if ($.trim(getCookie($('#boardId').val()+'_privacy_B')) == '') {
		setTimeout(function() {
			$('#privacyModal').modal({
				showClose: false,
				clickClose: false
			});
		}, 500);
	}
	$('#privacyCookie').click(function(e) {
		if ($('#privacyCookie').is(':checked')) {
			setTimeout(function() {
				setCookie($('#boardId').val()+'_privacy_B', 'close', 1);
				$.modal.close();
			}, 500);
		}
	});
	privacyPrint();
	</c:if>
	<%-- 본문에 목록 출력일 경우 --%>
	<c:if test="${boardMaster.listAt eq 'Y'}">
		// 본문에 목록 출력시 선택된 행 하이라이트
		$('.siiruBoard-list a[data-view="L"], .siiruBoard-gallery a[data-view="G"]').each(function() {
			if ($(this).data('seq') == $('#seq').val()) {
				if ($(this).data('view') == 'L') {
					$(this).closest('.listBody-row').addClass('highlight');
				} else if ($(this).data('view') == 'G') {
					$(this).closest('dl').addClass('highlight');
				}
			}
		});
		// 페이징 표출 [페이징표출 레이어ID, 페이지 번호, 전체 페이지수, 전체 개수]
		pagination('boardPage', ${page}, ${pageCnt}, ${totalCnt});
		// 페이징 버튼 클릭시 페이지 이동 및 검색어 유지
		$('.pagination').on('click', 'li a', function(e) {
			e.preventDefault();
			$('#boardSearchForm').find('input[name="movePage"]').val($(this).data('move'));
			$('#boardSearchForm').submit();
		});
	</c:if>
	<%-- 삭제 버튼 활성화 --%>
	<c:if test="${btn.delBtn eq 'Y'}">
		// 삭제
		$('.delBtn').click(function(e) {
			var formData = $('#boardSearchForm').serializeArray();
				formData.push({name:'action', value:$(this).data('action')});
				formData.push({name:'seq', value:$('#seq').val()});
			if (confirm('<spring:message code="info.delete" />')) {
			<c:choose>
				<%-- 비밀번호 체크일 경우 인증페이지로 이동 --%>
				<c:when test="${btn.crtfcSe eq 'P'}">
				document.location.href = '${btn.delLink}';
				</c:when>
				<%-- 삭제 서비스 호출 --%>
				<c:otherwise>
				$.post('${path.context}setBoardDelete.do', formData).done(function(data) {
					if (data.error == 'N') {
						document.location.href = data.redirect;
					} else {
						alert('['+$.trim(data.errorTitle)+'] '+$.trim(data.errorMsg));
					}
				});
				</c:otherwise>
			</c:choose>
			} else {
				return false;
			}
		});
	</c:if>
	<%-- 복원 버튼 활성화. 관리자 일경우 --%>
	<c:if test="${btn.restrBtn eq 'Y'}">
		// 복원
		$('.restrBtn').click(function(e) {
			var formData = $('#boardSearchForm').serializeArray();
				formData.push({name:'action', value:$(this).data('action')});
				formData.push({name:'seq', value:$('#seq').val()});
			if (confirm('<spring:message code="info.restore" />')) {
				$.post('${path.context}setBoardRestore.do', formData).done(function(data) {
					if (data.error == 'N') {
						document.location.href = data.redirect;
					} else {
						alert('['+$.trim(data.errorTitle)+'] '+$.trim(data.errorMsg));
					}
				});
			} else {
				return false;
			}
		});
		// 실제삭제
		$('.realDelBtn').click(function(e) {
			var formData = $('#boardSearchForm').serializeArray();
				formData.push({name:'action', value:$(this).data('action')});
				formData.push({name:'seq', value:$('#seq').val()});
			if (confirm('<spring:message code="info.delete" />')) {
				$.post('${path.context}setBoardDelete.do', formData).done(function(data) {
					if (data.error == 'N') {
						document.location.href = data.redirect;
					} else {
						alert('['+$.trim(data.errorTitle)+'] '+$.trim(data.errorMsg));
					}
				});
			} else {
				return false;
			}
		});
	</c:if>
	<%-- 게시승인 버튼 활성화. 관리자이고 게시승인사용이면 --%>
	<c:if test="${btn.confmBtn eq 'Y'}">
		// 게시승인
		$('.confmBtn').click(function(e) {
			var formData = $('#boardSearchForm').serializeArray();
				formData.push({name:'action', value:$(this).data('action')});
				formData.push({name:'seq', value:$('#seq').val()});
			if (confirm('<spring:message code="info.confm.save" />')) {
				$.post('${path.context}setBoardConfm.do', formData).done(function(data) {
					if (data.error == 'N') {
						document.location.href = data.redirect;
					} else {
						alert('['+$.trim(data.errorTitle)+'] '+$.trim(data.errorMsg));
					}
				});
			} else {
				return false;
			}
		});
	</c:if>
	<%-- 게시승인취소 버튼 활성화. 관리자이고 게시승인사용이면 --%>
	<c:if test="${btn.confmCancelBtn eq 'Y'}">
		// 게시승인
		$('.confmCancelBtn').click(function(e) {
			var formData = $('#boardSearchForm').serializeArray();
				formData.push({name:'action', value:$(this).data('action')});
				formData.push({name:'seq', value:$('#seq').val()});
			if (confirm('<spring:message code="info.confmCancel.save" />')) {
				$.post('${path.context}setBoardConfm.do', formData).done(function(data) {
					if (data.error == 'N') {
						document.location.href = data.redirect;
					} else {
						alert('['+$.trim(data.errorTitle)+'] '+$.trim(data.errorMsg));
					}
				});
			} else {
				return false;
			}
		});
	</c:if>
	<%-- 이동 버튼 활성화. 관리자 일경우 --%>
	<c:if test="${btn.moveBtn eq 'Y'}">
		// 이동
		$('.moveBtn').click(function(e) {
			// 유형이 같은 게시판 데이터를 가져온다.
			boardData();
			$($(this).data('modal')).modal({
				showClose: false,
				clickClose: false
			});
		});
		// 게시판 선택
		$('#moveModal').on('click', 'td .siiru-btn', function() {
			$('#moveBoardId').val($(this).data('id'));
			$('#moveBoardView').html($(this).data('nm')+' ['+$(this).data('id')+'] ');
		});
		// 이동처리
		$('.moveSBtn').click(function(e) {
			if ($('#moveBoardId').val() == '') {
				alert('[<spring:message code="info.moveSelect" />] <spring:message code="info.moveSelect.msg" />');
			} else {
				var confirmText = '<spring:message code="info.moved" />';
				var removeAt = 'Y';
				if (!$('#removeAt').is(':checked')) {
					removeAt = 'N';
					confirmText = '<spring:message code="info.copy" />';
				}
				var formData = $('#boardSearchForm').serializeArray();
					formData.push({name:'action', value:$(this).data('action')});
					formData.push({name:'seq', value:$('#seq').val()});
					formData.push({name:'moveBoardId', value:$('#moveBoardId').val()});
					formData.push({name:'removeAt', value:removeAt});
				if (confirm(confirmText)) {
					$.post('${path.context}setBoardMove.do', formData).done(function(data) {
						if (data.error == 'N') {
							// 모달폼 닫기
							$.modal.close();
							// 리스트 페이지로 이동
							document.location.href = data.redirect;
						} else {
							alert('['+$.trim(data.errorTitle)+'] '+$.trim(data.errorMsg));
						}
					});
				} else {
					return false;
				}
			}
		});
	</c:if>
	<%-- 작성일 버튼 활성화. 관리자 일경우 --%>
	<c:if test="${btn.regBtn eq 'Y'}">
		// 작성일
		$('.regBtn').click(function(e) {
			$($(this).data('modal')).modal({
				showClose: false,
				clickClose: false
			});
		});
		// 작성일 수정 처리
		$('.regSBtn').click(function(e) {
			// 날짜
			if ($.trim($('#regDate').val()) == '') {
				alert('<spring:message code="errors.required" arguments="${alertMsg.date}" />');
				$('#regDate').focus();
				return false;
			}
			if ($.trim($('#regDate').val()) != '') {
				if (!ValidDate($('#regDate').val())) {
					alert('<spring:message code="errors.date" arguments="${alertMsg.date}" />');
					$('#regDate').focus();
					return false;
				}
			}
			// 시간
			if ($.trim($('#regTime').val()) == '') {
				alert('<spring:message code="errors.required" arguments="${alertMsg.time}" />');
				$('#regTime').focus();
				return false;
			}
			if ($.trim($('#regTime').val()) != '') {
				if (!ValidFullTime($('#regTime').val())) {
					alert('<spring:message code="errors.time" arguments="${alertMsg.time}" />');
					$('#regTime').focus();
					return false;
				}
			}
			// 폼 정리
			var formData = $('#regForm').serializeArray();
				formData.push({name:'action', value:$(this).data('action')});
				formData.push({name:'boardId', value:$('#boardId').val()});
				formData.push({name:'seq', value:$('#seq').val()});
			if (confirm('<spring:message code="info.reg.save" />')) {
				$.post('${path.context}setBoardReg.do', formData).done(function(data) {
					if (data.error == 'N') {
						// 모달폼 닫기
						$.modal.close();
						// 페이지 새로고침
						window.location.reload(true);
					} else {
						alert('['+$.trim(data.errorTitle)+'] '+$.trim(data.errorMsg));
					}
				});
			} else {
				return false;
			}
		});
	</c:if>
	<%-- 댓글 활성화 일경우 --%>
	<c:if test="${boardMaster.comtAt eq 'Y'}">
		// 댓글 리스트 불러오기
		comtDataM();
		// 댓글 팝업 호출
		$('.comtBtn').click(function() {
			// 댓글 초기화
			comtMInit();
			// 댓글 등록 셋팅
			$('#comtMTitle').html('<spring:message code="info.comment.create" />');
			$('#comtMAction').val('MI');
			$('.comtMBtn').removeClass('siiru-btn-danger');
			$('.comtMBtn').addClass('siiru-btn-primary');
			$('.comtMBtn').html('<spring:message code="button.save" />');
			// 모달 폼
			$($(this).data('modal')).modal({
				showClose: false,
				clickClose: false
			});
		});
		// 댓글 등록/수정/삭제
		$('.comtMBtn').click(function(e) {
			// 작성자
			if ($.trim($('#userNm_m').val()) == '') {
				alert('<spring:message code="errors.required" arguments="${alertMsg.writer}" />');
				$('#userNm_m').focus();
				return false;
			}
			if ($.trim($('#passwdView').val()) == 'Y') {
				// 비밀번호
				if ($.trim($('#passwd').val()) == '') {
					alert('<spring:message code="errors.required" arguments="${alertMsg.passwd}" />');
					$('#passwd').focus();
					return false;
				}
			}
			<c:if test="${form.captchaAt eq 'Y'}">
			// 자동등록방지
			if ($.trim($('#captcha').val()) == '') {
				alert('<spring:message code="errors.required" arguments="${alertMsg.captcha}" />');
				$('#captcha').focus();
				return false;
			}
			</c:if>
			// 내용
			if ($.trim($('#comtCn_m').val()) == '') {
				alert('<spring:message code="errors.required" arguments="${alertMsg.contents}" />');
				$('#comtCn_m').focus();
				return false;
			}
			// 폼 정리
			var formData = new FormData($('#comtFormM')[0]);
				formData.append('action', $('#comtMAction').val());
				formData.append('pageId', $('input[name="pageId"]').val());
				formData.append('boardId', $('#boardId').val());
				formData.append('seq', $('#seq').val());
				formData.append('comtSe', 'M');
			// 댓글 삭제 일경우
			if ($.trim($('#comtMAction').val()) == 'MD') {
				if (confirm('<spring:message code="info.comment.deleted" />')) {
					$.post('${path.context}setComtDelete.do', formData).done(function(data) {
						if (data.error == 'N') {
							// 모달폼 닫기
							$.modal.close();
							// 댓글 초기화
							comtMInit();
							// 댓글 리스트 불러오기
							comtDataM();
						} else {
							// 에러 일경우
							var form_err = '';
							if ($.type(data.inputArr) != 'undefined') {
								$.each(data.inputArr, function(input_name, input_msg) {
									form_err+= '\n'+input_msg;
								});
							}
							if (($.type(data.errorTitle) != 'undefined') && (data.errorTitle != '')) {
								alert(data.errorMsg+'\n'+form_err);
							}
						}
					});
				} else {
					return false;
				}
			} else {
				// 댓글 등록/수정
				if (confirm('<spring:message code="info.comment.save" />')) {
					$.ajax({
						type : 'post',
						url : '${path.context}setComtMerge.do',
						cache : false,
						data : formData,
						processData : false,
						contentType: false,
						dataType : 'json',
						success : function(data) {
							if (data.error == 'N') {
								// 모달폼 닫기
								$.modal.close();
								// 댓글 초기화
								comtMInit();
								// 댓글 리스트 불러오기
								comtDataM();
							} else {
								// 에러 일경우
								var form_err = '';
								if ($.type(data.inputArr) != 'undefined') {
									$.each(data.inputArr, function(input_name, input_msg) {
										form_err+= '\n'+input_msg;
									});
								}
								if (($.type(data.errorTitle) != 'undefined') && (data.errorTitle != '')) {
									alert(data.errorMsg+'\n'+form_err);
								}
							}
						},
						error : function(xhr,status,error) {
							alert('['+xhr.status+'] ' + error);
						}
					});
					return false;
				} else {
					return false;
				}
			}
		});
		// 댓글 리스트 버튼
		$('#boardComtList').on('click', '.siiru-btn', function() {
			var btnData = $(this).data();
			// 수정 / 삭제(비밀번호 인증 일경우)
			if (btnData.action == 'MU' || btnData.action == 'MMD') {
				// 댓글 초기화
				comtMInit();
				$.post('${path.context}getComtData.do', {'pageId':$('input[name="pageId"]').val(),'boardId':$('#boardId').val(),'seq':$('#seq').val(),'comtSn':btnData.comtsn,'comtSe':'M'}).done(function(data) {
					if (data.error == 'N') {
						// 권한이 없을 경우
						if ($.trim(data.dataMap.view) == 'N') {
							alert('[<spring:message code="info.comment" />] <spring:message code="fail.param.msg" />');
						} else {
							// 댓글 값 셋팅
							$('#comtSn_m').val($.trim(data.dataMap.comtSn));
							$('#userNm_m').val($.trim(data.dataMap.userNm));
							$('#secretAt_m').prop('checked', false).trigger('change');
							// 비밀글 활성화
							if (btnData.secretform == 'Y') {
								if ($.trim(data.dataMap.secretAt) == 'Y') {
									$('#secretAt_m').prop('checked', true).trigger('change');
								}
								$('.secretForm').show();
							} else {
								$('.secretForm').hide();
							}
							$('#passwd').val('');
							// 비밀번호 활성화
							if (btnData.passwdform == 'Y') {
								$('.passwdForm').show();
							} else {
								$('.passwdForm').hide();
							}
							$('#passwdView').val(btnData.passwdform);
							$('#comtCn_m').val($.trim(data.dataMap.comtCn));
							// 수정 셋팅
							if (btnData.action == 'MU') {
								$('#comtMTitle').html('<spring:message code="info.comment.modify" />');
								$('#comtMAction').val('MU');
								$('.comtMBtn').removeClass('siiru-btn-danger');
								$('.comtMBtn').addClass('siiru-btn-primary');
								$('.comtMBtn').html('<spring:message code="button.save" />');
							// 삭제 셋팅
							} else if (btnData.action == 'MMD') {
								$('#comtMTitle').html('<spring:message code="info.comment.delete" />');
								$('#comtMAction').val('MD');
								$('.comtMBtn').removeClass('siiru-btn-primary');
								$('.comtMBtn').addClass('siiru-btn-danger');
								$('.comtMBtn').html('<spring:message code="button.delete" />');
							}
							// 모달 폼
							$(btnData.modal).modal({
								showClose: false,
								clickClose: false
							});
						}
					} else {
						alert('['+$.trim(data.errorTitle)+'] '+$.trim(data.errorMsg));
					}
				});
			// 댓글 삭제
			} else if (btnData.action == 'MD') {
				if (confirm('<spring:message code="info.comment.deleted" />')) {
					$.post('${path.context}setComtDelete.do', {'action':btnData.action,'pageId':$('input[name="pageId"]').val(),'boardId':$('#boardId').val(),'seq':$('#seq').val(),'comtSn':btnData.comtsn,'comtSe':'M'}).done(function(data) {
						if (data.error == 'N') {
							// 댓글 리스트 불러오기
							comtDataM();
						} else {
							alert('['+$.trim(data.errorTitle)+'] '+$.trim(data.errorMsg));
						}
					});
				} else {
					return false;
				}
			// 댓글 복원
			} else if (btnData.action == 'MR') {
				if (confirm('<spring:message code="info.comment.restore" />')) {
					$.post('${path.context}setComtRestore.do', {'action':btnData.action,'pageId':$('input[name="pageId"]').val(),'boardId':$('#boardId').val(),'seq':$('#seq').val(),'comtSn':btnData.comtsn,'comtSe':'M'}).done(function(data) {
						if (data.error == 'N') {
							// 댓글 리스트 불러오기
							comtDataM();
						} else {
							alert('['+$.trim(data.errorTitle)+'] '+$.trim(data.errorMsg));
						}
					});
				} else {
					return false;
				}
			}
		});
	</c:if>
}
<%-- 이동 버튼 활성화. 관리자 일경우 --%>
<c:if test="${btn.moveBtn eq 'Y'}">
// 유형이 같은 게시판 데이터를 불러온다.
function boardData() {
	// 데이터 초기화
	$('#boardTable tbody').children('tr').remove('');
	$.post('${path.context}getMasterList.do', {'pageId':$('input[name="pageId"]').val(),'boardTy':'<c:out value="${boardMaster.boardTy}" />'}).done(function(data) {
		if (data.error == 'N') {
			var tableData = '';
			var tableCnt = 0;
			$.each(data.dataList, function(key, values) {
				if ($.trim(values.boardId) != $('#boardId').val()) {
					tableData+= '<tr>';
					tableData+= '<td scope="row">'+$.trim(values.boardId)+'</td>';
					tableData+= '<td>'+convertHtml($.trim(values.boardNm))+'</td>';
					tableData+= '<td class="siiru-tr"><button type="button" class="siiru-btn siiru-btn-small" data-id="'+$.trim(values.boardId)+'" data-nm="'+escapeHtml($.trim(values.boardNm))+'"><spring:message code="info.choose" /></button></td>';
					tableData+= '</tr>';
					tableCnt++;
				}
			});
			if (tableCnt == 0) {
				tableData+= '<tr><td class="nodata"><spring:message code="info.moveList.nodata" /></td></tr>';
			}
			$('#boardTable tbody').append(tableData);
			// 테이블 필터
			setTimeout(function () {
				$('#boardTable').filterTable({
					inputSelector: '#boardTable-filter',
					minRows: 1
				})
			}, 50);
		} else {
			alert('['+$.trim(data.errorTitle)+'] '+$.trim(data.errorMsg));
		}
	});
}
</c:if>
<%-- 댓글 활성화 일경우 --%>
<c:if test="${boardMaster.comtAt eq 'Y'}">
// 댓글 폼 초기화
function comtMInit() {
	$('#comtMAction').val('MI');
	$('#comtSn_m').val('');
	$('#userNm_m').val('<c:out value="${form.userNm}" />');
	$('#secretAt_m').prop('checked', false).trigger('change');
	$('#passwd').val('');
	$('.secretForm').hide();
	$('.passwdForm').hide();
	$('#passwdView').val('N');
<%-- 비밀글 활성 --%>
<c:if test="${form.secretAt eq 'Y'}">
	$('.secretForm').show();
</c:if>
<%-- 비밀번호 활성 --%>
<c:if test="${form.passwdAt eq 'Y'}">
	$('.passwdForm').show();
	$('#passwdView').val('Y');
</c:if>
<%-- 자동등록 방지 활성 --%>
<c:if test="${form.captchaAt eq 'Y'}">
	var timeData = new Date();
	var reloadNum = timeData.getTime();
	$('.captchaImg').attr('src', '${path.context}captcha.do?'+reloadNum);
	$('#captcha').val('');
</c:if>
	$('#comtCn_m').val('');
	$('.comtMBtn').removeClass('siiru-btn-danger');
	$('.comtMBtn').addClass('siiru-btn-primary');
	$('.comtMBtn').html('<spring:message code="button.save" />');
}
// 댓글 리스트를 불러온다.
function comtDataM() {
	// 댓글 불러오기
	$('#boardComtList').children('li').remove('');
	$.post('${path.context}getComtList.do', {'pageId':$('input[name="pageId"]').val(),'boardId':$('#boardId').val(),'seq':$('#seq').val(),'comtSe':'M'}).done(function(data) {
		if (data.error == 'N') {
			var comtMListData = '';
			var userNm = '';
			var liClass = '';
			var textClass = '';
			$.each(data.dataList, function(key, values) {
				userNm = '';
				// 삭제된 데이터
				if ($.trim(values.delDt) != '') userNm+= ' [<spring:message code="info.state.delete" />] ';
				// 비밀글일때
				if ($.trim(values.secretAt) == 'Y') userNm+= ' <img src="${path.context}home/siiru/images/icon-secret.png" alt="<spring:message code="info.secret" />" class="secret"> ';
				// 작성자명
				userNm+= convertHtml($.trim(values.userNm));
				// 아이디가 있을때
				if ($.trim(values.userId) != '') userNm+= ' ('+$.trim(values.userId)+')';
				liClass = '';
				if ($.trim(values.delDt) != '') liClass = ' class="comtDanger"';
				// class 정리
				comtMListData+= '<li'+liClass+'>';
				// 작성일
				comtMListData+= '<small class="siiru-fr">'+$.trim(values.regDt);
				// 관리자 일경우 IP
				if ($.trim(values.regIp) != '') comtMListData+= ' &nbsp;&nbsp; '+$.trim(values.regIp);
				comtMListData+= '&nbsp;&nbsp;</small>';
				// 작성자
				comtMListData+= '<span>&nbsp;'+userNm+'</span>';
				// 비밀 댓글 일경우
				textClass = '';
				if ($.trim(values.secretText) == 'Y') textClass = ' class="text-danger"';
				// 내용
				comtMListData+= '<div class="well">';
				comtMListData+= '<div'+textClass+'>'+$.trim(values.comtCn)+'</div>';
				// 관리자 일경우 정보
				if ($.trim(values.updtDt) != '') comtMListData+= '<small class="comtManage">Update : '+$.trim(values.updtDt)+' '+$.trim(values.updtIp)+'</small>';
				if ($.trim(values.delDt) != '') comtMListData+= '<small class="comtManage">Delete : '+$.trim(values.delDt)+' '+$.trim(values.delIp)+'</small>';
				comtMListData+= '</div>';
				comtMListData+= '<div class="siiru-tr siiru-clr">';
				// 수정 버튼. 자신이 작성한 글 혹은 비밀번호 인증일 경우 표출
				if ($.trim(values.updtBtn) == 'Y') {
					comtMListData+= ' <button class="siiru-btn siiru-btn-small siiru-btn-warning" data-modal="#comtMModal" data-action="MU" data-passwdform="'+$.trim(values.passwdForm)+'" data-secretform="'+$.trim(values.secretForm)+'" data-comtsn="'+$.trim(values.comtSn)+'" type="button"><spring:message code="button.modify" /></button> ';
				}
				// 삭제 버튼. 자신이 작성한 글 혹은 비밀번호 인증일 경우 표출
				if ($.trim(values.delBtn) == 'Y') {
					// 비밀번호 인증 일경우
					if ($.trim(values.passwdForm) == 'Y') {
						comtMListData+= ' <button class="siiru-btn siiru-btn-small siiru-btn-danger" data-modal="#comtMModal" data-action="MMD" data-passwdform="'+$.trim(values.passwdForm)+'" data-secretform="'+$.trim(values.secretForm)+'" data-comtsn="'+$.trim(values.comtSn)+'" type="button"><spring:message code="button.delete" /></button> ';
					// 자신이 작성한 글이면
					} else {
						comtMListData+= ' <button class="siiru-btn siiru-btn-small siiru-btn-danger" data-action="MD" data-passwdform="'+$.trim(values.passwdForm)+'" data-secretform="'+$.trim(values.secretForm)+'" data-comtsn="'+$.trim(values.comtSn)+'" type="button"><spring:message code="button.delete" /></button> ';
					}
				}
				// 복원 버튼. 관리자 일경우
				if ($.trim(values.restrBtn) == 'Y') {
					comtMListData+= ' <button class="siiru-btn siiru-btn-small siiru-btn-danger" data-action="MR" data-comtsn="'+$.trim(values.comtSn)+'" type="button"><spring:message code="button.restore" /></button> ';
				}
				comtMListData+= '</div>';
				comtMListData+= '</li>';
			});
			$('#comtMCount').html(numberWithCommas(data.dataList.length));
			if (data.dataList.length == 0) {
				comtMListData+= '<li><p class="nodata"><spring:message code="info.comment.nodata" /></p></li>';
			}
			$('#boardComtList').append(comtMListData);
		} else {
			alert('['+$.trim(data.errorTitle)+'] '+$.trim(data.errorMsg));
		}
	});
}
</c:if>
</script>
<%-- 레이아웃 하단 출력 --%>
<c:if test="${footerUrl != null}"><jsp:include page="${footerUrl}" /></c:if>
<%@ include file="/WEB-INF/jsp/home/siiru/include/footer.jsp" %>