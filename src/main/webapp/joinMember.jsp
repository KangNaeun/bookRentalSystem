<%@ page import="db.dao.JoinDAO"%>
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
                height: 100px;
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
            <div class="titlebox">회원가입</div>
        </header>

        <section>
            <div class="fullbox">
                <div class="middlebox">
                    <form action='joinMember.jsp' method="post">
                        <div class="section_box01">
                            <div>
                                사용자 ID :
                                <input type="text" name="input_join_emp_id"><br><br>
                            </div>
                            <div>
                                비밀 번호 :
                                <input type="password" name="input_join_password">
                            </div>
                            
                        </div>
                        <br>
                        <div class="section_box02">
                            <div>
                                이름 :
                                <input type="text" name="input_join_ename"><br><br>
                            </div>
                            <div>
                                생년월일 :
                                <input type="text" name="input_join_ebirth">
                            </div>

                        </div>
                        <br>
                        <div class="section_box03">
                            <div>
                                <center> <button type="submit" id="join"> 회원가입 </button> </center>
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
    String ename = request.getParameter("input_join_ename");
    String password = request.getParameter("input_join_password");
    String ebirth = request.getParameter("input_join_ebirth");
    
    String[] params =  new String[]{emp_id,  ename, password, ebirth};
    
    boolean isParamsNull = false;
    boolean isParamsBlank = false;
    
    for( int i = 0; i < params.length; i++  ){
    	if( params[i] == null){
    		isParamsNull = true;
    		break;
    	}
    	if( params[i].equals("")){
    		isParamsBlank = true;
    		break;
    	}
    }
    
    
   
    
   
    
    if(!isParamsNull && !isParamsBlank){
		JoinDAO joinDAO = new JoinDAO();
		int result= joinDAO.joinEmployee(emp_id, ename, password, ebirth);
		
		if(result > 0){%>
			<script>
				alert("회원이 되신 걸 축하드립니다! 로그인 해주세요.");
				location.href="empLogin.jsp";
			</script>
		<%} else {%>
			<script>
				alert("회원가입 실패! 다시 회원가입 해주세요");
				history.back();
			</script>
		<%}
    } else if(!isParamsNull){%>
    	<script>
			alert("모든 항목을 바르게 입력해주요.");
			history.back();
		</script>
   <% }%>
    
    
    
    
    	 
   

    </body>
</body>

    
        
  
