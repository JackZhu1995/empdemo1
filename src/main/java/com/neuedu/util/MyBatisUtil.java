package com.neuedu.util;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MyBatisUtil {

    public  static SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().
            build(MyBatisUtil.class.getClassLoader().getResourceAsStream("myBatis.xml"));

    public static SqlSession getSession(boolean autoCommit){
        return sqlSessionFactory.openSession(autoCommit);
    }

}
