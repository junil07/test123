package project;

public class ChoiceBean {
	
	private int choice_num,
						choice_question_num,
						choice_number, 
						choice_filesize;
	private String choice_content[], choice_file;
	public int getChoice_num() {
		return choice_num;
	}
	public void setChoice_num(int choice_num) {
		this.choice_num = choice_num;
	}
	public int getChoice_question_num() {
		return choice_question_num;
	}
	public void setChoice_question_num(int choice_question_num) {
		this.choice_question_num = choice_question_num;
	}
	public int getChoice_number() {
		return choice_number;
	}
	public void setChoice_number(int choice_number) {
		this.choice_number = choice_number;
	}
	public int getChoice_filesize() {
		return choice_filesize;
	}
	public void setChoice_filesize(int choice_filesize) {
		this.choice_filesize = choice_filesize;
	}
	public String[] getChoice_content() {
		return choice_content;
	}
	public void setChoice_content(String[] choice_content) {
		this.choice_content = choice_content;
	}
	public String getChoice_file() {
		return choice_file;
	}
	public void setChoice_file(String choice_file) {
		this.choice_file = choice_file;
	}

}
