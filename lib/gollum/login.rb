# encoding: utf-8
#require 'rjb'
require "open-uri"
class Auth


  #login
  #param username  paswd
  #return t
  # he role of user  or  nil

  def Auth.auth(uid,paswd)
    #RJM Loading
    jarPath = Dir.glob('./jars/*.jar').join(':')
    #print JARS
    Rjb::load(jarPath, ['-Xmx128M'])
    auth = Rjb::import('com.jd.si.client.http.HttpClient')
    signatureUrl='http://192.168.157.128:8080/external/getSignature'
    authUrl='http://192.168.157.128:8080/external/auth'
    authReturn = auth.auth(signatureUrl,authUrl,uid,paswd, '非erp', 'si-wiki')
    #get role
    return authReturn
  end

  # login in NoErp
  # reutrn null   normal   super
  def Auth.authUnErp(uid,paswd)
    authUrl='http://192.168.157.128:8080/external/auth/?'
    getUrl =authUrl+'username='+uid+'&pwd='+paswd+'&userType=%E9%9D%9Eerp&projectName=si-wiki'
    html_response = nil
    open(getUrl) do |http|
      html_response = http.read
    end
    puts html_response
    if html_response.include?'si-wiki-normal'
      return 'normal'
    elsif html_response.include?'si-wiki-super'
      return 'super'
    else
      return 'null'
    end

  end

  def Auth.printLoginForm(message)
    formStr = '<html>
      <title>Login</title>
       '

    endStr = '
     <h1>     	登录界面<h1>
       <form name="form1" method="post" action="/login" id="form1">

			    <div class="title"><h3>京东JD.com</h3></div>
                <input name="Name" type="text" id="Name"  placeholder="用户名" />
                <input name="Password" type="password" id="Password"  placeholder="密码" />

               <input type="submit" name="Logon" value="登  录" id="Logon" />


    </form>


</html>'

    complexStart ='<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><title>
	wiki验证系统
</title><link rel="stylesheet" href="http://erp1.jd.com/newHrm/css/sso_login/sso_login.css"><link rel="stylesheet" href="http://erp1.jd.com/newHrm/css/erpchangepw.css">
    <script type="text/javascript" src="%E9%AA%8C%E8%AF%81_files/jquery-1.js"> </script>

</head>
<body class="blue">
    <form name="form1" method="post" action="/login" id="form1">
<div>
<input name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwUKLTQ2ODYwNTE3NmRkIbNHY3T5Mqr6jz6ORILXKQAAAAA=" type="hidden">
</div>

<div>

	<input name="__EVENTVALIDATION" id="__EVENTVALIDATION" value="/wEWBAKno/TmDAKbufQdAtLF4JEPAu/P+d0FCpA84heSt2TTTEI8kk7OLwAAAAA=" type="hidden">
</div>

       <div id="main">
        <!-- right-side -->
            <div id="right-side" class="inner-login">
			    <div class="title"><h3>京东JD.com</h3></div>
                <div class="u-name" style="text-align:left"><input value="" name="Name" id="Name" tabindex="1" class="username" placeholder="用户名" type="text"></div>
                <div class="u-pwd" style="text-align:left"><input name="Password" id="Password" tabindex="2" class="password" placeholder="密码" style="margin:0 0 10px" type="password"></div>
				<div style="margin:0 0 10px;margin-left:130px">
'

    complexEnd ='</div>
				<!--<div style="margin:0 0 10px;margin-left:230px"><a target="_blank" href="/">返回首页</a></div>-->
                <div style="text-align:left"><input name="Logon" value="登  录" id="Logon" tabindex="3" class="submit" type="submit"></div>

                <div id="message" style="margin-top: 56px; margin-left: -24px; position: absolute; left: 230px; width: 1015px; text-align: center;">
                    <span id="MessageLabel"></span>
                </div>
            </div>
        </div>



           <!-- <div id="setIframe" class="box-warp m window window-modifyinfo">
                <iframe id="ifram_erp" height="380px" width="555px" src="NewHrm/ChangePassword_newErp.aspx"  scrolling="no" frameborder="0" ></iframe>
            </div>
        </div>-->

    </form>
      <script type="text/javascript" defer="defer">
          //关闭个性设置
          $("#jetui_erp_gx_close").click(function() {
              $("#erp_gx").hide();
          })
        </script>
		<script type="text/javascript" src="%E9%AA%8C%E8%AF%81_files/loginRecorder.js"></script>


</body></html>'



    #return formStr + message +endStr
    return complexStart +message + complexEnd
    #return complexStart  + complexEnd
  end
end
