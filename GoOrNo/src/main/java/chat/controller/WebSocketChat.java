package chat.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import chat.model.ChatMessageDao;

@Controller
@ServerEndpoint(value="/echo.do")
public class WebSocketChat {
    
    private static final List<Session> sessionList=new ArrayList<Session>();;
    private static final Logger logger = LoggerFactory.getLogger(WebSocketChat.class);
    
    public WebSocketChat() {
        // TODO Auto-generated constructor stub
        System.out.println("websoket obj created");
    }
    
    @OnOpen
    public void onOpen(Session session) {
        logger.info("Open session id:"+session.getId());
        System.out.println("============== session.getId() : "+session.getId());
        try {
            System.out.println("connect chat room");
        }catch (Exception e) {
            // TODO: handle exception
            System.out.println(e.getMessage());
        }
        sessionList.add(session);
    }
    
    /*
     * send message to All
     * @param self
     * @param sender
     * @param message
     */
    private void sendAllSessionToMessage(Session self, String sender, String message) {
    	
        try {
            for(Session session : WebSocketChat.sessionList) {
                if(!self.getId().equals(session.getId())) {
                	Date now = new Date();
                	int hours = now.getHours();
                	int minutes = now.getMinutes();
                	
                	if(sender.equals("info")) {
                		session.getBasicRemote().sendText("<tr><td align='center' style='padding: 3px;'><font size='2px'>"+message+"</font></td><tr>");
                	}else {
                		session.getBasicRemote().sendText("<tr><td align='left'><font size='1px'><b>"+sender +"</b> "+ hours+":"+minutes + "</font><br><div id='you'>"+message+"</div></td><tr>");
                	}
                }
            }
        }catch (Exception e) {
            // TODO: handle exception
            System.out.println(e.getMessage());
        }
    }
    
    /*
     * input message
     * @param message
     * @param session
     */
    @OnMessage
    public void onMessage(String message,Session session) {
    	
    	String sender = message.split(",")[1];
    	message = message.split(",")[0];
    	System.out.println("Message From "+sender + ": "+message);
        logger.info("Message From "+sender + ": "+message);
        try {
        	final Basic basic=session.getBasicRemote();
        	Date now = new Date();
        	int hours = now.getHours();
        	int minutes = now.getMinutes();
        	
        	if(sender.equals("info")) {
        		basic.sendText("<tr><td align='center' style='padding: 3px;'><font size='2px'>"+message+"</font></td><tr>"); //내 화면에 띄어짐
        	}else {
        		basic.sendText("<tr><td align='right'><font size='1px'>" + hours+":"+minutes + "</font><br><div id='me'>"+message+"<div></td><tr>"); //내 화면에 띄어짐
        	}
            
        }catch (Exception e) {
            // TODO: handle exception
            System.out.println(e.getMessage());
        }
        sendAllSessionToMessage(session, sender, message); //접속자 화면에 띄어짐
    }
    
	@OnError
    public void onError(Throwable e,Session session) {
        
    }
    
    @OnClose
    public void onClose(Session session) {
        logger.info("Session "+session.getId()+" has ended");
        sessionList.remove(session);
    }
}
