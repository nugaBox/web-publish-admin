<%-- 뷰페이지에서 목록 출력일 경우. 상단부분을 제거하기 위한 조건. 시작 --%>
<c:if test="${listView eq 'N'}">
<%@ include file="/WEB-INF/jsp/home/siiru/include/header.jsp" %>
<%-- 레이아웃 상단 출력 --%>
<c:if test="${headerUrl != null}"><jsp:include page="${headerUrl}" /></c:if>
<div class="siiru-boardWrap">
	<%-- 게시판 상단 출력 --%>
	<c:if test="${not empty boardMaster.hderCn}">
		<div class="siiru-clr"><jsp:include page="${hderCn}" /></div>
	</c:if>
	<%-- 게시판 검색 폼 --%>
	<div class="siiruBoard-search">
		<form id="boardSearchForm" name="boardSearchForm" method="post" action="<c:out value="${path.sContext}" />boardList.do">
		<input type="hidden" name="pageId" value="<c:out value="${param.pageId}" />">
		<input type="hidden" id="movePage" name="movePage" value="<c:out value="${page}" default="1" />">
		<input type="hidden" id="searchCtgryNm" name="searchCtgryNm" value="<c:out value="${param.searchCtgryNm}" />">
		<c:if test="${not empty boardMaster.listDe}"><input type="hidden" id="searchBase" name="searchBase" value="<c:out value="${param.searchBase}" />"></c:if>
		<input type="hidden" id="boardId" name="boardId" value="<c:out value="${param.boardId}" />">
		<div class="dateSearch">
			<input type="radio" id="dateSet0" name="searchDateSet" value="0"<c:if test="${param.searchDateSet eq '0'}"> checked</c:if>>
			<label for="dateSet0"> 오늘 </label>
			<input type="radio" id="dateSet1" name="searchDateSet" value="6"<c:if test="${param.searchDateSet eq '6'}"> checked</c:if>>
			<label for="dateSet1"> 일주일 </label>
			<input type="radio" id="dateSet2" name="searchDateSet" value="30"<c:if test="${param.searchDateSet eq '30'}"> checked</c:if>>
			<label for="dateSet2"> 1개월 </label>
			<input type="radio" id="dateSet3" name="searchDateSet" value="90"<c:if test="${param.searchDateSet eq '90'}"> checked</c:if>>
			<label for="dateSet3"> 3개월 </label>
			<input type="radio" id="dateSet4" name="searchDateSet" value="180"<c:if test="${param.searchDateSet eq '180'}"> checked</c:if>>
			<label for="dateSet4"> 6개월 </label>
			<input type="radio" id="dateSet5" name="searchDateSet" value="365"<c:if test="${param.searchDateSet eq '365'}"> checked</c:if>>
			<label for="dateSet5"> 1년 </label>
			<input type="text" class="maskDate" id="searchSDe" name="searchSDe" maxlength="10" autocomplete="off" placeholder="검색 시작일" value="<c:out value="${param.searchSDe}" />">
			~
			<input type="text" class="maskDate" id="searchEDe" name="searchEDe" maxlength="10" autocomplete="off" placeholder="검색 종료일" value="<c:out value="${param.searchEDe}" />">
		</div>
		<%-- 분류 검색 --%>
		<c:if test="${boardMaster.ctgryAt eq 'Y'}">
		<select id="searchCtgry" name="searchCtgry" title="<c:out value="${searchCtgryTitle}" />">
			<option value=""><spring:message code="search.all" /> <c:out value="${ctgryNm}" /></option>
		<c:if test="${not empty searchCtgryList and fn:length(searchCtgryList) > 0}">
			<c:forEach var="code" items="${searchCtgryList}">
			<option value="<c:out value="${code.value}" />"<c:out value="${code.selected}" />><c:out value="${code.name}" /></option>
			</c:forEach>
		</c:if>
		</select>
		</c:if>
		<%-- 검색어 구분 검색 --%>
		<select id="searchTy" name="searchTy" title="<c:out value="${searchTyTitle}" />">
		<c:if test="${not empty searchTyList and fn:length(searchTyList) > 0}">
			<c:forEach var="code" items="${searchTyList}">
			<option value="<c:out value="${code.codeId}" />"<c:out value="${code.selected}" />><c:out value="${code.codeNm}" /></option>
			</c:forEach>
		</c:if>
		</select>
		<%-- 검색어 검색 --%>
		<input type="text" id="searchQuery" name="searchQuery" placeholder="<spring:message code="search.keyword" />" value="<c:out value="${param.searchQuery}" default="" />" title="<spring:message code="search.keyword" />">
		<button type="submit"><spring:message code="button.search" /></button>
		</form>
	</div>
</c:if>
<%-- 뷰페이지에서 목록 출력일 경우. 상단부분을 제거하기 위한 조건. 끝 --%>
	<%-- 게시글 정보. 게시글 개수, 페이지 개수 --%>
	<div class="siiruBoard-listInfo">
		<p><spring:message code="info.all.total" /> : <fmt:formatNumber value="${totalCnt}" pattern="#,###" /> / <spring:message code="info.all.page" /> : <fmt:formatNumber value="${pageCnt}" pattern="#,###" /> [
today : <fmt:formatNumber value="${todayCnt}" pattern="#,###" />]</p>
		<%-- RSS 활성화 일때 버튼 표시 --%>
		<c:if test="${boardMaster.rssAt eq 'Y'}"><p class="siiruRss"><a href="<c:out value="${rssLink}" />" target="_blank">RSS</a></p></c:if>
	</div>
	<div class="siiruBoard-list">
		<table>
		<thead>
			<tr>
			<c:forEach var="boardListItem" items="${boardListItem}">
				<th scope="col"<c:if test="${not empty boardListItem.iemClass && boardListItem.iemClass ne ''}"> class="<c:out value="${boardListItem.iemClass}" />"</c:if>><c:out value="${boardListItem.iemNm}" /></th>
			</c:forEach>
			</tr>
		</thead>
		<tbody>
	<c:choose>
		<%-- 게시글이 없을경우 --%>
		<c:when test="${empty boardList || fn:length(boardList) == 0}">
			<tr><td colspan="${fn:length(boardListItem)}" class="nodata"><spring:message code="info.nodata" /></td></tr>
		</c:when>
		<%-- 게시글이 있을경우 --%>
		<c:otherwise>
			<c:forEach var="listData" items="${boardList}" varStatus="status">
				<tr<c:if test="${listData.delDt eq 'Y'}"> class="throughline"</c:if>>
				<c:forEach var="boardListItem" items="${boardListItem}">
				<c:choose>
					<%-- 번호일경우. 공지사항 아이콘을 보여주기 위해 --%>
					<c:when test="${boardListItem.iemId eq 'sn'}">
						<td<c:if test="${not empty boardListItem.iemClass && boardListItem.iemClass ne ''}"> class="<c:out value="${boardListItem.iemClass}" />"</c:if>>
						<c:choose>
							<c:when test="${listData.noticeAt eq 'Y'}"><span class="notice">Notice</span></c:when>
							<c:otherwise><c:out value="${listData[boardListItem.iemId]}" /></c:otherwise>
						</c:choose>
						</td>
					</c:when>
					<%-- 제목일경우. 게시글 상태 및 답글. 링크 정보 표출 --%>
					<c:when test="${boardListItem.iemId eq 'boardSj'}">
						<th scope="row"<c:if test="${not empty boardListItem.iemClass && boardListItem.iemClass ne ''}"> class="<c:out value="${boardListItem.iemClass}" />"</c:if>>
							<c:if test="${listData.levelSn > 1}"><c:forEach var="reply" begin="2" end="${listData.levelSn}" step="1"><span class="reBlcok"></span></c:forEach></c:if>
							<c:if test="${listData.levelSn > 0}"><img src="${path.context}home/siiru/images/icon-reply.png" alt="<spring:message code="info.reply" />" class="reply"></c:if>
							<c:if test="${listData.stateNm ne ''}"><span<c:if test="${listData.state eq 'D' || listData.state eq 'A'}"> class="text-danger"</c:if>>[<c:out value="${listData.stateNm}" />] </span></c:if>
							<c:if test="${listData.mainExpsrNm ne ''}">[<c:out value="${listData.mainExpsrNm}" />] </c:if>
							<c:if test="${listData.secretAt eq 'Y'}"><img src="${path.context}home/siiru/images/icon-secret.png" alt="<spring:message code="info.secret" />" class="secret"></c:if>
							<c:choose>
								<%-- 뷰 권한이 있으면 --%>
								<c:when test="${boardAuth.viewAuth eq 'Y'}">
								<a href="<c:out value="${listData.href}" />" data-view="L" data-seq="<c:out value="${listData.seq}" />"<c:if test="${listData.newAt eq 'Y'}"> class="new"</c:if>>
								<c:choose>
									<c:when test="${not empty listData[boardListItem.iemId] or listData[boardListItem.iemId] ne ''}"><c:out value="${listData[boardListItem.iemId]}" /></c:when>
									<c:otherwise>&nbsp;</c:otherwise>
								</c:choose>
								</a>
								</c:when>
								<%-- 뷰 권한이 없으면 --%>
								<c:otherwise>
								<span<c:if test="${listData.newAt eq 'Y'}"> class="new"</c:if>>
								<c:choose>
									<c:when test="${not empty listData[boardListItem.iemId] or listData[boardListItem.iemId] ne ''}"><c:out value="${listData[boardListItem.iemId]}" /></c:when>
									<c:otherwise>&nbsp;</c:otherwise>
								</c:choose>
								</span>
								</c:otherwise>
							</c:choose>
							<c:if test="${listData.comtCnt ne ''}"> <small> [<c:out value="${listData.comtCnt}" />]</small></c:if>
						</th>
					</c:when>
					<%-- 파일일경우. 비밀글일경우 자신글이 아니면 링크안됨. --%>
					<c:when test="${boardListItem.iemId eq 'file'}">
						<td<c:if test="${not empty boardListItem.iemClass && boardListItem.iemClass ne ''}"> class="<c:out value="${boardListItem.iemClass}" />"</c:if>>
							<c:if test="${listData.fileNm ne ''}">
								<a href="<c:out value="${listData.fileHref}" />"><img src="${path.context}home/siiru/images/file.png" alt="<c:out value="${listData.fileAlt}" />"></a>
							</c:if>
						</td>
					</c:when>
					<%-- 기타 항목일 경우 --%>
					<c:otherwise>
						<td<c:if test="${not empty boardListItem.iemClass && boardListItem.iemClass ne ''}"> class="<c:out value="${boardListItem.iemClass}" />"</c:if>><c:out value="${listData[boardListItem.iemId]}" escapeXml="false" /></td>
					</c:otherwise>
				</c:choose>
				</c:forEach>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
		</tbody>
		</table>
	</div>
	<%-- 페이징 버튼. 자바스크립트로 호출 --%>
	<div id="boardPage">
		<div class="pagination"></div>
	</div>
<%-- 뷰페이지에서 목록 출력일 경우. 하단부분을 제거하기 위한 조건. 시작 --%>
<c:if test="${listView eq 'N'}">
<%-- 등록 버튼 --%>
<c:if test="${wrtBtn eq 'Y'}">
	<div class="siiru-tr siiru-mb20"><a href="<c:out value="${wrtLink}" />" class="siiru-btn siiru-btn-primary"><spring:message code="button.create" /></a></div>
</c:if>
<%-- 게시판 하단 출력 --%>
<c:if test="${not empty boardMaster.fterCn}">
	<div class="siiru-clr"><jsp:include page="${fterCn}" /></div>
</c:if>
</div>
<script>
// 페이지 로드가 완료되면
if (window.addEventListener) window.addEventListener("load", boardList, false);
else if (window.attachEvent) window.attachEvent("onload", boardList);
else window.onload = boardList;
// 리스트
function boardList() {
	// 추가된 항목 중 비디오가 있을경우
	if ($('[data-video]').length > 0) {
		$('[data-video]').each(function() {
			if ($.trim($(this).data('video')) != '') $(this).append(videoUrl($.trim($(this).data('video')), '', 280, 157.5));
		});
	}
	$(':radio[name="searchDateSet"]').change(function() {
		var now = new Date();
		var year = now.getFullYear();
		var month = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
		var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
		now.setDate(now.getDate()-parseInt($(this).val(),10));
		var syear = now.getFullYear();
		var smonth = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
		var sday = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
		$('#searchSDe').val(syear+'-'+smonth+'-'+sday);
		$('#searchEDe').val(year+'-'+month+'-'+day);
	});
	// 페이징 표출 [페이징표출 레이어ID, 페이지 번호, 전체 페이지수, 전체 개수]
	pagination('boardPage', ${page}, ${pageCnt}, ${totalCnt});
	// 페이징 버튼 클릭시 페이지 이동 및 검색어 유지
	$('.pagination').on('click', 'li a', function(e) {
		e.preventDefault();
		//window.location.href = $('#boardSearchForm').attr('action')+'?movePage='+$(this).data('move')+'&<c:out value="${pageSearch}" escapeXml="false" />';
		$('#boardSearchForm').find('input[name="movePage"]').val($(this).data('move'));
		$('#boardSearchForm').submit();
	});
	// 검색버튼 클릭 시 첫페이지로 이동할 경우. 단, 페이징에서 form submit 방식은 안되고 location.href 방식으로 해야됨
	//$('#boardSearchForm').submit(function(e) {
	//	$('#boardSearchForm').find('input[name="movePage"]').val('1');
	//});
}
</script>
<%-- 레이아웃 하단 출력 --%>
<c:if test="${footerUrl != null}"><jsp:include page="${footerUrl}" /></c:if>
<%@ include file="/WEB-INF/jsp/home/siiru/include/footer.jsp" %>
</c:if>
<%-- 뷰페이지에서 목록 출력일 경우. 하단부분을 제거하기 위한 조건. 끝 --%>