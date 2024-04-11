package paypost;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import project.PaypostBean;
import project.PaypostMgr;

@WebServlet("/paypost/paypostUpdate")
public class PaypostUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
	      PaypostBean bean = (PaypostBean) session.getAttribute("bean");
	      MultipartRequest multi = new MultipartRequest(request,
	            PaypostMgr.SAVEFOLDER,
	            PaypostMgr.MAXSIZE,
	            PaypostMgr.ENCODING,
	            new DefaultFileRenamePolicy());
	      PaypostMgr mgr = new PaypostMgr();
	         mgr.updatePaypost(multi);
	         String nowPage = multi.getParameter("nowPage");
	         String numPerPage = multi.getParameter("numPerPage");
	         response.sendRedirect("Paypost.jsp?nowPage="+nowPage
	               +"&numPerPage="+numPerPage
	               +"&num="+bean.getPaypost_num());
	}

}
