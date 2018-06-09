package com.neuedu.action;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

@WebServlet(urlPatterns = {"/image"})
public class ImageServlet extends HttpServlet{

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //生成一张图片响应给浏览器
        //1.创建图片对象
        BufferedImage image = new BufferedImage(60,20,BufferedImage.TYPE_INT_RGB);
        //2.获得图片的画笔
        Graphics g = image.getGraphics();
        //3.使用画笔向图片画东西
        //1).填充背景
        Random r = new Random();
        //2).给画笔生成一个随机的颜色
        g.setColor(new Color(r.nextInt(255),r.nextInt(255),r.nextInt(255)));
        //3).使用当前画笔颜色填充矩形
        g.fillRect(0,0,60,20);
        //4).改变画笔的颜色
        g.setColor(Color.BLACK);
        //5).向图片写四个随机数
        String code = "";
        for (int i = 0; i < 4; i++) {
            code += r.nextInt(10);
        }
        g.drawString(code,15,15);

        //6).添加删除线
        for (int i = 0; i < 3; i++) {
            g.setColor(new Color(r.nextInt(255),r.nextInt(255),r.nextInt(255)));
            g.drawLine(r.nextInt(60),r.nextInt(20),r.nextInt(60),r.nextInt(20));
        }


        HttpSession httpSession = req.getSession();
        httpSession.setAttribute("code",code);


        //7).将图片响应给浏览器
        resp.setContentType("image/jpeg");
        OutputStream out = resp.getOutputStream();
        JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
        encoder.encode(image);
    }
}
