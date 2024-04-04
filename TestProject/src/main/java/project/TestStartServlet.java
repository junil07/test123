package project;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/project/TestStart")
public class TestStartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		TestMgr mgr = new TestMgr();
		TestBean tBean = new TestBean();
		tBean.setTest_title(request.getParameter("title"));
		tBean.setTest_year(request.getParameter("year"));
		tBean.setTest_subnummber(Integer.parseInt(request.getParameter("sess")));
	}

}
