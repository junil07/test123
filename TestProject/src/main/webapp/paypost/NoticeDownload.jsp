<%@page import="project.UtilMgr"%>
<%@page import="project.NoticeFileuploadBean"%>
<%@page import="project.NoticeMgr"%>
<%@page contentType="application; charset=UTF-8"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.File"%>
<%
		try{
			int num = UtilMgr.parseInt(request, "num");
		
			NoticeMgr mgr = new NoticeMgr();
			NoticeFileuploadBean fbean = mgr.getFile(num);
			String filename = fbean.getNotice_fileupload_server_name();
			String downfilename = fbean.getNotice_fileupload_name();
			downfilename += "." + fbean.getNotice_fileupload_extension();
			
			File file = new File(NoticeMgr.SAVEFOLDER+
					File.separator+filename);
			byte b[] = new byte[(int)file.length()];
			
			response.setHeader("Accept-Ranges", "bytes");
			String strClient = request.getHeader("User-Agent");
			if (strClient.indexOf("Trident") > 0 || strClient.indexOf("MSIE") > 0) {
				response.setContentType("application/smnet;charset=UTF-8");
				response.setHeader("Content-Disposition", "filename="
				+ new String(downfilename.getBytes("EUC-KR"),"8859_1") + ";");
			} else {
				response.setContentType("application/smnet;charset=UTF-8");
				response.setHeader("Content-Disposition",
						"attachment;filename=" 
				+ new String(downfilename.getBytes("UTF-8"),"ISO-8859-1") + ";");
			}
			out.clear();
			if (file.isFile()) {
				BufferedInputStream fin = new BufferedInputStream(
						new FileInputStream(file));
				BufferedOutputStream outs = new BufferedOutputStream(
						response.getOutputStream());
				int read = 0;
				while ((read = fin.read(b)) != -1) {
					outs.write(b, 0, read);
				}
				outs.close();
				fin.close();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
%>