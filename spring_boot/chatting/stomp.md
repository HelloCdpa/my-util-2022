## gradle
```
implementation group: 'org.webjars', name: 'stomp-websocket', version: '2.3.3-1'
```

### StompWebSocketConfig.java  
config폴더를 만들어서 StompWebSocketConfig 클래스를 하나 생성한다.  
```java
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

//Stomp를 사용하기위해 선언하는 어노테이션
@EnableWebSocketMessageBroker
@Configuration
public class StompWebSocketConfig implements WebSocketMessageBrokerConfigurer {

    //endpoint를 /stomp로 하고, allowedOrigins를 "*"로 하면 페이지에서
    //Get /info 404 Error가 발생한다. 그래서 아래와 같이 2개의 계층으로 분리하고
    //origins를 개발 도메인으로 변경하니 잘 동작하였다.
    //이유는 왜 그런지 아직 찾지 못함
    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/stomp/chat")
                .setAllowedOrigins("http://localhost:8091")
                .withSockJS();
    }

    /*어플리케이션 내부에서 사용할 path를 지정할 수 있음*/
    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
    // Client 에서 SEND 요청을 처리
    //Spring docs 에서는 /topic, /queue로 나오나 편의상 /pub, /sub로 변경
        registry.setApplicationDestinationPrefixes("/pub");
        //해당 경로로 SimpleBroker를 등록.
        // SimpleBroker는 해당하는 경로를 SUBSCRIBE하는 Client에게 메세지를 전달하는 간단한 작업을 수행
        registry.enableSimpleBroker("/sub");
        //enableStompBrokerRelay
        //SimpleBroker의 기능과 외부 Message Broker( RabbitMQ, ActiveMQ 등 )에 메세지를 전달하는 기능을 가짐
    }
}
```

### StompChatController
웹소켓을 사용할 컨트롤러를 만들어 준다.  
SimpMessagingTemplate 브로커로 메세지를 전달한다.  
채팅방에 들어오거나 채팅을 할 때,  
db에 채팅 이력을 저장한다.  

```java
package com.phl.cocolo.controller;

import com.phl.cocolo.dto.ChatMessageDetailDTO;
import com.phl.cocolo.dto.ChatMessageSaveDTO;
import com.phl.cocolo.entity.ChatMessageEntity;
import com.phl.cocolo.entity.ChatRoomEntity;
import com.phl.cocolo.repository.ChatRepository;
import com.phl.cocolo.repository.ChatRoomRepository;
import com.phl.cocolo.service.ChatService;
import lombok.RequiredArgsConstructor;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class StompChatController {

    private final SimpMessagingTemplate template; //특정 Broker로 메세지를 전달
    private final ChatRepository cr;
    private final ChatRoomRepository crr;
    private final ChatService cs;

    //Client 가 SEND 할 수 있는 경로
    //stompConfig 에서 설정한 applicationDestinationPrefixes 와 @MessageMapping 경로가 병합됨
    //"/pub/chat/enter"
    @MessageMapping(value = "/chat/enter")
    public void enter(ChatMessageDetailDTO message) {
        message.setMessage(message.getWriter() + "님이 채팅방에 참여하였습니다.");


        List<ChatMessageDetailDTO> chatList = cs.findAllChatByRoomId(message.getRoomId());
        if(chatList != null){
             for(ChatMessageDetailDTO c : chatList ){
                 message.setWriter(c.getWriter());
                 message.setMessage(c.getMessage());
             }
         }

        template.convertAndSend("/sub/chat/room/" + message.getRoomId(), message);

        ChatRoomEntity chatRoomEntity= crr.findByRoomId(message.getRoomId());
        ChatMessageSaveDTO chatMessageSaveDTO = new ChatMessageSaveDTO(message.getRoomId(),message.getWriter(), message.getMessage());
        cr.save(ChatMessageEntity.toChatEntity(chatMessageSaveDTO,chatRoomEntity));
    }

    @MessageMapping(value = "/chat/message")
    public void message(ChatMessageDetailDTO message) {
        template.convertAndSend("/sub/chat/room/" + message.getRoomId(), message);

        // DB에 채팅내용 저장
        ChatRoomEntity chatRoomEntity= crr.findByRoomId(message.getRoomId());
        ChatMessageSaveDTO chatMessageSaveDTO = new ChatMessageSaveDTO(message.getRoomId(),message.getWriter(), message.getMessage());
        cr.save(ChatMessageEntity.toChatEntity(chatMessageSaveDTO,chatRoomEntity));
    }
//    @MessageMapping 을 통해 WebSocket 으로 들어오는 메세지 발행을 처리한다.
//    Client 에서는 prefix 를 붙여 "/pub/chat/enter"로 발행 요청을 하면
//    Controller 가 해당 메세지를 받아 처리하는데,
//    메세지가 발행되면 "/sub/chat/room/[roomId]"로 메세지가 전송되는 것을 볼 수 있다.
//    Client 에서는 해당 주소를 SUBSCRIBE 하고 있다가 메세지가 전달되면 화면에 출력한다.
//    이때 /sub/chat/room/[roomId]는 채팅방을 구분하는 값이다.
//    기존의 핸들러 ChatHandler 의 역할을 대신 해주므로 핸들러는 없어도 된다.
}
```

```java
 	private final MentoringService mts;
  private final MemberService ms;
  private final ChatService cs;
    
//나의 멘토링 조회
    @GetMapping("/myMentoring/{memberId}")
    public String myMentoring(@PathVariable ("memberId") Long memberId, Model model){
        //멘티정보로 멘토 신청정보 찾기
        List<MenteeDetailDTO> menteeList = mts.findAllByMemberId(memberId);
        model.addAttribute("menteeList",menteeList);

        //멘토정보로 멘티 찾기
        List<MenteeDetailDTO> mentorList = mts.fundAllMentorMemberId(memberId);
        model.addAttribute("mentorList",mentorList);

        //채팅방 목록 불러오기
        model.addAttribute("rooms", cs.findAllRooms());


        return "/mentoring/myMentoring";
    }
    //채팅방 개설
    @PostMapping(value = "/room")
    public String create(@RequestParam String name,HttpSession session,Model model){
        Long memberId = (Long) session.getAttribute(LOGIN_ID);
        String memberNick = (String) session.getAttribute(LOGIN_NICKNAME);
        log.info("# Create Chat Room , name: " + name);

        cs.createChatRoomDTO(name,memberNick);

        return "redirect:/mentoring/myMentoring/"+memberId;
    }

    //채팅방 조회
    @GetMapping("/room")
    public void getRoom(String roomId, Model model,HttpSession session){
        //        Long memberId = (Long) session.getAttribute(LOGIN_ID);
        //        String memberProfileName = ms.findById(memberId).getMemberProfileName();
        //        model.addAttribute("memberProfileName",memberProfileName);
        log.info("# get Chat Room, roomID : " + roomId);

        model.addAttribute("room", cs.findRoomById(roomId));
    }
    ```
