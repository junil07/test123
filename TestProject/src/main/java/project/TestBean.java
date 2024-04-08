package project;

public class TestBean {
	private String test_num;
	private String test_title;
	private String test_year;
	private String test_subject;
	private int test_subnumber; //여러개의 과목 선택 시 배열로 get set

	
	public String getTest_num() {
		return test_num;
	}
	public void setTest_num(String test_num) {
		this.test_num = test_num;
	}
	public String getTest_title() {
		return test_title;
	}
	public void setTest_title(String test_title) {
		this.test_title = test_title;
	}
	public String getTest_year() {
		return test_year;
	}
	public void setTest_year(String test_year) {
		this.test_year = test_year;
	}
	public String getTest_subject() {
		return test_subject;
	}
	public void setTest_subject(String test_subject) {
		this.test_subject = test_subject;
	}
	public int getTest_subnumber() {
		return test_subnumber;
	}
	public void setTest_subnumber(int test_subnumber) {
		this.test_subnumber = test_subnumber;
	}


	
}
