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

import project.NoticeBean;
import project.NoticeMgr;

@WebServlet("/notice/noticeUpdate")
public class PaypostUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
	      NoticeBean bean = (NoticeBean) session.getAttribute("bean");
	      MultipartRequest multi = new MultipartRequest(request,
	            NoticeMgr.SAVEFOLDER,
	            NoticeMgr.MAXSIZE,
	            NoticeMgr.ENCODING,
	            new DefaultFileRenamePolicy());
	      NoticeMgr mgr = new NoticeMgr();
	         mgr.updateNotice(multi);
	         String nowPage = multi.getParameter("nowPage");
	         String numPerPage = multi.getParameter("numPerPage");
	         response.sendRedirect("Notice.jsp?nowPage="+nowPage
	               +"&numPerPage="+numPerPage
	               +"&num="+bean.getNotice_num());
	}

}
