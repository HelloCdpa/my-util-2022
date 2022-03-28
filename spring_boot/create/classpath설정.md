## SpringBoot templates 경로 설정
      '/' -> 가장 최상의 디렉토리로 이동한다.(Web root)
      './' -> 파일이 현재 디렉토리를 의미한다.
      '../' -> 상위 디렉토리로 이동한다.
      
### templates 경로설정
스프링 부트에 web 의존성을 추가하고 localhost:80XX 로 접근하면  
기본적으로 resources 폴더에 있는 static 에 위치한 index.html 파일을 읽게된다.  

예를 들어, resources > static > assets > img > slide_3.jpg 를 가져올 때 src는 이렇게 작성하면 불러올 수 있다.  

```javascript
<img src="/assets/img/slide_3.jpg" alt="" width="40" height="40" class="rounded-circle"></a>
```

### 1. config 폴더를 생성하여 MvcConfiguration 클래스를 생성한다.

```
package com.phl.cocolo.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;


@Configuration
public class MvcConfiguration implements WebMvcConfigurer {
    @Override
    public void addResourceHandlers(final ResourceHandlerRegistry registry){
        registry.addResourceHandler("/**")
                .addResourceLocations("classpath:/templates/", "classpath:/static/");

    }
}
```
### 2. WebMvcConfigurer를 상속 받은 후 위와 같은 코드로 재정의 한다.

```java
<div class="nav_html"></div>

<script type="text/javascript">
    $(document).ready(function(){
        $(".nav_html").load("/base/nav.html")
    });
</script>
```
나는 resources > templates > base > nav.html 을 가져왔다.


