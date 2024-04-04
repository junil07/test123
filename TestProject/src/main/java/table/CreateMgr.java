package table;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import com.mysql.cj.x.protobuf.MysqlxCrud.Collection;

import project.DBConnectionMgr;

public class CreateMgr {
	private DBConnectionMgr pool;
	
	public CreateMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//게시판 테이블 생성
	public void createTable(String op[], String INSERTNAME) {
		List<String> opList = new ArrayList<>();
		if(op[0]!=null&&!op[0].equals("")) {
			opList = Arrays.asList(op);
		}
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			
			//기본 테이블
			sql = "CREATE TABLE PROJECT." + INSERTNAME + "(\n"
					+ INSERTNAME + "_NUM INT NOT NULL AUTO_INCREMENT,\n"
					+ INSERTNAME + "_TITLE VARCHAR(50) NOT NULL,\n"
					+ INSERTNAME + "_CONTENT VARCHAR(1000) NOT NULL,\n"
					+ INSERTNAME + "_DATE DATE NOT NULL,\n"
					+ INSERTNAME + "_COUNT INT(10) DEFAULT 0";
			
			//컬럼 추가
			//유저 아이디
			if(opList.contains("col_user") || opList.contains("col_pay")) {
				sql += ",\n"
					+ INSERTNAME + "_USER_ID VARCHAR(20) NOT NULL";
				
				//유료글
				if(opList.contains("col_pay")) {
					sql += ",\n"
						+ INSERTNAME + "_TEST_NUM VARCHAR(20) NOT NULL,\n"
						+ INSERTNAME + "_PAY INT NOT NULL,\n"
						+ INSERTNAME + "_AGREE SMALLINT(2) NOT NULL DEFAULT 0,\n"
						+ INSERTNAME + "_REASON VARCHAR(100)";
				}
			}
			
			//추천수
			if(opList.contains("likey")) {
				sql += ",\n"
						+ INSERTNAME + "_GOOD INT(10) DEFAULT 0";
			}
			
			//PK
			sql += ",\n"
				+ "PRIMARY KEY (" + INSERTNAME + "_NUM)";
			
			//FK 부분
			//유저 아이디
			if(opList.contains("col_user") || opList.contains("col_pay")) {
				sql += ",\n"
					+ "FOREIGN KEY (" + INSERTNAME + "_USER_ID) REFERENCES USER (USER_ID)";
				
				//유료글
				if(opList.contains("col_pay")) {
					sql += ",\n"
						+ "FOREIGN KEY (" + INSERTNAME + "_TEST_NUM) REFERENCES TEST (TEST_NUM)";
				}
			}
			
			//마무리
			sql += "\n"
				+ ");";
			
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
			pstmt.close();
			
			//댓글 테이블 생성
			if(opList.contains("comment")) {
				sql = "CREATE TABLE PROJECT." + INSERTNAME + "_COMMENT (\n"
						+ INSERTNAME + "_COMMENT_NUM INT NOT NULL AUTO_INCREMENT,\n"
						+ "COMMENT_" + INSERTNAME + "_NUM INT NOT NULL,\n"
						+ INSERTNAME + "_COMMENT_CONTENT VARCHAR(1000) NOT NULL,\n"
						+ INSERTNAME + "_COMMENT_REPLY_POS SMALLINT(5) NOT NULL,\n"
						+ INSERTNAME + "_COMMENT_REPLY_REF SMALLINT(5) NOT NULL,\n"
						+ INSERTNAME + "_COMMENT_REPLY_DEPTH SMALLINT(5) NOT NULL,\n"
						+ INSERTNAME + "_COMMENT_USER_ID VARCHAR(20) NOT NULL,\n"
						+ INSERTNAME + "_COMMENT_DATE DATE NOT NULL,\n"
						+ "PRIMARY KEY (" + INSERTNAME + "_COMMENT_NUM),\n"
						+ "FOREIGN KEY (COMMENT_" + INSERTNAME + "_NUM) REFERENCES " + INSERTNAME + " (" + INSERTNAME + "_NUM),\n"
						+ "FOREIGN KEY (" + INSERTNAME + "_COMMENT_USER_ID) REFERENCES USER (USER_ID)\n"
						+ ");";
				
				pstmt = con.prepareStatement(sql);
				pstmt.executeUpdate();
				pstmt.close();
			}
			
			//첨부파일 테이블 생성
			if(opList.contains("fileupload")) {
				sql = "CREATE TABLE PROJECT." + INSERTNAME + "_FILEUPLOAD (\n"
						+ INSERTNAME + "_FILEUPLOAD_SERVER_NAME VARCHAR(100) NOT NULL,\n"
						+ "FILEUPLOAD_" + INSERTNAME + "_NUM INT NOT NULL,\n"
						+ INSERTNAME + "_FILEUPLOAD_NAME VARCHAR(100) NOT NULL,\n"
						+ INSERTNAME + "_FILEUPLOAD_EXTENSION VARCHAR(10) NOT NULL,\n"
						+ INSERTNAME + "_FILEUPLOAD_SIZE INT(20) NOT NULL,\n"
						+ "PRIMARY KEY (" + INSERTNAME + "_FILEUPLOAD_SERVER_NAME),\n"
						+ "FOREIGN KEY (FILEUPLOAD_" + INSERTNAME + "_NUM) REFERENCES " + INSERTNAME + " (" + INSERTNAME + "_NUM)\n"
						+ ");";
				
				pstmt = con.prepareStatement(sql);
				pstmt.executeUpdate();
				pstmt.close();
			}
			
			//추천 테이블 생성
			if(opList.contains("likey")) {
				sql = "CREATE TABLE PROJECT." + INSERTNAME + "_LIKEY (\n"
						+ INSERTNAME + "_LIKEY_NUM INT NOT NULL AUTO_INCREMENT,\n"
						+ "LIKEY_" + INSERTNAME + "_NUM INT NOT NULL,\n"
						+ INSERTNAME + "_LIKEY_USER_ID VARCHAR(20) NOT NULL,\n"
						+ "PRIMARY KEY (" + INSERTNAME + "_LIKEY_NUM),\n"
						+ "FOREIGN KEY (LIKEY_" + INSERTNAME + "_NUM) REFERENCES " + INSERTNAME + " (" + INSERTNAME + "_NUM),\n"
						+ "FOREIGN KEY (" + INSERTNAME + "_LIKEY_USER_ID) REFERENCES USER (USER_ID)\n"
						+ ");";
				
				pstmt = con.prepareStatement(sql);
				pstmt.executeUpdate();
				pstmt.close();
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	
	//테이블 존재 유무 확인
	public boolean tableExists(String tableName) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select * from information_schema.tables\n"
					+ "where table_schema = 'project' and table_name = '" + tableName +"';";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	//컬럼 존재 유무 확인
	public boolean colExists(String tableName, String colName) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "select * from information_schema.columns\n"
					+ "where table_schema = 'project' and table_name = '" + tableName +"' and column_name = '" + colName + "'";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	
	//게시판 수정 - 이름 업데이트
	public void updateTableName(String oldTable, String updateTable) {
		//업데이트문 저장 가변 리스트
		ArrayList<String> updateList = new ArrayList<>();
		//옵션
		int[] op = {0, 0, 0};
		
		//게시판 테이블 업데이트문
		String[] tableList = {"RENAME TABLE " + oldTable+" TO " + updateTable+";",
				"ALTER TABLE " + updateTable + " CHANGE COLUMN " + oldTable+"_NUM " + updateTable+"_NUM INT;",
				"ALTER TABLE " + updateTable + " CHANGE COLUMN " + oldTable+"_TITLE " + updateTable+"_TITLE VARCHAR(50);",
				"ALTER TABLE " + updateTable + " CHANGE COLUMN " + oldTable+"_CONTENT " + updateTable+"_CONTENT VARCHAR(1000);",
				"ALTER TABLE " + updateTable + " CHANGE COLUMN " + oldTable+"_DATE " + updateTable+"_DATE DATE;",
				"ALTER TABLE " + updateTable + " CHANGE COLUMN " + oldTable+"_COUNT " + updateTable+"_COUNT INT;"
				};
		//댓글 테이블 업데이트문
		String[] commentList = {"ALTER TABLE " + oldTable +"_COMMENT DROP FOREIGN KEY " + oldTable + "_COMMENT_IBFK_1",
				"ALTER TABLE " + oldTable +"_COMMENT DROP FOREIGN KEY " + oldTable + "_COMMENT_IBFK_2",
				"RENAME TABLE " + oldTable+"_COMMENT TO " + updateTable+"_COMMENT;",
				"ALTER TABLE " + updateTable + "_COMMENT CHANGE COLUMN " + oldTable+"_COMMENT_NUM " + updateTable+"_COMMENT_NUM INT;",
				"ALTER TABLE " + updateTable + "_COMMENT CHANGE COLUMN COMMENT_"+oldTable+"_NUM COMMENT_"+updateTable+"_NUM INT;",
				"ALTER TABLE " + updateTable + "_COMMENT CHANGE COLUMN " + oldTable+"_COMMENT_CONTENT " + updateTable+"_COMMENT_CONTENT VARCHAR(1000);",
				"ALTER TABLE " + updateTable + "_COMMENT CHANGE COLUMN " + oldTable+"_COMMENT_REPLY_POS " + updateTable+"_COMMENT_REPLY_POS SMALLINT(5);",
				"ALTER TABLE " + updateTable + "_COMMENT CHANGE COLUMN " + oldTable+"_COMMENT_REPLY_REF " + updateTable+"_COMMENT_REPLY_REF SMALLINT(5);",
				"ALTER TABLE " + updateTable + "_COMMENT CHANGE COLUMN " + oldTable+"_COMMENT_REPLY_DEPTH " + updateTable+"_COMMENT_REPLY_DEPTH SMALLINT(5);",
				"ALTER TABLE " + updateTable + "_COMMENT CHANGE COLUMN " + oldTable+"_COMMENT_USER_ID " + updateTable+"_COMMENT_USER_ID VARCHAR(20);",
				"ALTER TABLE " + updateTable + "_COMMENT CHANGE COLUMN " + oldTable+"_COMMENT_DATE " + updateTable+"_COMMENT_DATE DATE;"			
				};
		//첨부파일 테이블 업데이트문
		String[] fileuploadList = {"ALTER TABLE " + oldTable +"_FILEUPLOAD DROP FOREIGN KEY " + oldTable + "_FILEUPLOAD_IBFK_1",
				"RENAME TABLE " + oldTable+"_FILEUPLOAD TO " + updateTable+"_FILEUPLOAD;",
				"ALTER TABLE " + updateTable + "_FILEUPLOAD CHANGE COLUMN " + oldTable+"_FILEUPLOAD_SERVER_NAME " + updateTable+"_FILEUPLOAD_SERVER_NAME VARCHAR(100);",
				"ALTER TABLE " + updateTable + "_FILEUPLOAD CHANGE COLUMN FILEUPLOAD_"+oldTable+"_NUM FILEUPLOAD_"+updateTable+"_NUM INT;",
				"ALTER TABLE " + updateTable + "_FILEUPLOAD CHANGE COLUMN " + oldTable+"_FILEUPLOAD_NAME " + updateTable+"_FILEUPLOAD_NAME VARCHAR(100);",
				"ALTER TABLE " + updateTable + "_FILEUPLOAD CHANGE COLUMN " + oldTable+"_FILEUPLOAD_EXTENSION " + updateTable+"_FILEUPLOAD_EXTENSION VARCHAR(10);",
				"ALTER TABLE " + updateTable + "_FILEUPLOAD CHANGE COLUMN " + oldTable+"_FILEUPLOAD_SIZE " + updateTable+"_FILEUPLOAD_SIZE INT;"
				};
		//추천 테이블 업데이트문
		String[] likeyList = {"ALTER TABLE " + oldTable +"_LIKEY DROP FOREIGN KEY " + oldTable + "_LIKEY_IBFK_1",
				"ALTER TABLE " + oldTable +"_LIKEY DROP FOREIGN KEY " + oldTable + "_LIKEY_IBFK_2",	
				"RENAME TABLE " + oldTable+"_LIKEY TO " + updateTable+"_LIKEY;",
				"ALTER TABLE " + updateTable + "_LIKEY CHANGE COLUMN " + oldTable+"_LIKEY_NUM " + updateTable+"_LIKEY_NUM INT;",
				"ALTER TABLE " + updateTable + "_LIKEY CHANGE COLUMN LIKEY_"+oldTable+"_NUM LIKEY_"+updateTable+"_NUM INT;",
				"ALTER TABLE " + updateTable + "_LIKEY CHANGE COLUMN " + oldTable+"_LIKEY_USER_ID " + updateTable+"_LIKEY_USER_ID VARCHAR(20);"
				};
		//유료글 컬럼 업데이트문
		String[] payCol = {"ALTER TABLE " + updateTable + " CHANGE COLUMN " + oldTable+"_TEST_NUM " + updateTable+"_TEST_NUM VARCHAR(20);",
				"ALTER TABLE " + updateTable + " CHANGE COLUMN " + oldTable+"_PAY " + updateTable+"_PAY INT;",
				"ALTER TABLE " + updateTable + " CHANGE COLUMN " + oldTable+"_AGREE " + updateTable+"_AGREE SMALLINT(5);",
				"ALTER TABLE " + updateTable + " CHANGE COLUMN " + oldTable+"_REASON " + updateTable+"_REASON VARCHAR(100);",
				};
		
		String[] fkAdd = {"ALTER TABLE " + updateTable +"_COMMENT ADD FOREIGN KEY (COMMENT_" + updateTable + "_NUM) REFERENCES " + updateTable + " (" + updateTable + "_NUM);",
				"ALTER TABLE " + updateTable +"_COMMENT ADD FOREIGN KEY (" + updateTable + "_COMMENT_USER_ID) REFERENCES USER (USER_ID);",
				"ALTER TABLE " + updateTable +"_FILEUPLOAD ADD FOREIGN KEY (FILEUPLOAD_" + updateTable + "_NUM) REFERENCES " + updateTable + " (" + updateTable + "_NUM);",
				"ALTER TABLE " + updateTable +"_LIKEY ADD FOREIGN KEY (LIKEY_" + updateTable + "_NUM) REFERENCES " + updateTable + " (" + updateTable + "_NUM);",
				"ALTER TABLE " + updateTable +"_LIKEY ADD FOREIGN KEY (" + updateTable + "_LIKEY_USER_ID) REFERENCES USER (USER_ID);"
		};

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			
			//if 문을 통해서 각 상황에 맞는 업데이트문을 가변 리스트에 추가
			//게시판 이름이 수정되었을 경우
			if(oldTable != updateTable) {
				
				//댓글 테이블이 있을 경우 이름 수정
				if(tableExists(oldTable+"_COMMENT") == true) {
					Collections.addAll(updateList, commentList);
					op[0] = 1;
				}
				
				//첨부파일 테이블이 있을 경우 이름 수정
				if(tableExists(oldTable+"_FILEUPLOAD") == true) {
					Collections.addAll(updateList, fileuploadList);
					op[1] = 1;
				}
				
				//추천 테이블이 있을 경우 이름 수정
				if(tableExists(oldTable+"_LIKEY") == true) {
					Collections.addAll(updateList, likeyList);
					op[2] = 1;
				}
				
				//이후에 게시판 기본 옵션 이름 수정
				Collections.addAll(updateList, tableList);
				
				//추천수 컬럼이 있을 경우
				if(colExists(oldTable, oldTable+"_GOOD") == true) {
					updateList.add("ALTER TABLE " + updateTable + " CHANGE COLUMN " + oldTable+"_GOOD " + updateTable+"_GOOD INT;");
				}
				//사용자 컬럼이 있을 경우
				if(colExists(oldTable, oldTable+"_USER_ID") == true) {
					updateList.add("ALTER TABLE " + updateTable + " CHANGE COLUMN " + oldTable+"_USER_ID " + updateTable+"_USER_ID VARCHAR(20);");
				}
				//유료글 컬럼들이 있을 경우
				if(colExists(oldTable, oldTable+"_PAY") == true) {
					Collections.addAll(updateList, payCol);
				}
				
				//옵션에 따라 fk 다시 부여
				//[0] : 댓글 테이블  
				if(op[0] == 1) {
					updateList.add(fkAdd[0]);
					updateList.add(fkAdd[1]);
				}
				//[1] : 첨부파일 테이블
				if(op[1] == 1) {
					updateList.add(fkAdd[2]);
				}
				//[2] : 추천 테이블
				if(op[2] == 1) {
					updateList.add(fkAdd[3]);
					updateList.add(fkAdd[4]);
				}
			}
			
			for(int i=0; i < updateList.size(); i++) {
				sql = updateList.get(i);
				System.out.println(sql);
				pstmt = con.prepareStatement(sql);
				pstmt.executeUpdate();
				pstmt.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	
	//게시판 업데이트 - 옵션 변경
	public void updateTableOp(String op[], String updateTable) {
		List<String> opList = new ArrayList<>();
		if(op[0]!=null&&!op[0].equals("")) {
			opList = Arrays.asList(op);
		}
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			
			//사용자 권한, 유료글 옵션 + _USER_ID 컬럼이 없을 경우
			if(opList.contains("col_user") || opList.contains("col_pay")) {
				if(!colExists(updateTable, updateTable+"_USER_ID")) {
					
				}
			}
				
				//유료글
				if(opList.contains("col_pay")) {
			sql = "";
			pstmt = con.prepareStatement(sql);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	
	//게시판 전체 삭제
	public void deleteTabel(String deleteName) {
		String[] deleteList = {"DROP TABLE IF EXISTS PROJECT." + deleteName + "_COMMENT;",
				"DROP TABLE IF EXISTS PROJECT." + deleteName + "_FILEUPLOAD;",
				"DROP TABLE IF EXISTS PROJECT." + deleteName + "_LIKEY;",
				"DROP TABLE IF EXISTS PROJECT." + deleteName + ";"};
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			for (int i = 0; i<deleteList.length; i++) {
				sql = deleteList[i];
				pstmt = con.prepareStatement(sql);
				pstmt.executeUpdate();
				pstmt.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	
	public static void main(String[] args) {
		CreateMgr mgr = new CreateMgr();
		System.out.println(mgr.colExists("bbb", "aaa_USER_ID"));
	}
}
