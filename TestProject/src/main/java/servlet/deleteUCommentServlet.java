package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import project.PaypostCommentMgr;
import project.UtilMgr;

@WebServlet("/admin/deleteUComment")
public class deleteUCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//댓글 삭제 서블릿
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PaypostCommentMgr pMgr = new PaypostCommentMgr();
		String Dpos = request.getParameter("Dpos");
		String Dref = request.getParameter("Dref");
		String Ddepth = request.getParameter("Ddepth");
		int Dnum = UtilMgr.parseInt(request, "Dnum");
//		System.out.println("Dpos:" + Dpos);
//		System.out.println("Dref:" + Dref);
//		System.out.println("Ddepth:" + Ddepth);
//		System.out.println("Dnum:" + Dnum);
		
		pMgr.deleteComment(Dpos, Dref, Ddepth);
		String redirectURL = "paypost_listview.jsp";
		redirectURL += "?num=" + Dnum;
        //지정된 URL로 리다이렉트
        response.sendRedirect(redirectURL);
	}
}
