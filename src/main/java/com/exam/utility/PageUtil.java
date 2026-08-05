package com.exam.utility;

import java.util.Collections;
import java.util.List;

/**
 * Simple in-memory pagination helper.
 *
 * Hamari list already service layer se pura data laa rahi hai (student list,
 * question list, exam list, subject list, result list) - itne chhote scale
 * (coaching/college project) ke liye database-level LIMIT/OFFSET ki zarurat
 * nahi, isliye hum yaha hi list ko slice kar dete hain. Agar aage chal ke
 * data hazaro rows tak badh jaye, tab is hi jagah HQL me setFirstResult()/
 * setMaxResults() laga kar DB-level pagination me upgrade kiya ja sakta hai
 * bina UI/controller code chede.
 */
public class PageUtil {

	public static final int DEFAULT_PAGE_SIZE = 6;

	public static <T> PageResult<T> paginate(List<T> fullList, int page, int size) {

		if (fullList == null) {
			fullList = Collections.emptyList();
		}
		if (size < 1) {
			size = DEFAULT_PAGE_SIZE;
		}
		if (page < 1) {
			page = 1;
		}

		int totalItems = fullList.size();
		int totalPages = (int) Math.ceil((double) totalItems / size);
		if (totalPages == 0) {
			totalPages = 1;
		}
		if (page > totalPages) {
			page = totalPages;
		}

		int fromIndex = (page - 1) * size;
		int toIndex = Math.min(fromIndex + size, totalItems);

		List<T> pageContent;
		if (fromIndex >= totalItems || fromIndex < 0) {
			pageContent = Collections.emptyList();
		} else {
			pageContent = fullList.subList(fromIndex, toIndex);
		}

		return new PageResult<>(pageContent, page, totalPages, totalItems, size);
	}
}
