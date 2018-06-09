package com.neuedu.action;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = {"/dropout"})
public class DropOutServlet extends HttpServlet{

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //清除session和cookie
        HttpSession session = req.getSession();
        session.removeAttribute("user");

        Cookie cookie = new Cookie("username","");
        cookie.setMaxAge(0);
        resp.addCookie(cookie);

        resp.sendRedirect("login.jsp");

    }
}
