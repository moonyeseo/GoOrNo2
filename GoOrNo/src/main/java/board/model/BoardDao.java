package board.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.Paging;

@Component
public class BoardDao {
	
	@Autowired
	SqlSessionTemplate sst;
	
	private String namespace = "board";
	
	public int getTotalCount(Map<String, String> map) {
		int cnt = -1;
		cnt = sst.selectOne(namespace+".getTotalCount",map);
		return cnt;
	}

	public List<BoardBean> getBoardList(Map<String, String> map, Paging pageInfo) {
		List<BoardBean> blists = new ArrayList<BoardBean>();
		RowBounds rowbounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		blists = sst.selectList(namespace+".getBoardList", map, rowbounds);
		return blists;
	}

	public int insertBoard(BoardBean board) {
		int cnt = -1;
		cnt = sst.insert(namespace+".insertBoard", board);
		return cnt;
	}

	public BoardBean getBoardByNo(int board_no) {
		BoardBean bb = null;
		bb = sst.selectOne(namespace+".getBoardByNo",board_no);
		return bb;
	}
	
	public void updateReadcount(int board_no) {
		sst.update(namespace+".updateReadcount",board_no);
	}

	public int updateBoard(BoardBean board) {
		int cnt = sst.update(namespace+".updateBoard", board);
		return cnt;
	}

	public int deleteBoard(int board_no) {
		System.out.println("¿©±â : "+board_no);
		int cnt = sst.delete(namespace+".deleteBoard",board_no);
		return cnt;
	}

}
