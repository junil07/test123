package paypost;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import project.NoticeMgr;
import project.PaypostMgr;
import project.UtilMgr;

@WebServlet("/paypost/paypostPost")
public class PaypostPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PaypostMgr mgr = new PaypostMgr();
		mgr.insertPaypost(request);
		response.sendRedirect("Paypost.jsp");
	}

}
