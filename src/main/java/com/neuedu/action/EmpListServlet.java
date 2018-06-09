package com.neuedu.action;

import com.neuedu.entity.Emp;
import com.neuedu.mapper.EmpMapper;
import com.neuedu.util.MyBatisUtil;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/emplist"})
public class EmpListServlet extends HttpServlet{

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //获得myBatis的session
        SqlSession sqlSession = MyBatisUtil.getSession(true);
        //使用session生成接口实现类
        EmpMapper empMapper = sqlSession.getMapper(EmpMapper.class);
        //查询出emp的集合
        List<Emp> empList = empMapper.listEmp();
        //将empList绑定到req上
        req.setAttribute("empList",empList);
        sqlSession.close();
        //转发
        req.getRequestDispatcher("emplist.jsp").forward(req,resp);
    }
}
