package notice;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import project.NoticeBean;
import project.NoticeMgr;


@WebServlet("/notice/noticeDelete")
public class NoticeDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
	    NoticeBean bean = (NoticeBean)session.getAttribute("bean");
		NoticeMgr mgr = new NoticeMgr();
        mgr.deleteNotice(bean.getNotice_num());
        String nowPage = request.getParameter("nowPage");
        String numPerPage = request.getParameter("numPerPage");
        String keyField = request.getParameter("keyField");
        String keyWord = request.getParameter("keyWord");
        String url = "Notice.jsp?nowPage=" + nowPage;
        url +="&numPerPage=" +numPerPage;
        if(!(keyWord==null||keyWord.equals(""))) {
           url+="&keyField="+keyField;
           url+="&keyWord="+keyWord;
          
        }
        response.sendRedirect(url);
	}

}
