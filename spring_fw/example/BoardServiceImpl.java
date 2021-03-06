package com.phl.nft.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.phl.nft.dto.BoardDTO;
import com.phl.nft.dto.CateDTO;
import com.phl.nft.dto.LikeDTO;
import com.phl.nft.dto.PageDTO;
import com.phl.nft.repository.BoardRepository;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardRepository br;

	@Override
	public void boardSave(BoardDTO board)throws IllegalStateException, IOException{
		
		br.boardPoint(board.getM_id(),50,"게시물 적립");
		
		MultipartFile b_file = board.getB_file();
		String b_filename = b_file.getOriginalFilename();
		b_filename = System.currentTimeMillis() + "-" + b_filename;
		// 파일 저장하기 
		String savePath = "D:\\development_Phl\\source\\spring\\NftGameCommunity\\src\\main\\webapp\\resources\\board_uploadfile\\"+b_filename;
		if(!b_file.isEmpty()) {
			b_file.transferTo(new File(savePath));
		} 
		board.setB_filename(b_filename);
		
		br.save(board);
	}
	

	
	@Override
	public List<BoardDTO> boardFindAll() {
		return br.boardFindAll();
	}
	


	private static final int PAGE_LIMIT = 5; // 한페이지에 보여질 글 개수
	private static final int BLOCK_LIMIT = 3; // 한화면에 보여질 페이지 개수

	@Override
	public List<BoardDTO> boardPagingList(int page) {
		int pagingStart = (page-1) * PAGE_LIMIT;
		Map<String, Integer> pagingParam = new HashMap<String, Integer>();
		pagingParam.put("start", pagingStart);
		pagingParam.put("limit", PAGE_LIMIT);

	List<BoardDTO> pagingList = br.boardPagingList1(pagingParam);
	return pagingList;
	}

	@Override
	public PageDTO boardPaging(int page) {
		int boardCount = br.boardCount();
		int maxPage = (int)(Math.ceil((double)boardCount / PAGE_LIMIT));
		int startPage = (((int)(Math.ceil((double)page / BLOCK_LIMIT))) - 1) * BLOCK_LIMIT + 1;
		int endPage = startPage + BLOCK_LIMIT - 1;
		if(endPage > maxPage)
			endPage = maxPage;
		PageDTO paging = new PageDTO();
		paging.setPage(page);
		paging.setStartPage(startPage);
		paging.setEndPage(endPage);
		paging.setMaxPage(maxPage);

		return paging;
	}
	@Override
	public void boardDelete(long b_number) {
		br.boardDelete(b_number);
	}


	@Override
	public BoardDTO boardDetail(long b_number) {
		return br.boardDetail(b_number);
	}


	@Override
	public void boardUpdate(BoardDTO board) throws IllegalStateException, IOException{
		MultipartFile b_file = board.getB_file();
		String b_filename = b_file.getOriginalFilename();
		b_filename = System.currentTimeMillis() + "-" + b_filename;
		System.out.println("b_filename: " + b_filename);
		// 파일 저장하기 
		String savePath = "D:\\development_Phl\\source\\spring\\MemberBoardProject\\src\\main\\webapp\\resources\\board_upload\\"+b_filename;
		if(!b_file.isEmpty()) {
			b_file.transferTo(new File(savePath));
		}
		
		board.setB_filename(b_filename);		
		br.boardUpdate(board);
	}



	@Override
	public List<BoardDTO> search(String searchtype, String keyword) {
		Map<String, String> searchParam = new HashMap<String, String>();
		searchParam.put("type", searchtype);
		searchParam.put("word", keyword);
		List<BoardDTO> bList = br.search(searchParam);
		return bList;
	}


	@Override
	public void cateSave(CateDTO cate) {
		br.cateSave(cate);
		
	}



	@Override
	public List<BoardDTO> findCate(int cate_number) {
		return br.findCate(cate_number);
	}


@Override
	public CateDTO cateName(int cate_number) {
		return br.cateName(cate_number);
	}


	@Override
	public List<BoardDTO> catePagingList(int page, int cate_number) {
		int pagingStart = (page - 1) * PAGE_LIMIT;
		Map<String, Integer> pagingParam = new HashMap<String, Integer>();
		pagingParam.put("start", pagingStart);
		pagingParam.put("limit", PAGE_LIMIT);
		pagingParam.put("cate_number", cate_number);

		List<BoardDTO> pagingList = br.catePagingList1(pagingParam);
		for (BoardDTO b : pagingList) {
			System.out.println(b.toString());
		}
		return pagingList;
	}

	@Override
	public PageDTO catePaging(int page, int cate_number) {
		int boardCount = br.cateBoardCount(cate_number);
		int maxPage = (int) (Math.ceil((double) boardCount / PAGE_LIMIT));
		int startPage = (((int) (Math.ceil((double) page / BLOCK_LIMIT))) - 1) * BLOCK_LIMIT + 1;
		int endPage = startPage + BLOCK_LIMIT - 1;
		if (endPage > maxPage)
			endPage = maxPage;
		PageDTO paging = new PageDTO();
		paging.setPage(page);
		paging.setStartPage(startPage);
		paging.setEndPage(endPage);
		paging.setMaxPage(maxPage);


		return paging;
	}
	

@Override
	public LikeDTO findLike(long b_number, String m_id) {
		return br.findLike(b_number,m_id);
	}



@Override
public int insertLike(LikeDTO like) {
	int result = 0;
	// 좋아요가 이미 있는지 확인하는 코드
	LikeDTO find = br.memberFindLike(like);
	
	// find가 null이면 좋아요가 없는 상태이므로 정보 저장
	// find가 null이 아니면 좋아요가 있는 상태이므로 정보 삭제
	if(find==null) {
		result = br.insertLike(like);
		br.plusLike(like);
	} else {
		br.deleteLike(like);
		br.minusLike(like);
		
	}
	return result;
	

}




@Override
public List<CateDTO> cateFindAll() {
	return br.cateFindAll();
}


@Override
public List<BoardDTO> sort(int sort) {
	if(sort == 1) {
		List<BoardDTO> bList = br.viewSort();
		return bList;		
	}else {
		List<BoardDTO> bList = br.likeSort();
		return bList;
		
	}
	
}


@Override
public List<BoardDTO> cateSort(int cate_number,int sort) {
	if(sort == 1) {
		List<BoardDTO> bList = br.cateviewSort(cate_number);
		return bList;		
	}else {
		List<BoardDTO> bList = br.catelikeSort(cate_number);
		return bList;
		
	}
}
	
	
	}
	

