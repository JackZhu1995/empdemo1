package com.neuedu.mapper;

import com.neuedu.entity.User;
import org.apache.ibatis.annotations.Param;

public interface UserMapper {

    User getUserByUsername(String username);

    int saveUser(@Param("user") User user);

}
