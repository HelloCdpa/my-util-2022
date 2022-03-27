### build.gradle에 추가
```
implementation 'org.springframework.boot:spring-boot-starter-web'
implementation 'org.springframework.boot:spring-boot-starter-data-jdbc'
```

### 1. repository에 mapper 폴더를 만들어 MemberMapper.xml 파일을 만든다.

### 2. application.yml
application.yml에 mybatis를 쓸건데 resource> mapper> 모든 xml을 쓰겠다고 말한다.
※이 때 띄어쓰기 주의할 것 ! mybatis는 딱 붙여서, mapper-location은 한 칸 띄운다.

```yml
mybatis:
  #  #resources/mapper/ 에 있는 모든 xml 파일을 내가 매퍼로 쓸거다.
  mapper-locations: mapper/*.xml
  #alias설정
#  type-aliases-package: com.phl.cocolo.dto
```

### 3. MemberMapperRepository

interface 파일로 만든 후 @Mapper를 하고
원하는 방식 대로 쿼리를 작성한다.

```java
package com.phl.cocolo.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import java.util.Map;

@Mapper
public interface MemberMapperRepository {
    //회원 포인트 충전
    @Update("update member_table set member_point = member_point + #{member_point} where member_id = #{member_id}")
    void pointCharge(Map<String, Object> memberPointUpdate);

    //회원목록 출력
    List<MemberDetailDTO> memberList();
    //회원가입
    void save(MemberSaveDTO memberSaveDTO);

    //mapper를 호출하지 않고 여기서 쿼리까지 수행하는 방식
    @Select("select * from member_table")
    List<MemberDetailDTO> memberList2();

    @Insert("insert into member_table(member_email,member_password,member_name) values (#{member_email},#{member_password},#{member_name})")
    void save2(MemberSaveDTO memberSaveDTO);
}
```

### 4. MemberMapper.xml
mapper namespace에 Repository 주소를 적는다.  
com.phl.cocolo.repository.MemberMapperRepository  

```xml
<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.phl.cocolo.repository.MemberMapperRepository">
    <update id="pointCharge"  parameterType="java.util.HashMap">
        update member_table set member_point = member_point + #{member_point}
        where member_id = #{member_id}
    </update>



    <select id="memberList" resultType="com.phl.cocolo.dto.MemberDetailDTO">
        select * from member_table
    </select>

    <insert id="save" parameterType="com.phl.cocolo.dto.MemberSaveDTO">
        insert into member_table(member_email,member_password,member_name)
        values (#{member_email},#{member_password},#{member_name})

    </insert>

</mapper>
```
### 5. MemberServiceImpl
private final MemberMapperRepository mmr; Repository를 불러와 사용한다.
```java
@Override
public void pointCharge(PointSaveDTO pointSaveDTO) {
    //포인트 이력 정보 저장
    MemberEntity memberEntity = mr.findById(pointSaveDTO.getMemberId()).get();
    PointEntity pointEntity = PointEntity.toPointSaveEntity(pointSaveDTO,memberEntity);
    pr.save(pointEntity);

    //회원 포인트 업데이트
    Map<String, Object> memberPointUpdate = new HashMap<>();
    memberPointUpdate.put("member_id", pointSaveDTO.getMemberId());
    memberPointUpdate.put("member_point", pointSaveDTO.getPointPoint());

    mmr.pointCharge(memberPointUpdate);

}

```
