package paypost;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import project.PaypostBean;
import project.PaypostMgr;


@WebServlet("/paypost/paypostDelete")
public class PaypostDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
	    PaypostBean bean = (PaypostBean)session.getAttribute("bean");
		PaypostMgr mgr = new PaypostMgr();
        mgr.deletePaypost(bean.getPaypost_num());
        String nowPage = request.getParameter("nowPage");
        String numPerPage = request.getParameter("numPerPage");
        String keyField = request.getParameter("keyField");
        String keyWord = request.getParameter("keyWord");
        String url = "Paypost.jsp?nowPage=" + nowPage;
        url +="&numPerPage=" +numPerPage;
        if(!(keyWord==null||keyWord.equals(""))) {
           url+="&keyField="+keyField;
           url+="&keyWord="+keyWord;
          
        }
        response.sendRedirect(url);
	}

}
