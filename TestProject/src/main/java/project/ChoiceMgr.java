package project;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class ChoiceMgr {
	
	private DBConnectionMgr pool;
	
	public ChoiceMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//문제 보기 리스트 
		public Vector<ChoiceBean> choiceBeans(){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<ChoiceBean> vlist = new Vector<ChoiceBean>();
			try {
				con = pool.getConnection();
				sql = "select * from choice";
				pstmt = con.prepareStatement(sql);
				
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					
					ChoiceBean bean = new ChoiceBean();
					bean.setChoice_num(rs.getInt("choice_num"));
					bean.setChoice_question_num(rs.getInt("choice_question_num"));
					bean.setChoice_number(rs.getInt("choice_number"));
					
					//bean.setChoice_content(rs.getString("choice_content"));
					
					String choiceContentString = rs.getString("choice_content");
					String[] Choice_content = choiceContentString.split(",");
					bean.setChoice_content(Choice_content);

					
					bean.setChoice_file(rs.getString("choice_file"));
					bean.setChoice_filesize(rs.getInt("choice_filesize"));
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		
		//보기 수정 Update
		public void updateChoice(String Choice_content[], int Choice_num[]) {
		    Connection con = null;
		    PreparedStatement pstmt = null;
		    String sql = null;
		    try {
		        con = pool.getConnection();
		        sql = "UPDATE choice SET CHOICE_CONTENT=? WHERE CHOICE_NUM=?";
		        pstmt = con.prepareStatement(sql);

		        for (int i = 0; i < Choice_content.length; i++) {
		            pstmt.setString(1, Choice_content[i]);
		            pstmt.setInt(2, Choice_num[i]);
		            pstmt.executeUpdate(); // 각 선택지에 대한 업데이트 실행
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        pool.freeConnection(con, pstmt);
		    }
		}


			
		// 문제 보기 insert
		public boolean insertChoice(ChoiceBean bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			
			try {
				con = pool.getConnection();
				sql = "insert choice(choice_question_num, choice_number, choice_content, choice_file, choice_filesize)"
		                + "values (?, ?, ?, ?, ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, bean.getChoice_question_num());
				//pstmt.setInt(2, bean.getChoice_number()); 
				String choice_content[] = bean.getChoice_content(); 
			    for (int i = 0; i < choice_content.length; i++) {
			    	if(choice_content[i]==null||choice_content[i].trim().length()==0) 
						break;
				pstmt.setInt(2, i+1); 
			    pstmt.setString(3, choice_content[i]);
			    pstmt.setString(4, bean.getChoice_file());
			    pstmt.setInt(5, bean.getChoice_filesize());
				if(pstmt.executeUpdate()==1)
					flag = true;
			    }
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
	
	public Vector<ChoiceBean> testChoice(int choice_question_num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ChoiceBean> vlist = new Vector<ChoiceBean>();
		try {
			con = pool.getConnection();
			sql = "select * from choice where choice_question_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,choice_question_num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ChoiceBean bean = new ChoiceBean();
				bean.setChoice_num(rs.getInt(1));
				bean.setChoice_question_num(rs.getInt(2));
				bean.setChoice_number(rs.getInt(3));
				String choiceCount[] = new String[1];
				choiceCount[0]= rs.getString(4);
				bean.setChoice_content(choiceCount);
				bean.setChoice_file(rs.getString(5));
				bean.setChoice_filesize(rs.getInt(6));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	public int choiceCount(int choice_question_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		try {
			con = pool.getConnection();
			sql = "select count(*) from choice where choice_question_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, choice_question_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
	}
}
