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
            <div class="titlebox">PW 찾기</div>
        </header>

        <section>
            <div class="fullbox">
                <div class="middlebox">
                    <form action='findPw.jsp' method="post">
                        
                        <div class="section_box02">
                            <div>
                                아이디 :
                                <input type="text" name="input_join_emp_id"><br><br>
                            </div>
                            <div>
                                생년월일 :
                                <input type="text" name="input_join_ebirth"><br><br>
                            </div>

                        </div>
                        <br>
                        <div class="section_box03">
                            <div>
                                <center> <button type="submit" id="join"> 찾기 </button> </center>
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
    String ebirth = request.getParameter("input_join_ebirth");

    String[] params =  new String[]{emp_id, ebirth};
    
	boolean isParamsNull = false;
    
    for( int i = 0; i < params.length; i++  ){
    	if( params[i] == null ){
    		isParamsNull = true;
    		break;
     	}
    
    }	
    
    if(!isParamsNull){
  		 JoinDAO joinDAO = new JoinDAO(); 
  		 List<FindDTO> findList = joinDAO.findPw(emp_id, ebirth);  		 
  		 
  		 if(findList!=null){
  			 for(FindDTO find : findList){ %>
  				<script>
  				 	alert(" 비밀번호 : <%=find.getPassword()%> " );
  	    			location.href="empLogin.jsp";
  	   			</script>
  		<% 
   		}
   	} 
   } %>
    </body>
</body>

    
        
  
