package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import project.UserMgr;


@WebServlet("/admin/deleteuserInfo")
public class deleteUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserMgr Umgr = new UserMgr();
		String tuser_id = request.getParameter("tuser_id");
		// 값이 null인지 확인 후 배열로 변환
		String[] tuser_ids = tuser_id != null ? tuser_id.split(",") : new String[0];
		for(int i = 0; i<tuser_ids.length; i++) {
			System.out.println(tuser_ids[i]);
		}
		Umgr.deleteUsers(tuser_ids);
		String redirectURL = "admin_userInfo.jsp";
		response.sendRedirect(redirectURL);
	}
	
	

}
