package project;

import java.io.File;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

public class UtilMgr {


   public static String getDay(){
	   SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
       return format.format(new Date());
   }
   
   public static int parseInt(HttpServletRequest request, 
			String name) {
		return Integer.parseInt(request.getParameter(name));
	}
   
   public static String replace(String str, String pattern, String replace) {
	      int s = 0, e = 0;
	      StringBuffer result = new StringBuffer();

	      while ((e = str.indexOf(pattern, s)) >= 0) {
	         result.append(str.substring(s, e));
	         result.append(replace);
	         s = e + pattern.length();
	      }
	      result.append(str.substring(s));
	      return result.toString();
	   }
   
   public static String fileExtension(String filefullname) {
	   int index = filefullname.lastIndexOf(".");
	   
	   String extension = filefullname.substring(index + 1);
	   
	   return extension;
   }
   
   public static String fileName(String filefullname) {
	   int index = filefullname.lastIndexOf('.');
	   
	   String extension = filefullname.substring(0, index);
	   
	   return extension;
   }
   
   public static String monFormat(String b) {
	      String won;
	      double bb = Double.parseDouble(b);
	      won = NumberFormat.getIntegerInstance().format(bb);
	      return won;
	   }
   
   public static String monFormat(int b) {
	      String won;
	      double bb = b;
	      won = NumberFormat.getIntegerInstance().format(bb);
	      return won;
	   }
   
   public static String intFormat(int i) {
	      String s = String.valueOf(i);
	      return monFormat(s);
	   }
   
   public static void delete(String s) {
	      File file = new File(s);
	      if (file.isFile()) {
	         file.delete();
	      }
	   }
   
   public static String randomName(String filename) {
	   String newFileName = null;
	   String extension = filename.substring(filename.lastIndexOf("."), filename.length());

	   UUID uuid = UUID.randomUUID();
	   newFileName = uuid.toString() + extension;
	   
	   return newFileName;
   }
   
   public static void fileRename(String route, String oldFileName, String newFileName) {
	   // 1. 원본 파일        
	   File file = new File(route + oldFileName);         
	   // 2. new File        
	   File newFile = new File(route + newFileName);              
	   // 3. rename        
	   boolean result = file.renameTo(newFile);         
   }


}