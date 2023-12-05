<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>roomReservation.jsp</title>
	<jsp:include page="/include/bs4.jsp"/>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<style>
	  #td1,#td8,#td15,#td22,#td29,#td36 {color: red}
	  #td7,#td14,#td21,#td28,#td35 {color: blue}
	  
	  .today {
	    background-color: pink;
	    color: #fff;
	    font-weight: bolder;
	    }
	    
    .bgColor {
        background-color: rgb(166, 219, 240);
    }
    
	</style>
<script>
  'use strict';

  let today = new Date();
  let year = today.getFullYear();
  let month = today.getMonth();
  let date = today.getDate();

  let sw = 0;

  $(function() {
    let firstDate = 0;
    let lastDate = 0;

    let ymd = year + "-" +(month+1) + "-" + date;
    $('#demo').html("오늘 날짜 : " + ymd);
    
    $('td').click(function() {
      if(sw == 0) {
        for(let i=1; i<=30; i++) {
          if($('tr td').eq(i).hasClass('bgColor') == true) {
            $('tr td').eq(i).removeClass('bgColor');
          }
        }
      }
      
      let cellText = eval($(this).text());
      if(cellText < date) {
        alert("오늘 이전일은 선택할 수 없습니다.");
        return false;
      }

      if(sw == 0) {
        $(this).addClass('bgColor');
        firstDate = eval($(this).text());
        $('#demo').html("선택된 날짜 : " + firstDate + " ~ " + lastDate);
        sw = 1;
      }
      else {
        lastDate = eval($(this).text());
        if(firstDate > lastDate) {
          alert("시작일 이후날짜를 선택해주세요");
          return false;
        }
        $('#demo').html("선택된 날짜 : " + firstDate + " ~ " + lastDate);
        for(let i=firstDate; i<lastDate; i++) {
          $('tr td').eq(${startWeek}-1).addClass('bgColor');
        }
        sw = 0;
      }
    });
  });
</script>   
</head>
<body>
<jsp:include page="/include/header.jsp"/>
<p><br/></p>
<div class="container">
<h2>예 약 페 이 지</h2>
<div>
	<div class="text-center">
	  <button type="button" onclick="location.href='roomReservation.room?yy=${yy-1}&mm=${mm}';" class="btn btn-secondary btn-sm" title="이전년도"><i class='fas fa-angle-double-left' style='font-size:20px'></i></button>
	  <button type="button" onclick="location.href='roomReservation.room?yy=${yy}&mm=${mm-1}';" class="btn btn-secondary btn-sm" title="이전월"><i class='fas fa-angle-left' style='font-size:20px'></i></button>
	  <font size="5">${yy}년 ${mm+1}월</font>
	  <button type="button" onclick="location.href='roomReservation.room?yy=${yy}&mm=${mm+1}';" class="btn btn-secondary btn-sm" title="다음월"><i class='fas fa-angle-right' style='font-size:20px'></i></button>
	  <button type="button" onclick="location.href='roomReservation.room?yy=${yy+1}&mm=${mm}';" class="btn btn-secondary btn-sm" title="다음년도"><i class='fas fa-angle-double-right' style='font-size:20px'></i></button>
	  <button type="button" onclick="location.href='roomReservation.room';" class="btn btn-secondary btn-sm" title="오늘날짜"><i class='fas fa-home' style='font-size:20px'></i></button>
	</div>
	<br/>
	<div class="text-center">
	  <table class="table table-bordered" style="height:450px">
	    <tr class="table-dark text-dark">
	      <th style="width:14%; vertical-align:middle; color:red">일</th>
	      <th style="width:14%; vertical-align:middle;">월</th>
	      <th style="width:14%; vertical-align:middle;">화</th>
	      <th style="width:14%; vertical-align:middle;">수</th>
	      <th style="width:14%; vertical-align:middle;">목</th>
	      <th style="width:14%; vertical-align:middle;">금</th>
	      <th style="width:14%; vertical-align:middle; color:blue">토</th>
	    </tr>
	    <tr>
	      <!-- 시작일 이전을 공백을 이전달의 날짜로 채워준다. -->
	      <c:forEach var="prevDay" begin="${prevLastDay - (startWeek - 2)}" end="${prevLastDay}" varStatus="st">
	        <td style="font-size:0.6em;color:#ccc;text-align:left;">${prevYear}-${prevMonth+1}-${prevDay}</td>
	      </c:forEach>
	      
	      <!-- 해당월의 1일을 해당 startWeek위치부터 출력(날짜는 1씩 증가시켜주고, 7칸이 될때 행을 변경처리한다.) -->
	      <c:set var="cell" value="${startWeek}" />
	      <c:forEach begin="1" end="${lastDay}" varStatus="st">
	        <c:set var="todaySw" value="${toYear==yy && toMonth==mm && toDay==st.count ? 1 : 0}"/>
	        <c:set var="ymd" value="${yy}-${mm+1}-${st.count}"/>
	        <td id="td${cell}" ${todaySw==1 ? 'class=today' : ''}>${st.count}</td>  
	        <c:if test="${cell % 7 == 0}"></tr><tr></c:if>
	        <c:set var="cell" value="${cell + 1}" />
	      </c:forEach>
	      
	      <!-- 마지막일 이후를 다음달의 시작일자부터 채워준다. -->
	      <c:if test="${(cell - 1) % 7 != 0}">
	        <c:forEach var="nextDay" begin="${nextStartWeek}" end="7" varStatus="st">
	          <td style="font-size:0.6em;color:#ccc;text-align:left;">${nextYear}-${nextMonth+1}-${st.count}</td>
	        </c:forEach>
	      </c:if>
	    </tr>
	  </table>
	</div>
    <div id="demo"></div>
	<button type="button" onclick="resDate">예약날짜설정하기</button>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp"/>
</body>
</html>