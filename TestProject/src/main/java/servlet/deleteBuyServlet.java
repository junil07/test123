package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import project.BuyListMgr;

@WebServlet("/admin/delBuyList")
public class deleteBuyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BuyListMgr blmgr = new BuyListMgr();
		String blnum = request.getParameter("blnum");
		
		String[] blnums = blnum != null ? blnum.split(",") : new String[0];
		for(int i = 0; i<blnums.length; i++) {
			System.out.println(blnums[i]);
		}
		blmgr.deleteBuylist(blnums);
		String redirectURL = "admin_buylist.jsp";
		response.sendRedirect(redirectURL);
	}
}
