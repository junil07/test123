package project;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class NoticeMgr {
   private DBConnectionMgr pool;
   
   //업로드 파일 저장 위치
   public static final String SAVEFOLDER = "C:\\Jsp\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\TestProject\\";
   //업로드 파일 인코딩
   public static final String ENCODING = "UTF-8";
   //업로드 파일 크기
   public static final int MAXSIZE = 1024*1024*30; //30mb
   
   public NoticeMgr() {
      pool = DBConnectionMgr.getInstance();
   }
   
   
   //Board Insert
   public void insertNotice(HttpServletRequest req) {
      Connection con = null;
      PreparedStatement pstmt = null;
      String sql = null;
      
      try {
         
         File dir = new File(SAVEFOLDER);
         if(!dir.exists())//존재하지 않는다면
            dir.mkdirs();//상위폴더가 없어도 생성
         //mkdir : 상위폴더가 없으면 생성불가
         MultipartRequest multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCODING, new DefaultFileRenamePolicy());
         String filefullname = null, filename = null, newfilename = null, fileextension = null;
         int filesize = 0;
         if(multi.getFilesystemName("filename")!=null) {
            filefullname = multi.getFilesystemName("filename");
            filename = UtilMgr.fileName(filefullname);
            newfilename = UtilMgr.randomName(filefullname);
            fileextension = UtilMgr.fileExtension(filefullname);
            filesize = (int)multi.getFile("filename").length();
         }
         
         String content = multi.getParameter("content"); //게시물 내용
         con = pool.getConnection();
         sql = "insert notice(notice_title, notice_content, notice_date, notice_count)"
               + "values(?, ?, now(), 0)";
         pstmt = con.prepareStatement(sql);
         pstmt.setString(1, multi.getParameter("title"));
         pstmt.setString(2, multi.getParameter("content"));
         pstmt.executeUpdate();
         pstmt.close();
         if(filename!=null&&!filename.equals("")) {
            sql = "insert notice_fileupload(notice_fileupload_server_name, fileupload_notice_num, notice_fileupload_name, "
                  + "notice_fileupload_extension, notice_fileupload_size)"
                  + "values(?, ?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, newfilename);
            pstmt.setInt(2, getMaxNum());
            pstmt.setString(3, filename);
            pstmt.setString(4, fileextension);
            pstmt.setInt(5, filesize);
            pstmt.executeUpdate();
         }
         
         //파일 이름 변경
         UtilMgr.fileRename(SAVEFOLDER, filefullname, newfilename);
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt);
      }
      
      /*
      try {
         MultipartRequest multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCODING, new DefaultFileRenamePolicy());
         con = pool.getConnection();
         sql = "insert notice(notice_title, notice_content, notice_date, notice_count)"
               + "values(?, ?, now(), 0)";
         pstmt = con.prepareStatement(sql);
         pstmt.setString(1, multi.getParameter("title"));
         pstmt.setString(2, multi.getParameter("content"));
         pstmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt);
      }
      return;
      */
   }
   
   //Board Max Num : num의 현재 최대값
   public int getMaxNum() {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String sql = null;
      int maxNum = 0;
      try {
         con = pool.getConnection();
         sql = "select max(notice_num) from notice";
         pstmt = con.prepareStatement(sql);
         rs = pstmt.executeQuery();
         if(rs.next()) maxNum = rs.getInt(1);
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt, rs);
      }
      return maxNum;
   }
   
   //총게시물수
   public int getTotalCount(String keyField, String keyWord) {
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String sql = null;
	      int totalCount = 0;
	      try {
	         con = pool.getConnection();
	         if(keyWord.trim().equals("")||keyWord==null) {
	         //검색이 아닌 경우
	            sql = "select count(*) from notice";
	            pstmt = con.prepareStatement(sql);
	         }else {
	            sql = "select count(*) from notice where " + keyField + " like ?";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, "%" + keyWord + "%");
	         }
	         rs = pstmt.executeQuery();
	         if(rs.next()) totalCount = rs.getInt(1);
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         pool.freeConnection(con, pstmt, rs);
	      }
	      return totalCount;
	   }
   
   //Board List : 검색기능, 페이징 및 블럭
   public Vector<NoticeBean> getNoticeList(String keyField, String keyWord, int start, int cnt) {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String sql = null;
      Vector<NoticeBean> vlist = new Vector<NoticeBean>();
      try {
         con = pool.getConnection();
         if(keyWord.trim().equals("")||keyWord==null) {
         //검색이 아닌 경우
            sql = "select * from notice "
                  + "order by notice_num desc limit ?, ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, start);
               pstmt.setInt(2, cnt);

         }else {
            sql = "select * from notice where " + keyField + " like ? "
                  + "order by notice_num desc limit ?, ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, "%" + keyWord + "%");
            pstmt.setInt(2, start);
               pstmt.setInt(3, cnt);

         }
         rs = pstmt.executeQuery();
         while(rs.next()) {
            NoticeBean bean = new NoticeBean();
            bean.setNotice_num(rs.getInt("notice_num"));
            bean.setNotice_title(rs.getString("notice_title"));
            bean.setNotice_content(rs.getString("notice_content"));
            bean.setNotice_date(rs.getString("notice_date"));
            bean.setNotice_count(rs.getInt("notice_count"));
            vlist.addElement(bean);
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt, rs);
      }
      return vlist;
   }
   
   //게시물 하나 불러오기
   public NoticeBean getNotice(int num) {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String sql = null;
      NoticeBean bean = new NoticeBean();
      try {
         con = pool.getConnection();
         sql = "select * from notice where notice_num=?";
         pstmt = con.prepareStatement(sql);
         pstmt.setInt(1, num);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            bean.setNotice_num(rs.getInt("notice_num"));
            bean.setNotice_title(rs.getString("notice_title"));
            bean.setNotice_content(rs.getString("notice_content"));
            bean.setNotice_date(rs.getString("notice_date"));
            bean.setNotice_count(rs.getInt("notice_count"));
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt, rs);
      }
      return bean;
   }
   
   //게시물의 파일 가져오기
   public NoticeFileuploadBean getFile(int num) {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String sql = null;
      NoticeFileuploadBean bean = new NoticeFileuploadBean();
      try {
         con = pool.getConnection();
         sql = "select * from notice_fileupload where fileupload_notice_num=?";
         pstmt = con.prepareStatement(sql);
         pstmt.setInt(1, num);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            bean.setNotice_fileupload_server_name(rs.getString("notice_fileupload_server_name"));
            bean.setFileupload_notice_num(rs.getInt("fileupload_notice_num"));
            bean.setNotice_fileupload_name(rs.getString("notice_fileupload_name"));
            bean.setNotice_fileupload_extension(rs.getString("notice_fileupload_extension"));
            bean.setNotice_fileupload_size(rs.getInt("notice_fileupload_size"));
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt, rs);
      }
      return bean;
   }
   
   //Count Up : 조회수 증가
   public void upCount(int num) {
      Connection con = null;
      PreparedStatement pstmt = null;
      String sql = null;
      try {
         con = pool.getConnection();
         sql = "update notice set notice_count=notice_count+1 where notice_num=?";
         pstmt = con.prepareStatement(sql);
         pstmt.setInt(1, num);
         pstmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt);
      }
      return;
   }
   
   //Board Delete : 첨부된 파일 삭제
   public void deleteNotice(int num) {
      Connection con = null;
      PreparedStatement pstmt = null;
      String sql = null;
      try {
         NoticeFileuploadBean fbean = getFile(num);
         String filename = fbean.getNotice_fileupload_server_name();
         if(filename!=null&&!filename.equals("")) {
            
            File f = new File(SAVEFOLDER+filename);
            if(f.exists()) {
               UtilMgr.delete(SAVEFOLDER+filename);
            }
         }
         
         con = pool.getConnection();
         
         sql = "delete from notice_fileupload where fileupload_notice_num=?";
         pstmt = con.prepareStatement(sql);
         pstmt.setInt(1, num);
         pstmt.executeUpdate();
         pstmt.close();
         
         sql = "delete from notice where notice_num=?";
         pstmt = con.prepareStatement(sql);
         pstmt.setInt(1, num);
         pstmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt);
      }
   }   
   
   
   
   //Board Update : 파일업로드 수정
   public void updateNotice(MultipartRequest multi) {
      Connection con = null;
      PreparedStatement pstmt = null;
      String sql = null;
      String filefullname = null, filename = null, newfilename = null, fileextension = null;
      int filesize = 0;
      
      try {
         con = pool.getConnection();
         int num = Integer.parseInt(multi.getParameter("num"));
         String title = multi.getParameter("title");
         String content = multi.getParameter("content");
         filefullname = multi.getFilesystemName("filename");
         
         if(filefullname!=null&&!filefullname.equals("")) {
            //파일업로드도 수정 : 기존의 파일 삭제
            NoticeFileuploadBean fbean = getFile(num);
            String tempfile = fbean.getNotice_fileupload_server_name();
            if(tempfile!=null&&!tempfile.equals("")) {
               File f = new File(SAVEFOLDER+tempfile);
               if(f.exists()) {
                  UtilMgr.delete(SAVEFOLDER+tempfile);
               }
               
               sql = "delete from notice_fileupload where fileupload_notice_num=?";
               pstmt = con.prepareStatement(sql);
               pstmt.setInt(1, num);
               pstmt.executeUpdate();
               pstmt.close();
            }
            
            filename = UtilMgr.fileName(filefullname);
            newfilename = UtilMgr.randomName(filefullname);
            fileextension = UtilMgr.fileExtension(filefullname);
            filesize = (int)multi.getFile("filename").length();
            
            sql = "insert notice_fileupload(notice_fileupload_server_name, fileupload_notice_num, notice_fileupload_name, "
                  + "notice_fileupload_extension, notice_fileupload_size)"
                  + "values(?, ?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, newfilename);
            pstmt.setInt(2, getMaxNum());
            pstmt.setString(3, filename);
            pstmt.setString(4, fileextension);
            pstmt.setInt(5, filesize);
            pstmt.executeUpdate();
            pstmt.close();
            
            UtilMgr.fileRename(SAVEFOLDER, filefullname, newfilename);
         }
         
         sql = "update notice set notice_title=?, notice_content=? where notice_num=?";
           pstmt = con.prepareStatement(sql);
           pstmt.setString(1, title);
           pstmt.setString(2, content);
           pstmt.setInt(3, num);
         pstmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt);
      }
      return;
   }

}