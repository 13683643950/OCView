<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>重邮公开课</title>
	<link href="css/mystyle.css" rel="stylesheet" type="text/css" />
	<link href="css/update.css" rel="stylesheet" type="text/css" />
	<script src="js/core.js"></script>
	<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="js/login.js"></script>
	<script type="text/javascript" src="js/search.js"></script>
</head>

<body>
	
	<div class="login" id="login">
	    <h3>登录重邮公开课</h3>
	    <span id="close"><img src="images/ocview/close.png"/></span>
	    <input type="text" id="name"/>
	    <label id="name_value">账号</label>
	    <input type="password" id="psw" class="password"/>
	    <label id="psw_value">密码</label>
	    <input type="password" id="turepsw" class="password"/>
	    <label id="psw_true">确定密码</label>
	    <input type="text" id="nickName" /> 
	    <label id="nickName_value">昵称</label>
	    <input type="text" id="email"/>
	    <label id="email_value">邮箱</label>
	       
	    <input class="button" type="button" value="登录" id="denglu" onclick="userLogin();"/>
	    <input class="button" type="button" value="注册" id="zhuce" onclick="userRegist();"/>
	    
	    <p id="signInwrapper">没有账号？<a href="#" id="signIn">立即注册</a></p>
	    
	    <div id="messageReturn">　</div>
	</div>
	<div id="wrapper"></div>
	
	
	<div id="wrapperContent">
		<div id="top">
		   <s:if test="#session.user==null">
		   <span id="loginPage"><a href="#">登录</a></span>
		   </s:if>
		   <s:else>
		   <!-- userNickname 这里修改完 记得修改login.js -->
		   <span id="user_homepage"><a href="#">${user.userNickname}</a></span>
		   <span class="separation">|</span>
		   <span id="user_setting"><a href="#">设置</a></span>
		   <span class="separation">|</span>
		   <span id="user_exit"><a href="#" onclick="userExit();">退出</a></span>
		   </s:else>
		   <span class="separation">|</span>
		   <span class="span"><a href="about">关于</a></span>
		</div><!--end of top-->
		<div id="header">
			<div id="logo"><img src="images/ocview/logo.png" class="logo"/><img src="images/ocview/ocview.png" class="couse"/></div>
			<div id="soso"><input type="text" id="text" value="搜索视频，公开课"/><button onclick="seriesSearch();"></button></div>
		</div><!--end of header-->

		<div id="nav">
			<ul style="width:1263px;margin:0 auto;">
				<s:iterator value="#topList" status="st">
				<li>
					<s:if test="!navicationName.equals('首页')">
						<a href="${navicationUrl}" target="${navicationTarget}">${navicationName}</a>
					</s:if>
					<s:else>
						<a href="${navicationUrl}" target="${navicationTarget}" class="active">${navicationName}</a>
					</s:else>
				</li>
				</s:iterator>
			</ul>
		
		    <s:iterator value="#secondList" status="status">
				<s:if test="#status.count == 1">
					<div style="display:block;">
						<p>
							<s:iterator value="navList">
								<a href="${navicationUrl}" target="${navicationTarget}">${navicationName}</a>
							</s:iterator>
						</p>
					</div>
				</s:if>
				<s:else>
					<div>
						<p>
							<s:iterator value="navList">
								<a href="${navicationUrl}" target="${navicationTarget}">${navicationName}</a>
							</s:iterator>
						</p>
					</div>
				</s:else>
			</s:iterator>
		</div>
		
		<div class="content">
			<div style="width:1349px;margin:0 auto;position:relative;background:#FFF;">
				<div id="img">
	      			<ul>
						<s:iterator value="#recList" status="status">
							<s:if test="#status.count == 1">
								<li style="opacity:1;filter:alpha(opacity=100)">
									<s:a action="series?seriesId=%{series.seriesId}">
										<img src="${picturePath}"/>
									</s:a>
								</li>
							</s:if>
							<s:else>
								<li>
									<s:a action="series?seriesId=%{series.seriesId}">
										<img src="${picturePath}"/>
									</s:a>
								</li>
							</s:else>
						</s:iterator>
	      			</ul>
				</div><!--end of img-->
				<div id="hot">
					<div id="hotnews"><span class="span_active"><a href="#">热门排行</a></span><span><a href="#">最新课程</a></span></div>
					<ul style = "display:block;">
						<s:iterator value="#hotList">
				        	<li><s:a action="media?mediaId=%{mediaId}">${mediaName}</s:a></li>
				        </s:iterator>
					</ul> 
			        <ul>
				        <s:iterator value="#newList">
				        	<li><s:a action="media?mediaId=%{mediaId}">${mediaName}</s:a></li>
				        </s:iterator>
					</ul> 
				</div><!--end of hot-->
			</div>
			
			<s:iterator value="#secondList.get(0).navList" status="status">
				<s:if test="#status.count==1">
					<div class="col1wrapper">
						<div class="col1" id="col1">
							<h2>${navicationName}</h2>
							<ul>
								<s:iterator value="#recList" status="status">
									<li>
										<s:a action="series?seriesId=%{series.seriesId}">
											<img src="${series.picturePath}"/>
										</s:a>
										<span>${series.seriesName}</span>
										<span class="span">${series.seriesInfo}</span>
									</li>
								</s:iterator>
							</ul>
						</div>
					</div>
				</s:if>
				<s:else>
					<div <s:property value="#status.even?'class=full':'class=col2bg id=col'+#status.count"/> >
						<div <s:property value="#status.even?'class=col2 id=col'+#status.count:'class=col2bg_style'"/> >
							<div class="col2_1" >
								<div class="classity" <s:property value="#status.even?'':'id=bg'+#status.index"/> >
									<h2>${navicationName}</h2>
									<s:iterator value="#secondList.get(#status.index).navList">
										<span><s:a action="%{navicationUrl}">${navicationName}</s:a></span>
									</s:iterator>
								</div>
								<ul>
					        	<s:iterator value="#secondList.get(#status.index).seriesList" status="st">
					        		<s:if test="#st.index!=0">
					        			<li><s:a action="series?seriesId=%{seriesId}"><img src="${picturePath}"/></s:a><span>${seriesName}</span></li>
					        		</s:if>
					        	</s:iterator>
				        		</ul>
							</div>
							<div class="col2_2">
						      	<s:iterator value="#secondList.get(#status.index).seriesList" status="st">
						      		<s:if test="#st.index==0">
							      		<s:a action="series?seriesId=%{seriesId}"><img src="<s:property value="picturePath.split(\"\\\\.\")[0]+\"-new.\"+picturePath.split(\"\\\\.\")[1]"/>"/></s:a>
							        	<span>${seriesName}</span>
						        	</s:if>
						        </s:iterator>
							</div>
						</div>
					</div>
				</s:else>	
			</s:iterator>
  		</div>
  		
		<div id="footer">
			<div id="knowledge">
				<img src="images/ocview/footer_img.png"/>
			</div>
		</div>
		
	</div>
	
	<script type="text/javascript">
		var timer=null;
		ry.app.toText(); 
		ry.app.toPlay();
		ry.app.toDisplay();
		ry.app.toNews();
		ry.app.opacity();
		ry.app.openLogin();
		ry.app.toName();
		ry.app.passsword();
		ry.app.closeLogin();
		ry.app.trueLogin();
	</script>
</body>
</html>

  