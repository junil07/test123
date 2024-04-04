package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import project.PaypostCommentBean;
import project.PaypostCommentMgr;
import project.UtilMgr;

/**
 * Servlet implementation class PayPostReplyServlet
 */
@WebServlet("/project/PayPostReply")
public class PayPostReplyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PaypostCommentBean Cbean = new PaypostCommentBean();
		PaypostCommentMgr Cmgr = new PaypostCommentMgr();
		Cbean.setComment_paypost_num(UtilMgr.parseInt(request, "name"));
		Cbean.setPaypost_comment_content(request.getParameter("Ccontent"));
		Cbean.setPaypost_comment_reply_pos(UtilMgr.parseInt(request, "reply_pos"));
		Cbean.setPaypost_comment_reply_ref(UtilMgr.parseInt(request, "reply_ref"));
		Cbean.setPaypost_comment_reply_depth(UtilMgr.parseInt(request, "reply_depth"));
		Cbean.setPaypost_comment_user_id(request.getParameter("Cuser_id"));
		Cbean.setPaypost_comment_date(request.getParameter("Cdate"));
		
		Cmgr.replyUp(Cbean.getPaypost_comment_reply_ref(), Cbean.getPaypost_comment_reply_pos());
		Cmgr.insertComment(Cbean);
		
		/*String nowPage = request.getParameter("nowPage");
		String nowPerPage = request.getParameter("numPerPage");
		response.sendRedirect("");*/
	}

}
