package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import project.BoardBean;
import project.BoardMgr;
import project.UtilMgr;


@WebServlet("/admin/adminamend")
public class adminamendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardBean bean = new BoardBean();
		BoardMgr mgr = new BoardMgr();
	    String inputTitle = request.getParameter("inputTitle");
	    String inputContent = request.getParameter("inputContent");
	    int num = UtilMgr.parseInt(request, "num");
//	    System.out.println("Received input_title: " + inputTitle);
//	    System.out.println("Received input_content: " + inputContent);
//	    System.out.println("Received input_content: " + num);
	    
	    mgr.updateboard(inputTitle, inputContent, num);
	    String redirectURL = "admin_post_view.jsp";
		redirectURL += "?num=" + num;
        //지정된 URL로 리다이렉트
        response.sendRedirect(redirectURL);
	    
	}

}
