package users.model;

import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import utility.Paging;

@Service("myUsersDao")
public class UsersDao {

	private String namespace = "users.model.Users";

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public UsersDao() {
		System.out.println("UsersDao");
	}

	public int insertUsers(UsersBean users) {
		int cnt = -1;
		cnt = sqlSessionTemplate.insert(namespace + ".insertUsers", users);
		return cnt;
	}

	public List<UsersBean> getUserList(Map<String, String> map, Paging pageInfo) {
		List<UsersBean> lists = new ArrayList<UsersBean>();

		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		lists = sqlSessionTemplate.selectList(namespace + ".getUserList", map, rowBounds);

		return lists;
	}
	
	public int getTotalCount(Map<String, String> map) {

		int count = -1;
		count = sqlSessionTemplate.selectOne(namespace + ".getTotalCount", map);
		return count;
	}

	public UsersBean getById(String id) {
		UsersBean users = null;
		users = sqlSessionTemplate.selectOne(namespace + ".getById",id);
		return users;
	}
	
	public UsersBean getByUserId(int user_no) {
		UsersBean users = null;
		users = sqlSessionTemplate.selectOne(namespace + ".getByUserId", user_no);
		return users;
	}
	
	public UsersBean findkakao(HashMap<String, Object> loginInfo) {
		System.out.println("RN:"+loginInfo.get("nickname"));
        System.out.println("RE:"+loginInfo.get("email"));
    
		return sqlSessionTemplate.selectOne(namespace + ".findkakao" ,loginInfo);
	}

	public void kakaoinsert(HashMap<String, Object> loginInfo) {
		sqlSessionTemplate.insert(namespace + ".kakaoinsert", loginInfo);
		
	}

	public int searchId(String inputname) {
		int count = -1;
		count = sqlSessionTemplate.selectOne(namespace + ".searchId", inputname);
		return count;
	}
	
	/* woo 추가 */
	//유저 수정
	public int updateUsers(UsersBean usersBean) {
//		System.out.println("-----updateUsers()-----");
		
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace + ".updateUsers", usersBean);
		
//		System.out.println("Update count: " + cnt);
		
		return cnt;
	}//updateUsers
	
	
	//비밀번호 수정
	public int updatePw(UsersBean usersBean) {
//		System.out.println("-----updatePw()-----");
		
		int cnt = -1;
		cnt = sqlSessionTemplate.update(namespace + ".updatePw", usersBean);
		
		return cnt;
	}
	
	//유저 삭제
	public int deleteUsers(int user_no) {
//		System.out.println("-----deleteUsers()-----");
		
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace + ".deleteUsers", user_no);
		
		return cnt;
	}//deleteUsers
	
}