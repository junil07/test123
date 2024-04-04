package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import project.PaypostMgr;
import project.UtilMgr;


@WebServlet("/admin/refuseReason")
public class refuseReasonServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//거절사유 업데이트 서블릿
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PaypostMgr Mgr = new PaypostMgr();
		String reason = request.getParameter("reason");
		int num = UtilMgr.parseInt(request, "num");
		
		//System.out.println("reason:" + reason);
		//System.out.println("num:" + num);
		
		Mgr.updatepaypostReason(reason, num);
		String redirectURL = "paypost_agreeview.jsp";
		redirectURL += "?num=" + num;
		response.sendRedirect(redirectURL);
	}

}
