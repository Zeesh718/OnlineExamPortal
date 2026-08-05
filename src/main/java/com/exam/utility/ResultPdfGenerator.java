package com.exam.utility;

import java.io.OutputStream;
import java.time.LocalDate;

import com.exam.entity.Result;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

/**
 * Ek student ke ek exam result ka PDF report banata hai (iText 5).
 */
public class ResultPdfGenerator {

	public static void generate(Result result, OutputStream out) throws Exception {

		Document document = new Document(PageSize.A4, 40, 40, 50, 50);
		PdfWriter.getInstance(document, out);
		document.open();

		Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 20, new BaseColor(67, 97, 238));
		Font headFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12);
		Font normalFont = FontFactory.getFont(FontFactory.HELVETICA, 11);

		Paragraph title = new Paragraph("Online Exam Portal - Result Report", titleFont);
		title.setAlignment(Element.ALIGN_CENTER);
		document.add(title);

		Paragraph sub = new Paragraph("Generated on: " + LocalDate.now(), normalFont);
		sub.setAlignment(Element.ALIGN_CENTER);
		sub.setSpacingAfter(20);
		document.add(sub);

		PdfPTable studentTable = new PdfPTable(2);
		studentTable.setWidthPercentage(100);
		addRow(studentTable, "Student Name", result.getUser().getName(), headFont, normalFont);
		addRow(studentTable, "Email", result.getUser().getEmail(), headFont, normalFont);
		addRow(studentTable, "Exam", result.getExam().getExamName(), headFont, normalFont);
		addRow(studentTable, "Subject", result.getExam().getSubject().getSubjectName(), headFont, normalFont);
		addRow(studentTable, "Submitted On", String.valueOf(result.getSubmittedDate()), headFont, normalFont);
		document.add(studentTable);

		document.add(new Paragraph(" "));

		PdfPTable scoreTable = new PdfPTable(2);
		scoreTable.setWidthPercentage(100);
		addRow(scoreTable, "Correct Answers", String.valueOf(result.getCorrect()), headFont, normalFont);
		addRow(scoreTable, "Wrong Answers", String.valueOf(result.getWrong()), headFont, normalFont);
		addRow(scoreTable, "Unattempted", String.valueOf(result.getUnattemted()), headFont, normalFont);
		addRow(scoreTable, "Total Marks", String.valueOf(result.getExam().getTotalMarks()), headFont, normalFont);
		addRow(scoreTable, "Obtained Marks", String.valueOf(result.getObtainedMarks()), headFont, normalFont);

		double percentage = 0;
		if (result.getExam().getTotalMarks() != null && result.getExam().getTotalMarks() > 0) {
			percentage = (result.getObtainedMarks() * 100.0) / result.getExam().getTotalMarks();
		}
		addRow(scoreTable, "Percentage", String.format("%.2f", percentage) + " %", headFont, normalFont);
		addRow(scoreTable, "Status", percentage >= 40 ? "PASS" : "FAIL", headFont, normalFont);

		document.add(scoreTable);

		document.close();
	}

	private static void addRow(PdfPTable table, String label, String value, Font headFont, Font normalFont) {
		PdfPCell c1 = new PdfPCell(new Paragraph(label, headFont));
		c1.setPadding(8);
		c1.setBackgroundColor(new BaseColor(244, 246, 251));
		PdfPCell c2 = new PdfPCell(new Paragraph(value == null ? "-" : value, normalFont));
		c2.setPadding(8);
		table.addCell(c1);
		table.addCell(c2);
	}
}
