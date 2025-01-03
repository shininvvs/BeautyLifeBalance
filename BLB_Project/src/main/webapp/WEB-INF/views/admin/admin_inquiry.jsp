<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin/adminSide.jsp" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Tables - SB Admin</title>
    </head>
    <body class="sb-nav-fixed">
        <div id="layoutSidenav">
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">관리페이지</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active"></li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                문의글 전체조회
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th>문의번호</th>
                                            <th>문의내용</th>
                                            <th>문의유형</th>
                                            <th>문의일</th>
                                            <th>답변여부</th>
                                            <th>게시여부</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                       <c:forEach var="i" items="${iList}">
                                            <tr data-inquiry-no="${i.inquiryNo}">
                                               <td contenteditable="true">${i.inquiryNo}</td>
                                               <td contenteditable="true">${i.inquiryContent}</td>
                                               <td contenteditable="true">${i.inquiryType}</td>
                                               <td contenteditable="true">${i.inquiryCreateDate}</td>
                                               <td contenteditable="true">${i.inquiryAnsweredYn}</td>
                                               <td contenteditable="true">${i.inquiryStatus}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <script>
            // 테이블의 행을 클릭했을 때 디테일 페이지로 이동
            $(document).on("click", "#datatablesSimple tbody tr", function() {
                const inquiryNo = $(this).data("inquiry-no"); // 클릭한 행의 inquiryNo 가져오기
                // 디테일 페이지로 이동
                window.location.href = "list.io";
            });
        </script>
    </body>
</html>
