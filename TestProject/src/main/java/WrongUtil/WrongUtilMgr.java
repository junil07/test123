package WrongUtil;

import java.util.HashSet;
import java.util.Set;

public class WrongUtilMgr {

	public static Set<Integer> parseStringToSet(String str) {
        Set<Integer> set = new HashSet<>();
        String[] strArray = str.split(",");
        for (String s : strArray) {
            s = s.trim(); // 공백 제거
            int num = Integer.parseInt(s);
            set.add(num);
        }
        return set;
    }

}
