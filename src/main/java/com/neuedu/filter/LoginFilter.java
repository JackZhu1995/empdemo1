package com.neuedu.filter;

import com.neuedu.entity.User;
import com.neuedu.mapper.UserMapper;
import com.neuedu.util.CookieUtil;
import com.neuedu.util.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

@WebFilter(urlPatterns = {"/*"})
public class LoginFilter implements Filter{

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("创建");
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        String uri = request.getRequestURI();
        if(uri.endsWith(".regist") || uri.endsWith(".jsp")  || uri.endsWith("ajaxtest") || uri.endsWith("checkusername") || uri.endsWith("code")|| uri.endsWith("regist") || uri.endsWith("image") || uri.endsWith(".css") || uri.endsWith(".js") || uri.endsWith(".gif") || uri.endsWith("login") || uri.endsWith("fileup")){
            filterChain.doFilter(servletRequest,servletResponse);
        }else {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            if(user == null){
                //判断cookie中还有没有用户名
                //1.获取cookie
                Cookie[] cookies = request.getCookies();
                Map<String,Cookie> cookieMap = CookieUtil.getCookieMap(cookies);
                Cookie usercookie = cookieMap.get("username");
                if (usercookie == null){
                    ((HttpServletResponse)servletResponse).sendRedirect("login.jsp");
                }else {
                    String username = usercookie.getValue();
                    SqlSession sqlSession = MyBatisUtil.getSession(true);
                    UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
                    User u = userMapper.getUserByUsername(username);
                    System.out.println(u.getUsername());
                    session.setAttribute("user",u);
                    sqlSession.close();
                    filterChain.doFilter(servletRequest,servletResponse);
                }
            }else {
                filterChain.doFilter(servletRequest,servletResponse);
            }
        }
        /*//万一写了 /*
        //1.先放行标准后缀的文件
        if(uri.endsWith(".jsp") || uri.endsWith(".css")){
            //放行请求
            filterChain.doFilter(servletRequest,servletResponse);
        }*/
    }

    @Override
    public void destroy() {
        System.out.println("销毁");
    }

}
