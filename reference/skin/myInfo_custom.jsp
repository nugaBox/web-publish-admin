<div class="siiru-userWrap">
	<div class="userWrap">
		<h4>회원 정보</h4>

		<section id="M">
			<form id="siiru-userForm" name="siiru-userForm" method="post" enctype="multipart/form-data">

				<c:if test="${passwdChk eq 'N'}">
					<input type="hidden" id="passwdNow" name="passwdNow" value="">
					<input type="hidden" id="passwd" name="passwd" value="">
					<input type="hidden" id="passwdConfirm" name="passwdConfirm" value="">
				</c:if>

				<dl>
					<dt>아이디</dt>
					<dd><c:out value="${userInfo.userId}" /></dd>
				</dl>

				<dl>
					<dt>이름</dt>
					<dd><c:out value="${userInfo.userNm}" /> (<c:out value="${userInfo.sexNm}" />)</dd>
				</dl>

				<dl>
					<dt><label for="ncnm">닉네임</label></dt>
					<dd>
						<input type="text" class="small2 siiru-mr10" id="ncnm" name="ncnm" maxlength="50" value="<c:out value="${userInfo.ncnm}" />">
					</dd>
				</dl>

				<dl>
					<dt><span class="required">*</span> <label for="email">이메일</label></dt>
					<dd>
						<input type="text" id="email" name="email" maxlength="50" value="<c:out value="${userInfo.email}" />">
					</dd>
				</dl>

				<dl>
					<dt><label for="telno">전화번호</label></dt>
					<dd>
						<input type="text" id="telno" name="telno" class="small nothangul" maxlength="30" value="<c:out value="${userInfo.telno}" />">
					</dd>
				</dl>

				<dl>
					<dt><span class="required">*</span> <label for="mbtlnum">모바일번호</label></dt>
					<dd>
						<input type="text" id="mbtlnum" name="mbtlnum" class="small telText nothangul" maxlength="14" value="<c:out value="${userInfo.mbtlnum}" />">
					</dd>
				</dl>

				<dl>
					<dt><label for="zip">주소</label></dt>
					<dd>
						<input type="text" id="zip" name="zip" placeholder="우편번호" class="small telText nothangul" maxlength="7" value="<c:out value="${userInfo.zip}" />">
						<button class="zipFind siiru-btn siiru-btn-small siiru-ml10" type="button">우편번호 찾기 </button>

						<input type="text" id="addr" name="addr" placeholder="주소" class="siiru-mt5" maxlength="50" value="<c:out value="${userInfo.addr}" />">
						<input type="text" id="detailAddr" placeholder="상세주소" name="detailAddr" class="siiru-mt5" maxlength="50" value="<c:out value="${userInfo.detailAddr}" />">
					</dd>
				</dl>

				<dl>
					<dt><label for="ctprvn">지역</label></dt>
					<dd>
						<input type="hidden" id="areaCode" name="areaCode" value="<c:out value="${userInfo.areaCode}" />">

						<select id="ctprvn" name="ctprvn" class="areaSelect" data-arease="C" title="시/도">
							<option value="">시/도 선택</option>
							<c:forEach var="code" items="${ctprvnList}">
								<option value="<c:out value="${code.areaCode}" />"<c:out value="${code.selected}" />>
									<c:out value="${code.areaNm}" />
								</option>
							</c:forEach>
						</select>

						<select id="signgu" name="signgu" class="areaSelect siiru-ml10" data-arease="S" title="시/군/구">
							<option value="">시/군/구 선택</option>
							<c:forEach var="code" items="${signguList}">
								<option value="<c:out value="${code.areaCode}" />"<c:out value="${code.selected}" />>
									<c:out value="${code.areaNm}" />
								</option>
							</c:forEach>
						</select>

						<select id="emd" name="emd" class="areaSelect siiru-ml10" data-arease="D" title="읍/면/동">
							<option value="">읍/면/동 선택</option>
							<c:forEach var="code" items="${emdList}">
								<option value="<c:out value="${code.areaCode}" />"<c:out value="${code.selected}" />>
									<c:out value="${code.areaNm}" />
								</option>
							</c:forEach>
						</select>

						<c:if test="${areaTy eq 'L'}">
							<select id="dongli" name="dongli" class="areaSelect siiru-ml10" data-arease="L" title="리">
								<option value="">리 선택</option>
								<c:forEach var="code" items="${dongliList}">
									<option value="<c:out value="${code.areaCode}" />"<c:out value="${code.selected}" />>
										<c:out value="${code.areaNm}" />
									</option>
								</c:forEach>
							</select>
						</c:if>
					</dd>
				</dl>

				<dl>
					<dt>메일링 유무</dt>
					<dd>
						<c:forEach var="code" items="${emailAtList}">
							<input type="radio" id="emailAt_<c:out value="${code.codeId}" />" name="emailAt" value="<c:out value="${code.codeId}" />"<c:out value="${code.checked}" />>
							<label for="emailAt_<c:out value="${code.codeId}" />"> <c:out value="${code.codeNm}" /> </label>
						</c:forEach>
					</dd>
				</dl>

				<dl>
					<dt>SMS 수신여부</dt>
					<dd>
						<c:forEach var="code" items="${smsAtList}">
							<input type="radio" id="smsAt_<c:out value="${code.codeId}" />" name="smsAt" value="<c:out value="${code.codeId}" />"<c:out value="${code.checked}" />>
							<label for="smsAt_<c:out value="${code.codeId}" />"> <c:out value="${code.codeNm}" /> </label>
						</c:forEach>
					</dd>
				</dl>

				<dl>
					<dt>프로필 이미지</dt>
					<dd>
						<c:forEach var="code" items="${proflSeList}">
							<input type="radio" id="proflSe_<c:out value="${code.codeId}" />" name="proflSe" value="<c:out value="${code.codeId}" />"<c:out value="${code.checked}" />>
							<label for="proflSe_<c:out value="${code.codeId}" />"> <c:out value="${code.codeNm}" /> </label>
						</c:forEach>

						<input type="text" id="proflUrl" name="proflUrl" maxlength="150" class="siiru-mt10" value="<c:out value="${userInfo.proflUrl}" />" title="프로필 링크 URL" placeholder="http://"<c:if test="${userInfo.proflSe ne 'L'}"> disabled</c:if>>

						<div class="fileInfo<c:if test="${userInfo.proflSe eq 'L' || empty userInfo.proflImage || userInfo.proflImage eq ''}"> siiru-hidden</c:if>">
							<input type="hidden" id="old_proflImage" name="old_proflImage" value="<c:out value="${userInfo.proflImage}" />">
							<span><c:out value="${userInfo.proflImage}" /></span>
							<input type="checkbox" id="del_proflImage" name="del_proflImage" value="Y">
							<label for="del_proflImage"> Delete Files </label>
						</div>

						<input type="file" accept="image/*" id="proflImage" name="proflImage" class="file siiru-mt10" title="프로필 이미지"<c:if test="${userInfo.proflSe ne 'F'}"> disabled</c:if>>
					</dd>
				</dl>

				<c:if test="${not empty userItem && fn:length(userItem) > 0}">
					<c:forEach var="item" items="${userItem}" varStatus="status">
						<dl id="cFocus_<c:out value="${item.iemId}" />">
							<dt>
								<c:if test="${item.reqrdAt eq 'Y'}">
									<span class="required">*</span>
								</c:if>

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
												<option value="<c:out value="${code.codeId}" />"<c:out value="${code.selected}" />>
													<c:out value="${code.codeNm}" />
												</option>
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
													<option value="<c:out value="${stepCode.codeId}" />" data-codecl="<c:out value="${stepCode.codeCl}" />" data-codeid="<c:out value="${stepCode.codeId}" />"<c:out value="${stepCode.selected}" />>
														<c:out value="${stepCode.codeNm}" />
													</option>
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
										<div class="fileInfo siiru-pt0<c:if test="${empty item.val || item.val eq ''}"> siiru-hidden</c:if>">
											<input type="hidden" id="old_<c:out value="${item.iemId}" />" name="old_<c:out value="${item.iemId}" />" value="<c:out value="${item.val}" />">
											<span><c:out value="${item.val}" /></span>
											<input type="checkbox" id="del_<c:out value="${item.iemId}" />" name="del_<c:out value="${item.iemId}" />" value="Y">
											<label for="del_<c:out value="${item.iemId}" />"> Delete Files </label>
										</div>

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

				<div class="siiru-btnSet siiru-tc">
					<button type="button" id="userSubmit" class="siiru-btn siiru-btn-primary">수정</button>
					<button type="button" id="cancelBtn" class="siiru-btn siiru-btn-default siiru-ml10">취소</button>
				</div>
			</form>
		</section>
	</div>
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
// 페이지 로드가 완료되면
if (window.addEventListener) window.addEventListener("load", myInfo, false);
else if (window.attachEvent) window.attachEvent("onload", myInfo);
else window.onload = myInfo;

function myInfo() {
	// 우편번호 찾기 버튼
	$('.zipFind').click(function() {
		zipFind();
	});

	// 지역 선택
	$('.areaSelect').change(function() {
		var areaSe = $.trim($(this).data('arease'));

		if (areaSe == 'C') {
			$('#areaCode').val($.trim($(this).val()));
			$('#signgu option').not(':first').remove();
			$('#emd option').not(':first').remove();

			if ($('#dongli').length > 0) {
				$('#dongli option').not(':first').remove();
			}

			if ($.trim($(this).val()) != '') {
				findArea('S', 'signgu');
			}

		} else if (areaSe == 'S') {
			if ($.trim($(this).val()) != '') {
				$('#areaCode').val($.trim($(this).val()));
			} else {
				$('#areaCode').val($.trim($('#ctprvn option:selected').val()));
			}

			$('#emd option').not(':first').remove();

			if ($('#dongli').length > 0) {
				$('#dongli option').not(':first').remove();
			}

			if ($.trim($(this).val()) != '') {
				findArea('D', 'emd');
			}

		} else if (areaSe == 'D') {
			if ($.trim($(this).val()) != '') {
				$('#areaCode').val($.trim($(this).val()));
			} else {
				$('#areaCode').val($.trim($('#signgu option:selected').val()));
			}

			if ($('#dongli').length > 0) {
				$('#dongli option').not(':first').remove();

				if ($.trim($(this).val()) != '') {
					findArea('L', 'dongli');
				}
			}

		} else if (areaSe == 'L') {
			if ($.trim($(this).val()) != '') {
				$('#areaCode').val($.trim($(this).val()));
			} else {
				$('#areaCode').val($.trim($('#emd option:selected').val()));
			}
		}
	});

	// 프로필 구분
	$(':radio[name="proflSe"]').change(function() {
		if ($(this).val() == 'L') {
			$('#proflUrl').prop('disabled', false);
			$('.file').prop('disabled', true);
		} else {
			$('#proflUrl').prop('disabled', true);
			$('.file').prop('disabled', false);
		}
	});

	// 코드선택
	$('.codeStepSelect').change(function() {
		var selectData = $(this).data();
		var itemName = $.trim(selectData.name);
		var selectName = $.trim(selectData.name) + '_codeStep';
		var codeStep = parseInt(selectData.step, 10);
		var codeStepMax = parseInt(selectData.maxstep, 10);
		var selData = $(this).find(':selected').data();
		var selStep = codeStep + 1;

		for (var i = selStep; i <= codeStepMax; i++) {
			$('select[name="' + selectName + '' + i + '"] option').not(':first').remove();
		}

		if ($.trim($(this).val()) != '') {
			$.post('<c:out value="${path.context}" />getCodeStep.do', {
				'codeCl': $.trim(selData.codecl),
				'codeStep': selStep,
				'upperCodeId': $.trim(selData.codeid)
			}).done(function(data) {
				if (data.error == 'N') {
					$.each(data.dataList, function(key, values) {
						$('select[name="' + selectName + '' + selStep + '"]').append(
							'<option value="' + values.codeId + '" data-codecl="' + values.codeCl + '" data-codeid="' + values.codeId + '">' + values.codeNm + '</option>'
						);
					});
				}
			});
		}

		if ($.trim($(this).val()) != '') {
			$('#' + itemName).val($.trim($(this).val()));
		} else {
			if (codeStep > 1) {
				$('#' + itemName).val($.trim($('select[name="' + selectName + '' + (codeStep - 1) + '"] option:selected').val()));
			} else {
				$('#' + itemName).val('');
			}
		}
	});

	// 저장
	$('#userSubmit').click(function(e) {
		e.preventDefault();

		var $userForm = $('#siiru-userForm');

		if (!($userForm.find('input[name="ncnm"]').val() == '' || $userForm.find('input[name="ncnm"]').val().trim().length != 0)) {
			alert('닉네임 : 공백(Space)은 입력할 수 없습니다.');
			$userForm.find('input[name="ncnm"]').focus();

		} else if (($.trim($userForm.find('input[name="passwd"]').val()) != '') && ($.trim($userForm.find('input[name="passwdNow"]').val()) == '')) {
			alert('현재 비밀번호를 입력해 주세요.');
			$userForm.find('input[name="passwdNow"]').focus();

		} else if ((($.trim($userForm.find('input[name="passwd"]').val()) != '') || ($.trim($userForm.find('input[name="passwdConfirm"]').val()) != '')) && ($.trim($userForm.find('input[name="passwd"]').val()) != $.trim($userForm.find('input[name="passwdConfirm"]').val()))) {
			alert('비밀번호 확인 : 비밀번호가 일치하지 않습니다.');
			$userForm.find('input[name="passwdConfirm"]').focus();

		} else if ((($.trim($userForm.find('input[name="passwd"]').val()) != '') || ($.trim($userForm.find('input[name="passwdNow"]').val()) != '')) && ($.trim($userForm.find('input[name="passwd"]').val()) == $.trim($userForm.find('input[name="passwdNow"]').val()))) {
			alert('현재 비밀번호와 새 비밀번호가 동일합니다.\n다른 비밀번호로 변경해 주세요.');
			$userForm.find('input[name="passwd"]').focus();

		} else if (($.trim($userForm.find('input[name="passwd"]').val()) != '') && (!ValidPasswd($userForm.find('input[name="passwd"]').val()))) {
			alert('비밀번호 : 비밀번호 유효성 검사를 통과하지 못했습니다.');
			$userForm.find('input[name="passwd"]').focus();

		} else if ($.trim($userForm.find('input[name="email"]').val()) == '') {
			alert('이메일을 입력해 주세요.');
			$userForm.find('input[name="email"]').focus();

		} else if (($.trim($userForm.find('input[name="email"]').val()) != '') && (!ValidEmail($.trim($userForm.find('input[name="email"]').val())))) {
			alert('이메일 : 잘못된 이메일 형식입니다.');
			$userForm.find('input[name="email"]').focus();

		} else if (($.trim($userForm.find('input[name="telno"]').val()) != '') && (!ValidTel($.trim($userForm.find('input[name="telno"]').val())))) {
			alert('전화번호 : 잘못된 전화번호 형식입니다.');
			$userForm.find('input[name="telno"]').focus();

		} else if ($.trim($userForm.find('input[name="mbtlnum"]').val()) == '') {
			alert('모바일번호를 입력해 주세요.');
			$userForm.find('input[name="mbtlnum"]').focus();

		} else if (($.trim($userForm.find('input[name="mbtlnum"]').val()) != '') && (!ValidMobile($.trim($userForm.find('input[name="mbtlnum"]').val())))) {
			alert('모바일번호 : 잘못된 모바일번호 형식입니다.');
			$userForm.find('input[name="mbtlnum"]').focus();

		} else if (($.trim($userForm.find('[name="ctprvn"]').val()) != '') && ($.trim($userForm.find('[name="signgu"]').val()) == '')) {
			alert('시/군/구 : 필수 항목입니다.');
			$userForm.find('[name="signgu"]').focus();

		} else {
			if ($.trim($(':radio[name="proflSe"]:checked').val()) == 'L') {
				if (($('#proflUrl').val() != '') && ($.inArray($('#proflUrl').val().split('.').pop().toLowerCase(), ['gif', 'jpg', 'jpeg', 'png']) == -1)) {
					alert('이미지 파일만 링크 하실 수 있습니다.');
					$userForm.find('input[name="proflUrl"]').focus();
					return false;
				}
			} else {
				if (($('#proflImage').val() != '') && ($.inArray($('#proflImage').val().split('.').pop().toLowerCase(), ['gif', 'jpg', 'jpeg', 'png']) == -1)) {
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
							if (!$(':radio[name="<c:out value="${item.iemId}" />"]').is(':checked')) {
								alert('<c:out value="${item.iemNm}" /> : 필수 항목입니다.');
								$('html,body').animate({scrollTop: $('#cFocus_<c:out value="${item.iemId}" />').offset().top}, 0);
								return false;
							}
						</c:when>

						<c:when test="${item.iemSe eq 'C' && item.reqrdAt eq 'Y'}">
							if ($(':checkbox[name="<c:out value="${item.iemId}" />[]"]:checked').length == 0) {
								alert('<c:out value="${item.iemNm}" /> : 필수 항목입니다.');
								$('html,body').animate({scrollTop: $('#cFocus_<c:out value="${item.iemId}" />').offset().top}, 0);
								return false;
							}
						</c:when>

						<c:when test="${item.iemSe eq 'M'}">
							<c:if test="${item.reqrdAt eq 'Y'}">
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
									beginDt = $('#<c:out value="${item.iemId}" />_1').val() + ' 00:00:00';
								}

								if ($.trim($('#<c:out value="${item.iemId}" />_2').val()) != '') {
									endDt = $('#<c:out value="${item.iemId}" />_2').val() + ' 00:00:00';
								}

								if ((beginDt != '') && (endDt != '')) {
									var startDate = new Date(beginDt);
									var stopDate = new Date(endDt);

									if (startDate > stopDate) {
										alert('<c:out value="${item.iemNm}" /> : 시작일자가 종료일자 보다 큽니다.');
										$('html,body').animate({scrollTop: $('#cFocus_<c:out value="${item.iemId}" />').offset().top}, 0);
										return false;
									}
								}
							}
						</c:when>

						<c:when test="${item.iemSe eq 'Z'}">
							<c:if test="${item.reqrdAt eq 'Y'}">
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
										beginDt = $('#<c:out value="${item.iemId}" />_T1').val() + ' ' + $('#<c:out value="${item.iemId}" />_T2').val() + ':00';
									} else {
										beginDt = $('#<c:out value="${item.iemId}" />_T1').val() + ' 00:00:00';
									}
								}

								if ($.trim($('#<c:out value="${item.iemId}" />_T3').val()) != '') {
									if ($.trim($('#<c:out value="${item.iemId}" />_T4').val()) != '') {
										endDt = $('#<c:out value="${item.iemId}" />_T3').val() + ' ' + $('#<c:out value="${item.iemId}" />_T4').val() + ':00';
									} else {
										endDt = $('#<c:out value="${item.iemId}" />_T3').val() + ' 00:00:00';
									}
								}

								if ((beginDt != '') && (endDt != '')) {
									var startDate = new Date(beginDt);
									var stopDate = new Date(endDt);

									if (startDate > stopDate) {
										alert('<c:out value="${item.iemNm}" /> : 시작일시가 종료일시 보다 큽니다.');
										$('html,body').animate({scrollTop: $('#cFocus_<c:out value="${item.iemId}" />').offset().top}, 0);
										return false;
									}
								}
							}
						</c:when>

						<c:when test="${item.iemSe eq 'F'}">
							<c:if test="${item.reqrdAt eq 'Y'}">
								if ($.trim($('#<c:out value="${item.iemId}" />').val()) == '') {
									if ($.trim($('#old_<c:out value="${item.iemId}" />').val()) == '' || $(':checkbox[name="del_<c:out value="${item.iemId}" />"]').is(':checked')) {
										alert('<c:out value="${item.iemNm}" /> : 필수 항목입니다.');
										$('#<c:out value="${item.iemId}" />').focus();
										return false;
									}
								}
							</c:if>

							<c:if test="${not empty item.iemDc or item.iemDc ne ''}">
								if ($.trim($('#<c:out value="${item.iemId}" />').val()) != '' && $.inArray($.trim($('#<c:out value="${item.iemId}" />').val()).split('.').pop().toLowerCase(), [<c:out value="${item.iemExt}" escapeXml="false" />]) == -1) {
									alert('<c:out value="${item.iemNm}" /> : 허용되는 확장자[<c:out value="${item.iemDc}" />]만 업로드 하실 수 있습니다.');
									$('#<c:out value="${item.iemId}" />').focus();
									return false;
								}
							</c:if>
						</c:when>

						<c:otherwise>
							<c:if test="${item.reqrdAt eq 'Y'}">
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
						if (($.trim($('#<c:out value="${item.iemId}" />_1').val()) != '') || ($.trim($('#<c:out value="${item.iemId}" />_2').val()) != '')) {
							$('#<c:out value="${item.iemId}" />').val($.trim($('#<c:out value="${item.iemId}" />_1').val()) + '|' + $.trim($('#<c:out value="${item.iemId}" />_2').val()));
						} else {
							$('#<c:out value="${item.iemId}" />').val('');
						}
					</c:if>

					<c:if test="${item.iemSe eq 'C'}">
						var <c:out value="${item.iemId}" />Arr = [];

						$(':checkbox[name="<c:out value="${item.iemId}" />[]"]:checked').each(function() {
							<c:out value="${item.iemId}" />Arr.push($(this).val());
						});

						$('#<c:out value="${item.iemId}" />').val(<c:out value="${item.iemId}" />Arr);
					</c:if>

					<c:if test="${item.iemSe eq 'M'}">
						if ($.trim($('#<c:out value="${item.iemId}" />_1').val()) != '' || $.trim($('#<c:out value="${item.iemId}" />_2').val()) != '') {
							$('#<c:out value="${item.iemId}" />').val($.trim($('#<c:out value="${item.iemId}" />_1').val()) + ' ~ ' + $.trim($('#<c:out value="${item.iemId}" />_2').val()));
						} else {
							$('#<c:out value="${item.iemId}" />').val('');
						}
					</c:if>

					<c:if test="${item.iemSe eq 'Z'}">
						if ($.trim($('#<c:out value="${item.iemId}" />_T1').val()) != '') {
							if ($.trim($('#<c:out value="${item.iemId}" />_T2').val()) != '') {
								$('#<c:out value="${item.iemId}" />_1').val($('#<c:out value="${item.iemId}" />_T1').val() + ' ' + $('#<c:out value="${item.iemId}" />_T2').val());
							} else {
								$('#<c:out value="${item.iemId}" />_1').val($('#<c:out value="${item.iemId}" />_T1').val() + ' 00:00');
							}
						} else {
							$('#<c:out value="${item.iemId}" />_1').val('');
						}

						if ($.trim($('#<c:out value="${item.iemId}" />_T3').val()) != '') {
							if ($.trim($('#<c:out value="${item.iemId}" />_T4').val()) != '') {
								$('#<c:out value="${item.iemId}" />_2').val($('#<c:out value="${item.iemId}" />_T3').val() + ' ' + $('#<c:out value="${item.iemId}" />_T4').val());
							} else {
								$('#<c:out value="${item.iemId}" />_2').val($('#<c:out value="${item.iemId}" />_T3').val() + ' 00:00');
							}
						} else {
							$('#<c:out value="${item.iemId}" />_2').val('');
						}

						if ($.trim($('#<c:out value="${item.iemId}" />_1').val()) != '' || $.trim($('#<c:out value="${item.iemId}" />_2').val()) != '') {
							$('#<c:out value="${item.iemId}" />').val($.trim($('#<c:out value="${item.iemId}" />_1').val()) + ' ~ ' + $.trim($('#<c:out value="${item.iemId}" />_2').val()));
						} else {
							$('#<c:out value="${item.iemId}" />').val('');
						}
					</c:if>
				</c:forEach>
			</c:if>

			var formData = new FormData($('#siiru-userForm')[0]);

			formData.append('pageId', '<c:out value="${param.pageId}" />');

			$('#siiru-userForm').find(':checkbox').each(function() {
				if (!$(this).is(':checked')) {
					formData.append($(this).prop('name'), 'N');
				}
			});

			ajaxForm('<c:out value="${path.context}" />myInfoAction.do', formData, function(data) {
				if (data.error == 'N') {
					alert('성공적으로 수정되었습니다.');
					window.document.location.href = '<c:out value="${path.context}" />myInfo.do?pageId=<c:out value="${param.pageId}" />';
				}
			});
		}

		return false;
	});

	// 취소 버튼
	$('#cancelBtn').click(function(e) {
		e.preventDefault();
		window.document.location.href = '<c:out value="${path.context}" />myInfo.do?pageId=<c:out value="${param.pageId}" />';
	});
}

// 지역코드를 불러온다. [C:시/도, S:시/군/구, D:읍/면/동, L:동/리]
function findArea(areaSe, areaId) {
	$('#' + areaId + ' option').not(':first').remove();

	$.post('<c:out value="${path.context}" />getAreaList.do', {
		'areaSe': areaSe,
		'areaCode': $.trim($('#areaCode').val())
	}).done(function(data) {
		if (data.error == 'N') {
			$.each(data.dataList, function(key, values) {
				$('#' + areaId).append('<option value="' + $.trim(values.areaCode) + '">' + $.trim(values.areaNm) + '</option>');
			});
		}
	});
}

// 우편번호
function zipFind() {
	new daum.Postcode({
		oncomplete: function(data) {
			var extraAddr = '';
			var fullAddr = $.trim(data.roadAddress);

			if ($.trim(data.bname) !== '') {
				extraAddr += $.trim(data.bname);
			}

			if ($.trim(data.buildingName) !== '') {
				extraAddr += (extraAddr !== '' ? ', ' + $.trim(data.buildingName) : $.trim(data.buildingName));
			}

			fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');

			$('#zip').val($.trim(data.zonecode));
			$('#addr').val(fullAddr);
			$('#detailAddr').focus();
		}
	}).open();
}
</script>