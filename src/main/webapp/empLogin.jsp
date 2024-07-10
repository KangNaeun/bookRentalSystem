<%@ page import="db.dao.JoinDAO"%>
<%@ page import="db.dto.FindDTO"%>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
            href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Orbit&display=swap"
            rel="stylesheet">
        <style type="text/css">

            .main{
                justify-content: center;
                align-items: center;

            }
            .titlebox {
                width: 500px;
                margin-left: auto;
                margin-right: auto;
                margin-top: 2.5em;
                text-align: center;
                margin-bottom: 4rem;
                font-family: "Orbit", sans-serif;
                font-weight: 400;
                font-style: normal;
                font-size: 3em;
            }

            .fullbox {
                width: 100%;
                margin-left: auto;
                margin-right: auto;
                border-bottom: 1px solid #BDBDBD;
                padding-bottom: 5em;
            }

            .middlebox {
                width: 500px;
                margin-left: auto;
                margin-right: auto;
                padding: 1em;

            }

            .section_box01 {
                width: 500px;
                height: 100px;
                border: 1px solid #BDBDBD;
                padding-right: 1em;
                padding-left: 1em;
                padding-bottom: 1em;
                margin-top: -1.6em;
                padding-top: 1em;
                border-bottom: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                flex-direction: column;

            }
            .section_box02 {
                width: 500px;
                height: 150px;
                border: 1px solid #BDBDBD;
                padding-right: 1em;
                padding-left: 1em;
                padding-bottom: 1em;
                margin-top: -1.6em;
                padding-top: 0.5em;
                border-bottom: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                flex-direction: column;

            }
            .section_box03 {
                width: 500px;
                border: 1px solid #BDBDBD;
                padding-right: 1em;
                padding-left: 1em;
                padding-bottom: 1em;
                margin-top: -1.6em;
                padding-top: 0.5em;
            }
			#join{
			width: 30%;
			margin-top: 7px;
			border:none;
			right:20px;
			border: 1px solid #424242;
		   top:20px;
		   padding: 10px;
		   border: none;
		   background-color: #dcdcdc;
		   color: #333;
		   cursor: pointer;
		   border-radius: 4px;
			
			}
         
        </style>
</head>
<body>
	<body>
    <div class="main">
        <header>
            <div class="titlebox">로그인</div>
        </header>

        <section>
            <div class="fullbox">
                <div class="middlebox">
                    <form action='empLogin.jsp' method="post">
                        
                        <div class="section_box02">
                            <div>
                                아이디 :
                                <input type="text" name="input_join_emp_id"><br><br>
                            </div>
                            <div>
                                비밀번호 :
                                <input type="password" name="input_join_password"><br><br>
                            </div>
                            
                            <div>
                            	<button type="button"onclick="location.href='joinMember.jsp';">회원가입</button>                     	
                        		<button type="button"onclick="location.href='findId.jsp';">아이디찾기</button>
                        		<button type="button" onclick="location.href='findPw.jsp';">비밀번호찾기</button>
                        	</div>

                        </div>
                        <br>
                        <div class="section_box03" >
                        	
                            <div>
                                <center> <button type="submit" id="join"> 로그인 </button> </center>
                            </div>
                        </div>
                    </section>
                </form>
            </div>
        </div>
    </div>
    
    <%
   request.setCharacterEncoding("UTF-8"); //문자 인코딩 설정 한글깨짐 방지
    
    String emp_id = request.getParameter("input_join_emp_id");
    String password = request.getParameter("input_join_password");

    String[] params =  new String[]{emp_id, password};
    
    for( int i = 0; i < params.length; i++  ){
    	if( params[i] == null ){
    		
    	}else{
    		
    		 JoinDAO joinDAO = new JoinDAO(); 
    		 List<FindDTO> employeeList = joinDAO.loginEmployee(emp_id, password);
    		 
    		 if(employeeList!=null){
    			 for(FindDTO login : employeeList){
    				 session.setAttribute("ename", login.getEname());
    				 session.setAttribute("empno", login.getEmp_id());%>
    		 		<script>
    				 alert("<%=login.getEname()%>님 환영합니다.");
    				 location.href="bookRentalSystem.jsp";
    				 </script>
    		<% }
    	}  else {%>
    		<script>
			 alert("로그인 실패. 다시 로그인 해주세요");
			 location.href="bookRentalSystem.jsp";
			 </script>
    	<%}
    	  
 
    }
    		
   } %>

    </body>
</body>

    
        
  
