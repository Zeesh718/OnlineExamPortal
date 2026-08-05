package com.exam.utility;

import java.util.List;

/**
 * Kisi bhi list (students, subjects, exams, questions, results) ko
 * page-wise dikhane ke liye generic wrapper. Isme UI ko chahiye wo
 * sab kuch hai: current page, total pages, total items, wagerah.
 */
public class PageResult<T> {

	private List<T> content;
	private int currentPage;
	private int totalPages;
	private long totalItems;
	private int pageSize;

	public PageResult(List<T> content, int currentPage, int totalPages, long totalItems, int pageSize) {
		this.content = content;
		this.currentPage = currentPage;
		this.totalPages = totalPages;
		this.totalItems = totalItems;
		this.pageSize = pageSize;
	}

	public List<T> getContent() {
		return content;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public int getTotalPages() {
		return totalPages;
	}

	public long getTotalItems() {
		return totalItems;
	}

	public int getPageSize() {
		return pageSize;
	}

	public boolean isHasPrevious() {
		return currentPage > 1;
	}

	public boolean isHasNext() {
		return currentPage < totalPages;
	}
}
