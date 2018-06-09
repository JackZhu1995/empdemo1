package com.neuedu.action;

import com.neuedu.entity.User;
import com.neuedu.mapper.UserMapper;
import com.neuedu.util.MyBatisUtil;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.ibatis.session.SqlSession;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.*;

@WebServlet(urlPatterns = {"/regist"})
public class RegistServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String,String> param = new HashMap<>();
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload sfu = new ServletFileUpload(factory);
        try {
            List<FileItem> itemList = sfu.parseRequest(req);
            for (FileItem fileItem : itemList) {
                if(fileItem.isFormField()){
                    String name = fileItem.getFieldName();
                    String value = fileItem.getString("UTF-8");
                    param.put(name,value);
                }else {
                    String path = req.getServletContext().getRealPath("upload/");
                    File f = new File(path);
                    if(!f.exists()){
                        f.mkdirs();
                    }
                    String filePath = path + UUID.randomUUID().toString() + fileItem.getName().substring(fileItem.getName().indexOf("."));
                    File file = new File(filePath);
                    OutputStream out = new FileOutputStream(file);
                    InputStream in = fileItem.getInputStream();
                    byte[] b = new byte[8];
                    while (in.read(b) != -1){
                        out.write(b);
                    }
                    param.put("img_path",filePath.substring(filePath.indexOf("upload")));
                }
            }
        } catch (FileUploadException e) {
            e.printStackTrace();
        }

        //将集合中的数据存入数据库
        User user = new User(0,param.get("username"),param.get("password"),param.get("realname"),param.get("sex"),param.get("img_path"));
        SqlSession sqlSession = MyBatisUtil.getSession(true);
        UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
        userMapper.saveUser(user);
        resp.sendRedirect("login.jsp");

        /*Set<Map.Entry<String, String>> set = param.entrySet();
        for (Map.Entry<String, String> stringStringEntry : set) {
            System.out.println(stringStringEntry.getKey());
            System.out.println(stringStringEntry.getValue());
        }*/

    }
}
