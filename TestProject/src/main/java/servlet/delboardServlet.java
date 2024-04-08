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

@WebServlet("/admin/delboard")
public class delboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardBean bean = new BoardBean();
		BoardMgr mgr = new BoardMgr();
		int num = UtilMgr.parseInt(request, "num");
		

		mgr.deleteboard(num);
		String redirectURL = "admin_post_list.jsp";
        //지정된 URL로 리다이렉트
        response.sendRedirect(redirectURL);
	}

}
