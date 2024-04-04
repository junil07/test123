package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import project.PaypostCommentBean;
import project.PaypostCommentMgr;
import project.UtilMgr;

@WebServlet("/admin/UnderCommentServlet")
public class UnderCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//대댓글 작성 서블릿
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PaypostCommentBean Pbean = new PaypostCommentBean();
		PaypostCommentMgr pMgr = new PaypostCommentMgr();
		String Cpos = request.getParameter("Cpos");
		String Cref = request.getParameter("Cref");
		String Cdepth = request.getParameter("Cdepth");
		String under_comment = request.getParameter("under_comment");
		String userId = request.getParameter("userId");
		int cnum = UtilMgr.parseInt(request, "num");
//		System.out.println("Cpos: " + Cpos);
//		System.out.println("Cref: " + Cref);
//		System.out.println("Cdepth: " + Cdepth);
//		System.out.println("under_comment:" + under_comment);
//		System.out.println("userId:" + userId);
//		System.out.println("num:" + cnum);
		
		pMgr.underComment(Cpos, Cref, Cdepth, under_comment, userId, cnum, Pbean);
		pMgr.getMaxRef(cnum, Cpos);
		// 대댓글 작성 후 이동할 페이지의 URL을 지정 (예시로 index.jsp를 지정함)
        String redirectURL = "paypost_listview.jsp";
        
        redirectURL += "?num=" + cnum;
        // 지정된 URL로 리다이렉트
        response.sendRedirect(redirectURL);
	}
}
