package classes;

import java.util.ArrayList;
import java.util.List;

public class ListInt {
    public List<Integer> addInt() {
        List<Integer> list = new ArrayList<>();
        for (int i = 0; i <= 10; i++){
            list.add(i);
        }
        return  list;
    }
}
