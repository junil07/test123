package project;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class PaypostMgr {
   
   DBConnectionMgr pool;
   
   //업로드 파일 저장 위치
   public static final String SAVEFOLDER = "C:\\Jsp\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\TestProject\\";
   //업로드 파일 인코딩
   public static final String ENCODING = "UTF-8";
   //업로드 파일 크기
   public static final int MAXSIZE = 1024*1024*30; //30mb
   
   public PaypostMgr() {
      pool = DBConnectionMgr.getInstance();
   }
   
   //paypost 유료글 리스트 출력(번호, 아이디, 제목, 가격, 날짜) - 유료글 게시판에서 전체적인 출력(paypost_agree가 2인것만출력으로 변경)
   public Vector<PaypostBean> allPaypost(String keyField,String keyWord, int start, int cnt){
       Connection con = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       String sql = null;
       Vector<PaypostBean> vlist = new Vector<PaypostBean>();
       try {
           con = pool.getConnection();
           if(keyWord.trim().equals("") || keyWord == null) {
               sql = "SELECT paypost_num, paypost_user_id, paypost_title, paypost_pay, paypost_date FROM paypost ORDER BY paypost_num DESC LIMIT ?, ?";
               //sql = "SELECT paypost_num, paypost_user_id, paypost_title, paypost_pay, paypost_date FROM paypost where PAYPOST_AGREE <= 1 ORDER BY paypost_num DESC LIMIT ?, ?";
               pstmt = con.prepareStatement(sql);
               pstmt.setInt(1, start);
               pstmt.setInt(2, cnt);
               rs = pstmt.executeQuery();
              while(rs.next()) {
                  PaypostBean pbean = new PaypostBean();
                  pbean.setPaypost_num(rs.getInt(1));
                  pbean.setPaypost_user_id(rs.getString(2));
                  pbean.setPaypost_title(rs.getString(3));
                   pbean.setPaypost_pay(rs.getInt(4));
                  pbean.setPaypost_date(rs.getString(5));
                  vlist.addElement(pbean);
              }
           } else {
               sql = "SELECT p.paypost_num, p.paypost_user_id, u.user_name, p.paypost_title, p.paypost_pay, p.paypost_date FROM paypost p JOIN user u ON p.paypost_user_id = u.user_id WHERE " + keyField + " LIKE ? ORDER BY paypost_num DESC LIMIT ?, ?";
               //sql = "SELECT p.paypost_num, p.paypost_user_id, u.user_name, p.paypost_title, p.paypost_pay, p.paypost_date FROM paypost p JOIN user u ON p.paypost_user_id = u.user_id WHERE " + keyField + " LIKE ? and p.PAYPOST_AGREEORDER <= 1 BY paypost_num DESC LIMIT ?, ?";
               pstmt = con.prepareStatement(sql);
               pstmt.setString(1, "%" + keyWord + "%");
               pstmt.setInt(2, start);
               pstmt.setInt(3, cnt);
               rs = pstmt.executeQuery();
              while(rs.next()) {
                  PaypostBean pbean = new PaypostBean();
                  UserBean ubean = new UserBean();
                  pbean.setPaypost_num(rs.getInt(1));
                  pbean.setPaypost_user_id(rs.getString(2));
                  ubean.setUser_name(rs.getString(3));
                  pbean.setPaypost_title(rs.getString(4));
                   pbean.setPaypost_pay(rs.getInt(5));
                  pbean.setPaypost_date(rs.getString(6));
                  vlist.addElement(pbean);
              }
           }
       } catch (Exception e) {
           e.printStackTrace();
       } finally {
           pool.freeConnection(con, pstmt, rs);
       }
       return vlist;
   }
   String i = "";
   //paypost_agree 유료글 승인 게시판 리스트 출력(전체적으로 출력, 승인완료라도 추후 거절로 변경할수 있도록)
   public Vector<PaypostBean> agreePaypost(String keyField, String keyWord, int start, int cnt){
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String sql = null;
      Vector<PaypostBean> vlist = new Vector<PaypostBean>();
      try {
         con = pool.getConnection();
         if(keyWord.trim().equals("") || keyWord == null) {
               sql = "SELECT paypost_num, paypost_user_id, paypost_title, paypost_pay, paypost_date, PAYPOST_AGREE FROM paypost ORDER BY paypost_num DESC LIMIT ?, ?";
               pstmt = con.prepareStatement(sql);
               pstmt.setInt(1, start);
               pstmt.setInt(2, cnt);
               rs = pstmt.executeQuery();
              while(rs.next()) {
                  PaypostBean pbean = new PaypostBean();
                  pbean.setPaypost_num(rs.getInt(1));
                  pbean.setPaypost_user_id(rs.getString(2));
                  pbean.setPaypost_title(rs.getString(3));
                   pbean.setPaypost_pay(rs.getInt(4));
                  pbean.setPaypost_date(rs.getString(5));
                  pbean.setPaypost_agree(rs.getInt(6));
                  vlist.addElement(pbean);
              }
           } else {
               sql = "SELECT p.paypost_num, p.paypost_user_id, u.user_name, p.paypost_title, p.paypost_pay, p.paypost_date, p.paypost_agree FROM paypost p JOIN user u ON p.paypost_user_id = u.user_id WHERE " + keyField + " LIKE ? ORDER BY paypost_num DESC LIMIT ?, ?";
               pstmt = con.prepareStatement(sql);
               pstmt.setString(1, "%" + keyWord + "%");
               pstmt.setInt(2, start);
               pstmt.setInt(3, cnt);
               rs = pstmt.executeQuery();
              while(rs.next()) {
                  PaypostBean pbean = new PaypostBean();
                  UserBean ubean = new UserBean();
                  pbean.setPaypost_num(rs.getInt(1));
                  pbean.setPaypost_user_id(rs.getString(2));
                  ubean.setUser_name(rs.getString(3));
                  pbean.setPaypost_title(rs.getString(4));
                   pbean.setPaypost_pay(rs.getInt(5));
                  pbean.setPaypost_date(rs.getString(6));
                  pbean.setPaypost_agree(rs.getInt(7));
                  vlist.addElement(pbean);
              }
           }
       } catch (Exception e) {
           e.printStackTrace();
       } finally {
           pool.freeConnection(con, pstmt, rs);
       }
       return vlist;
   }
   
   
   
   
   //유로글 리스트에서 뽑은 아이디를 통해 user테이블에서 이름
   public String getUserName(String userId) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String userName = null;
        try {
            con = pool.getConnection();
            String sql = "SELECT user_name FROM user WHERE user_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                userName = rs.getString("user_name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            pool.freeConnection(con, pstmt, rs);
        }
        return userName;
    }
   
   //user테이블에서 등급 출력
   public int getUserGrade(String userId) {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      int userGrade = 0;
      try {
         con = pool.getConnection();
         String sql = "select user_grade from user where user_id = ?";
         pstmt = con.prepareStatement(sql);
         pstmt.setString(1, userId);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            userGrade = rs.getInt("user_grade");
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt, rs);
      }
      return userGrade;
   }
   
   //전체적인 유로글 갯수확인 추후 paypost_agree가 2인것만 count하게 변경
   public int getTotalCount(String keyField, String keyWord) {
       Connection con = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       String sql = null;
       int totalCount = 0;
       try {
           con = pool.getConnection();
           if(keyWord.trim().equals("") || keyWord == null) {
               sql = "SELECT COUNT(*) FROM paypost";
               pstmt = con.prepareStatement(sql);
           } else {
               sql = "SELECT COUNT(*) FROM paypost p JOIN user u ON p.paypost_user_id = u.user_id WHERE " + keyField + " LIKE ?";
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
   
   //전체적인 유로글 갯수확인 추후 paypost_agree가 2인것만 count하게 변경
      public int getagree2Count(String keyField, String keyWord) {
          Connection con = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;
          String sql = null;
          int totalCount = 0;
          try {
              con = pool.getConnection();
              if(keyWord.trim().equals("") || keyWord == null) {
                  sql = "SELECT COUNT(*) FROM paypost where PAYPOST_AGREE <= 1";
                  pstmt = con.prepareStatement(sql);
              } else {
                  sql = "SELECT COUNT(*) FROM paypost p JOIN user u ON p.paypost_user_id = u.user_id WHERE " + keyField + " LIKE ?";
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

   
   //listview에서 필요로한 모든 값 리턴
   public PaypostBean getlist(int paypost_num) {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String sql = null;
      PaypostBean pbean = new PaypostBean();
      try {
         con = pool.getConnection();
         sql = "select * from paypost where paypost_num = ?";
         pstmt = con.prepareStatement(sql);
         pstmt.setInt(1, paypost_num);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            pbean.setPaypost_num(rs.getInt("paypost_num"));
            pbean.setPaypost_user_id(rs.getString("paypost_user_id"));
            pbean.setPaypost_title(rs.getString("paypost_title"));
            pbean.setPaypost_content(rs.getString("paypost_content"));
            pbean.setPaypost_pay(rs.getInt("paypost_pay"));
            pbean.setPaypost_agree(rs.getInt("paypost_agree"));
            pbean.setPaypost_date(rs.getString("paypost_date"));
            pbean.setPaypost_good(rs.getInt("paypost_good"));
            pbean.setPaypost_reason(rs.getString("paypost_reason"));   
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt, rs);
      }
      return pbean;
   }
   
   //유료글 좋아요(good) 출력
   public int getpaypostlike(int list_num) {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String sql = null;
      int paypost_good = 0;
      try {
         con = pool.getConnection();
         sql = "select paypost_good from paypost where paypost_num = ?";
         pstmt = con.prepareStatement(sql);
         pstmt.setInt(1, list_num);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            paypost_good = rs.getInt("paypost_good");
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt, rs);
      }
      return paypost_good;
   }
   
   //유료글 거절 사유 찾기
   public String getpaypostReason(int num) {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String sql = null;
      String reason = null;
      try {
         con = pool.getConnection();
         sql = "select paypost_reason from paypost where PAYPOST_NUM = ?";
         pstmt = con.prepareStatement(sql);
         pstmt.setInt(1, num);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            reason = rs.getString("paypost_reason");
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt, rs);
      }
      return reason;
   }
   
   // 유료 게시물의 거절 사유 변경 및 agree 값 1로 바꾸기(1 = 거절)
   public void updatepaypostReason(String reason, int num) {
       Connection con = null;
       PreparedStatement pstmt = null;
       String sql = null;
       try {
           con = pool.getConnection();
           sql = "UPDATE paypost SET PAYPOST_REASON = ?, PAYPOST_AGREE = 1 WHERE paypost_num = ?";
           pstmt = con.prepareStatement(sql);
           pstmt.setString(1, reason);
           pstmt.setInt(2, num);
           pstmt.executeUpdate();
       } catch (Exception e) {
           e.printStackTrace();
       } finally {
           pool.freeConnection(con, pstmt);
       }
   }
   
   //유료 게시글 승인
   public void updateagree(String text, int num) {
      Connection con = null;
      PreparedStatement pstmt = null;
      String sql = null;
      
      try {
         con = pool.getConnection();
         sql = "UPDATE paypost SET PAYPOST_REASON = ?, PAYPOST_AGREE = 2 WHERE paypost_num = ?";
         pstmt = con.prepareStatement(sql);
         pstmt.setString(1, text);
         pstmt.setInt(2, num);
         pstmt.executeUpdate();
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt);
      }
   }
  
  // 포인트 이용내역 - 이용한 게시글 제목 추출
	public String showPaypostTitle(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String paypostTitle = "";
		try {
			con = pool.getConnection();
			sql = "SELECT paypost_title FROM paypost WHERE PAYPOST_NUM = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while ( rs.next() ) {
				paypostTitle = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return paypostTitle;
	}
	
	//게시물의 파일 가져오기
	   public Paypost_fileuploadBean getFile(int num) {
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String sql = null;
	      Paypost_fileuploadBean bean = new Paypost_fileuploadBean();
	      try {
	         con = pool.getConnection();
	         sql = "select * from paypost_fileupload where fileupload_paypost_num=?";
	         pstmt = con.prepareStatement(sql);
	         pstmt.setInt(1, num);
	         rs = pstmt.executeQuery();
	         if(rs.next()) {
	            bean.setPaypost_fileupload_server_name(rs.getString("paypost_fileupload_server_name"));
	            bean.setFileupload_paypost_num(rs.getInt("fileupload_paypost_num"));
	            bean.setPaypost_fileupload_name(rs.getString("paypost_fileupload_name"));
	            bean.setPaypost_fileupload_extension(rs.getString("paypost_fileupload_extension"));
	            bean.setPaypost_fileupload_size(rs.getInt("paypost_fileupload_size"));
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         pool.freeConnection(con, pstmt, rs);
	      }
	      return bean;
	   }
	   
	   //좋아요 증가
	   public void goodUp(int num, String buyer) {
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      String sql = null;
	      try {
	         con = pool.getConnection();
	         sql = "update paypost set paypost_good=paypost_good+1 where paypost_num=?";
	         pstmt = con.prepareStatement(sql);
	         pstmt.setInt(1, num);
	         if(pstmt.executeUpdate()==1) {
	        	 pstmt.close();
	        	 sql = "insert paypost_likey(likey_paypost_num, paypost_likey_user_id) "
	                     + "values(?, ?)";
	        	 pstmt = con.prepareStatement(sql);
	        	 pstmt.setInt(1, num);
	        	 pstmt.setString(2, buyer);
	        	 pstmt.executeUpdate();
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         pool.freeConnection(con, pstmt);
	      }
	      return;
	   }
	   
	   
	   //좋아요 중복 체크
	   public boolean goodCheck(String user, int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select paypost_likey_user_id from paypost_likey where likey_paypost_num=? and paypost_likey_user_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, user);
			rs = pstmt.executeQuery();
			if(rs.next()) flag = true;

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	   }
	   
	   
	   
	   
	 //유료글 insert
	   public void insertPaypost(HttpServletRequest req) {
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
	         sql = "insert paypost(paypost_user_id, paypost_title, paypost_content, paypost_pay, paypost_agree, paypost_date, paypost_good, paypost_reason) "
	               + "values(?, ?, ?, now(), 0)";
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
	     
	   }
	   
	 //Max Num : num의 현재 최대값
	   public int getMaxNum() {
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String sql = null;
	      int maxNum = 0;
	      try {
	         con = pool.getConnection();
	         sql = "select max(paypost_num) from paypost";
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
	   
	   
	   //유료게시글 삭제 
	   //Board Delete : 첨부된 파일 삭제
	   public void deletePaypost(int num) {
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      String sql = null;
	      try {
	         Paypost_fileuploadBean fbean = getFile(num);
	         String filename = fbean.getPaypost_fileupload_server_name();
	         if(filename!=null&&!filename.equals("")) {
	            File f = new File(SAVEFOLDER+filename);
	            if(f.exists()) {
	               UtilMgr.delete(SAVEFOLDER+filename);
	            }
	         }
	         
	         con = pool.getConnection();
	         
	         sql = "delete from paypost_fileupload where fileupload_paypost_num=?";
	         pstmt = con.prepareStatement(sql);
	         pstmt.setInt(1, num);
	         pstmt.executeUpdate();
	         pstmt.close();
	         
	         sql = "delete from paypost where paypost_num=?";
	         pstmt = con.prepareStatement(sql);
	         pstmt.setInt(1, num);
	         pstmt.executeUpdate();
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         pool.freeConnection(con, pstmt);
	      }
	   }   
	   
	   
	 //paypost Update : 파일업로드 수정
	   public void updatePaypost(MultipartRequest multi) {
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
	            Paypost_fileuploadBean fbean = getFile(num);
	            String tempfile = fbean.getPaypost_fileupload_server_name();
	            if(tempfile!=null&&!tempfile.equals("")) {
	               File f = new File(SAVEFOLDER+tempfile);
	               if(f.exists()) {
	                  UtilMgr.delete(SAVEFOLDER+tempfile);
	               }
	               
	               sql = "delete from paypost_fileupload where fileupload_paypost_num=?";
	               pstmt = con.prepareStatement(sql);
	               pstmt.setInt(1, num);
	               pstmt.executeUpdate();
	               pstmt.close();
	            }
	            
	            filename = UtilMgr.fileName(filefullname);
	            newfilename = UtilMgr.randomName(filefullname);
	            fileextension = UtilMgr.fileExtension(filefullname);
	            filesize = (int)multi.getFile("filename").length();
	            
	            sql = "insert paypost_fileupload(paypost_fileupload_server_name, fileupload_paypost_num, paypost_fileupload_name, "
	                  + "paypost_fileupload_extension, paypost_fileupload_size)"
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
	         
	         sql = "update paypost set paypost_title=?, paypost_content=?, paypost_agree=? where paypost_num=?";
	           pstmt = con.prepareStatement(sql);
	           pstmt.setString(1, title);
	           pstmt.setString(2, content);
	           pstmt.setInt(3, 0);
	           pstmt.setInt(4, num);
	         pstmt.executeUpdate();
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         pool.freeConnection(con, pstmt);
	      }
	      return;
	   }
	   
	   
  
}