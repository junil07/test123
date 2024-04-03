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
			if(opList.contains("col_user")) {
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
			if(opList.contains("col_like")) {
				sql += ",\n"
						+ INSERTNAME + "_GOOD INT(10) DEFAULT 0";
			}
			
			//PK
			sql += ",\n"
				+ "PRIMARY KEY (" + INSERTNAME + "_NUM)";
			
			//FK 부분
			//유저 아이디
			if(opList.contains("col_user")) {
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
						+ INSERTNAME + "_LIKEY_USER_ID VARCHAR(50) NOT NULL,\n"
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
	
	
	//게시판 수정
	public void updateTableName(String oldTable, String updateTable) {
		//업데이트문 저장 가변 리스트
		ArrayList<String> updateList = new ArrayList<>();
		
		//게시판 테이블 업데이트문
		String[] tableList = {"RENAME TABLE " + oldTable+" TO " + updateTable+";",
				"ALTER TABLE " + updateTable + " CHANGE COLUMN " + oldTable+"_NUM " + updateTable+"_NUM;",
				"ALTER TABLE " + updateTable + " CHANGE COLUMN " + oldTable+"_TITLE " + updateTable+"_TITLE;",
				"ALTER TABLE " + updateTable + " CHANGE COLUMN " + oldTable+"_CONTENT " + updateTable+"_CONTENT;",
				"ALTER TABLE " + updateTable + " CHANGE COLUMN " + oldTable+"_DATE " + updateTable+"_DATE;",
				"ALTER TABLE " + updateTable + " CHANGE COLUMN " + oldTable+"_COUNT " + updateTable+"_COUNT;"
				};
		//댓글 테이블 업데이트문
		String[] commentList = {"RENAME TABLE " + oldTable+"_COMMENT TO " + updateTable+"_COMMENT;",
				"ALTER TABLE " + updateTable + "_COMMENT CHANGE COLUMN " + oldTable+"_COMMENT_NUM " + updateTable+"_COMMENT_NUM;",
				"ALTER TABLE " + updateTable + "_COMMENT CHANGE COLUMN COMMENT_"+oldTable+"_NUM COMMENT_"+updateTable+"_NUM;",
				"ALTER TABLE " + updateTable + "_COMMENT CHANGE COLUMN " + oldTable+"_COMMENT_CONTENT " + updateTable+"_COMMENT_CONTENT;",
				"ALTER TABLE " + updateTable + "_COMMENT CHANGE COLUMN " + oldTable+"_COMMENT_REPLY_POS " + updateTable+"_COMMENT_REPLY_POS;",
				"ALTER TABLE " + updateTable + "_COMMENT CHANGE COLUMN " + oldTable+"_COMMENT_REPLY_REF " + updateTable+"_COMMENT_REPLY_REF;",
				"ALTER TABLE " + updateTable + "_COMMENT CHANGE COLUMN " + oldTable+"_COMMENT_REPLY_DEPTH " + updateTable+"_COMMENT_REPLY_DEPTH;",
				"ALTER TABLE " + updateTable + "_COMMENT CHANGE COLUMN " + oldTable+"_COMMENT_USER_ID " + updateTable+"_COMMENT_USER_ID;",
				"ALTER TABLE " + updateTable + "_COMMENT CHANGE COLUMN " + oldTable+"_COMMENT_DATE " + updateTable+"_COMMENT_DATE;"
				};
		//첨부파일 테이블 업데이트문
		String[] fileuploadList = {"RENAME TABLE " + oldTable+"_FILEUPLOAD TO " + updateTable+"_FILEUPLOAD;",
				"ALTER TABLE " + updateTable + "_FILEUPLOAD CHANGE COLUMN " + oldTable+"_FILEUPLOAD_SERVER_NAME " + updateTable+"_FILEUPLOAD_SERVER_NAME;",
				"ALTER TABLE " + updateTable + "_FILEUPLOAD CHANGE COLUMN FILEUPLOAD_"+oldTable+"_NUM FILEUPLOAD_"+updateTable+"_NUM;",
				"ALTER TABLE " + updateTable + "_FILEUPLOAD CHANGE COLUMN " + oldTable+"_FILEUPLOAD_NAME " + updateTable+"_FILEUPLOAD_NAME;",
				"ALTER TABLE " + updateTable + "_FILEUPLOAD CHANGE COLUMN " + oldTable+"_FILEUPLOAD_EXTENSION " + updateTable+"_FILEUPLOAD_EXTENSION;",
				"ALTER TABLE " + updateTable + "_FILEUPLOAD CHANGE COLUMN " + oldTable+"_FILEUPLOAD_SIZE " + updateTable+"_FILEUPLOAD_SIZE;"
				};
		//추천 테이블 업데이트문
		String[] likeyList = {"RENAME TABLE " + oldTable+"_LIKEY TO " + updateTable+"_LIKEY;",
				"ALTER TABLE " + updateTable + "_LIKEY CHANGE COLUMN " + oldTable+"_LIKEY_NUM " + updateTable+"_LIKEY_NUM;",
				"ALTER TABLE " + updateTable + "_LIKEY CHANGE COLUMN LIKEY_"+oldTable+"_NUM LIKEY_"+updateTable+"_NUM;",
				"ALTER TABLE " + updateTable + "_LIKEY CHANGE COLUMN " + oldTable+"_LIKEY_USER_ID " + updateTable+"_LIKEY_USER_ID;"
				};
		//유로글 컬럼 업데이트문
		String[] payCol = {"ALTER TABLE " + updateTable + " CHANGE COLUMN " + oldTable+"_TEST_NUM " + updateTable+"_TEST_NUM;",
				"ALTER TABLE " + updateTable + " CHANGE COLUMN " + oldTable+"_PAY " + updateTable+"_PAY;",
				"ALTER TABLE " + updateTable + " CHANGE COLUMN " + oldTable+"_AGREE " + updateTable+"_AGREE;",
				"ALTER TABLE " + updateTable + " CHANGE COLUMN " + oldTable+"_REASON " + updateTable+"_REASON;",
				};
		//FK 재설정
		String[] pkfk = {"ALTER TABLE " + oldTable +"_COMMENT DROP FOREIGN KEY "
				
		};
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			
			//if 문을 통해서 각 상황에 맞는 업데이트문을 가변 리스트에 추가
			//게시판 이름이 수정되었을 경우
			if(oldTable != updateTable) {
				Collections.addAll(updateList, tableList);
				
				//추천수 컬럼이 있을 경우
				if(colExists(updateTable, oldTable+"_GOOD")) {
					updateList.add("ALTER TABLE " + updateTable + " CHANGE COLUMN " + oldTable+"_GOOD " + updateTable+"_GOOD;");
				}
				//사용자 컬럼이 있을 경우
				if(colExists(updateTable, oldTable+"_USER_ID")) {
					updateList.add("ALTER TABLE " + updateTable + " CHANGE COLUMN " + oldTable+"_USER_ID " + updateTable+"_USER_ID;");
				}
				//유료글 컬럼들이 있을 경우
				if(colExists(updateTable, oldTable+"_USER_ID")) {
					Collections.addAll(updateList, payCol);
				}
				
				//댓글 테이블이 있을 경우 이름 수정
				if(tableExists(oldTable+"_COMMENT") == true) {
					Collections.addAll(updateList, commentList);
				}
				
				//첨부파일 테이블이 있을 경우 이름 수정
				if(tableExists(oldTable+"_FILEUPLOAD") == true) {
					Collections.addAll(updateList, fileuploadList);
				}
				
				//추천 테이블이 있을 경우 이름 수정
				if(tableExists(oldTable+"_LIKEY") == true) {
					Collections.addAll(updateList, likeyList);
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
		System.out.println(mgr.colExists("qna", "qna_numsdfsdf"));
	}
}
