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


@WebServlet("/admin/deletecomment")
public class deletepostCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Board_commentBean cbean = new Board_commentBean();
		Board_commentMgr cmgr = new Board_commentMgr();
		String Dpos = request.getParameter("Dpos");
		String Dref = request.getParameter("Dref");
		String Ddepth = request.getParameter("Ddepth");
		int Dnum = UtilMgr.parseInt(request, "Dnum");
		
		cmgr.deleteComment(Dpos, Dref, Ddepth);
		String redirectURL = "admin_post_view.jsp";
		redirectURL += "?num=" + Dnum;
        //지정된 URL로 리다이렉트
        response.sendRedirect(redirectURL);
	}

}
