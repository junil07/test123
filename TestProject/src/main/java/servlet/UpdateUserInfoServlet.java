package servlet;

import java.io.IOException;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.eclipse.jdt.internal.compiler.ast.RequiresStatement;

import project.UserMgr;


@WebServlet("/admin/updateUserInfo")
public class UpdateUserInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserMgr Umgr = new UserMgr();
		String user_id = request.getParameter("user_id");
		String user_email = request.getParameter("user_email");
		String user_phone = request.getParameter("user_phone");
		String user_grade = request.getParameter("user_grade");

		// 값이 null인지 확인 후 배열로 변환
		String[] user_ids = user_id != null ? user_id.split(",") : new String[0];
		String[] user_emails = user_email != null ? user_email.split(",") : new String[0];
		String[] user_phones = user_phone != null ? user_phone.split(",") : new String[0];
		String[] user_grades = user_grade != null ? user_grade.split(",") : new String[0];

		for(int i = 0; i<user_ids.length; i++) {
			System.out.println(user_ids[i]);
		}
		
		Umgr.updateuser(user_ids, user_emails, user_phones, user_grades);
		String redirectURL = "admin_userInfo.jsp";
		response.sendRedirect(redirectURL);
	}

}
