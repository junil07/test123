package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import project.Board_commentBean;
import project.Board_commentMgr;
import project.UtilMgr;


@WebServlet("/admin/insertcomment")
public class insertpostCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Board_commentBean cbean = new Board_commentBean();
		Board_commentMgr cmgr = new Board_commentMgr();
		String Cpos = request.getParameter("Cpos");
		String Cref = request.getParameter("Cref");
		String Cdepth = request.getParameter("Cdepth");
		String under_comment = request.getParameter("under_comment");
		String userId = request.getParameter("userId");
		int cnum = UtilMgr.parseInt(request, "num");
		System.out.println(userId);
		cmgr.underComment(Cpos, Cref, Cdepth, under_comment, userId, cnum, cbean);
		cmgr.getMaxRef(cnum, Cpos);
		String redirectURL = "admin_post_view.jsp";
        
        redirectURL += "?num=" + cnum;
        // 지정된 URL로 리다이렉트
        response.sendRedirect(redirectURL);
	}

}
