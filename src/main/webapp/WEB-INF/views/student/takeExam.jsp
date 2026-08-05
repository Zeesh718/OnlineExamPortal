<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Take Exam - ${exam.examName}</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<style>

* { box-sizing: border-box; }
html, body { margin: 0; padding: 0; }
body {
    font-family: Arial, sans-serif;
    background: #f4f6f9;
    user-select: none;
    -webkit-user-select: none;
}

.container { width: 92%; max-width: 1400px; margin: 20px auto 40px; }

/* ============ STATUS BAR ============ */
.exam-status-bar {
    position: sticky; top: 0; z-index: 1000;
    width: 100%; background: white;
    padding: 12px 4%;
    display: flex; justify-content: space-between; align-items: center;
    box-shadow: 0 2px 10px rgba(0,0,0,.10);
}
.exam-status-name { font-size: 18px; font-weight: bold; color: #4361ee; }
.exam-status-right { display: flex; align-items: center; gap: 25px; }
.violation-display { font-weight: bold; color: #dc3545; }
.timer-display {
    font-size: 21px; font-weight: bold; color: #198754;
    padding: 6px 16px; border-radius: 30px; background: #eafaf1;
    transition: .3s;
}
.timer-display.time-warning {
    color: white; background: #dc3545;
    animation: pulseTimer 1s infinite;
}
@keyframes pulseTimer {
    0%,100% { box-shadow: 0 0 0 0 rgba(220,53,69,.5); }
    50% { box-shadow: 0 0 0 8px rgba(220,53,69,0); }
}

.fullscreen-banner {
    background: #fff3cd; color: #664d03; border: 1px solid #ffe69c;
    padding: 11px 16px; border-radius: 8px; margin-bottom: 20px;
    font-size: 14px; text-align: center;
}

.examHeader {
    background: white; padding: 20px 25px; border-radius: 12px;
    box-shadow: 0 0 10px lightgray; margin-bottom: 20px;
}
.examHeader h2 { color: #4361ee; margin-bottom: 14px; }
.examInfo { display: flex; justify-content: space-between; flex-wrap: wrap; gap: 12px; }
.examInfo p { font-size: 15px; margin: 4px 0; }

/* ============ MAIN LAYOUT: question + palette ============ */
.exam-layout {
    display: grid;
    grid-template-columns: 1fr 300px;
    gap: 20px;
    align-items: start;
}

.exam-main {
    background: white; border-radius: 12px; box-shadow: 0 0 10px lightgray;
    padding: 25px; min-height: 420px;
    display: flex; flex-direction: column;
}

.q-progress-line {
    font-size: 13px; color: #6c757d; margin-bottom: 6px;
}
.questionTitle { font-size: 20px; font-weight: bold; margin-bottom: 15px; color: #212529; }
.questionText { font-size: 17px; margin-bottom: 20px; line-height: 1.5; }

.option {
    margin: 10px 0; font-size: 16px;
    border: 1px solid #e9ecef; border-radius: 10px; padding: 12px 16px;
    transition: .15s;
}
.option:hover { background: #f8f9ff; border-color: #c7d2fe; }
.option label { cursor: pointer; margin-left: 8px; width: 100%; }
.option input[type="radio"]:checked + label { color: #4361ee; font-weight: bold; }
.option:has(input[type="radio"]:checked) { border-color: #4361ee; background: #eef1ff; }

.q-nav-buttons {
    margin-top: auto; padding-top: 20px; display: flex; flex-wrap: wrap; gap: 10px;
    border-top: 1px solid #eee;
}
.q-nav-buttons button {
    border: none; border-radius: 8px; padding: 10px 18px; font-size: 14px;
    font-weight: 600; cursor: pointer; transition: .15s;
}
#prevBtn { background: #e9ecef; color: #333; }
#clearBtn { background: #fff0f0; color: #dc3545; border: 1px solid #f5c2c7; }
#markReviewBtn { background: #fff4e0; color: #b8860b; border: 1px solid #f6dca3; }
#saveNextBtn { background: #4361ee; color: white; margin-left: auto; }
#finalSubmitBtn { background: #198754; color: white; }
.q-nav-buttons button:hover { filter: brightness(0.95); }
.q-nav-buttons button:disabled { opacity: .5; cursor: not-allowed; }

/* ============ PALETTE ============ */
.exam-palette {
    background: white; border-radius: 12px; box-shadow: 0 0 10px lightgray;
    padding: 18px; position: sticky; top: 90px;
}
.palette-title { font-weight: bold; margin-bottom: 12px; font-size: 15px; }
.palette-grid {
    display: grid; grid-template-columns: repeat(5, 1fr); gap: 8px; margin-bottom: 16px;
}
.pal-btn {
    width: 100%; aspect-ratio: 1; border-radius: 8px; border: none;
    font-size: 13px; font-weight: 700; cursor: pointer; color: white;
    background: #adb5bd; /* not-visited */
    position: relative;
}
.pal-btn.current { outline: 3px solid #4361ee; outline-offset: 2px; }
.pal-btn.not-answered { background: #dc3545; }
.pal-btn.answered { background: #198754; }
.pal-btn.marked { background: #6f42c1; }
.pal-btn.answered-marked { background: #6f42c1; }
.pal-btn.answered-marked::after {
    content: "\2713"; position: absolute; top: -5px; right: -5px;
    width: 18px; height: 18px; border-radius: 50%; background: #198754;
    color: white; font-size: 11px; font-weight: bold; line-height: 18px;
    display: flex; align-items: center; justify-content: center; box-shadow: 0 0 0 2px white;
}

.palette-legend { font-size: 12px; display: flex; flex-direction: column; gap: 6px; margin-bottom: 16px; }
.palette-legend span { display: flex; align-items: center; gap: 8px; }
.legend-dot { width: 12px; height: 12px; border-radius: 4px; display: inline-block; }

.submitBtn {
    width: 100%; padding: 12px; background: #198754; color: white; border: none;
    border-radius: 8px; font-size: 16px; font-weight: bold; cursor: pointer;
}
.submitBtn:hover { background: #157347; }

/* ============ OVERLAYS (unchanged) ============ */
.exam-start-overlay { position: fixed; inset: 0; background: rgba(0,0,0,.82); display: flex; justify-content: center; align-items: center; z-index: 999999; }
.exam-start-card { background: white; width: 430px; max-width: 90%; padding: 22px 28px; border-radius: 14px; text-align: center; box-shadow: 0 10px 40px rgba(0,0,0,.4); }
.exam-start-card h2 { color: #4361ee; font-size: 27px; margin: 0 0 10px; }
.exam-start-card p { font-size: 14px; line-height: 1.4; margin: 7px 0; }
.exam-rules { text-align: left; background: #f8f9fa; padding: 13px 16px; border-radius: 9px; margin: 14px 0; font-size: 13px; }
.exam-rules strong { font-size: 15px; }
.exam-rules ul { padding-left: 20px; margin: 8px 0 0; }
.exam-rules li { margin: 5px 0; line-height: 1.35; }
#startExamBtn { margin-top: 6px; padding: 10px 27px; border: none; border-radius: 7px; background: #4361ee; color: white; font-size: 15px; font-weight: bold; cursor: pointer; }

.violation-overlay { position: fixed; inset: 0; background: rgba(0,0,0,.94); display: none; justify-content: center; align-items: center; z-index: 9999999; }

/* Custom in-page modal used instead of native alert()/confirm() — native dialogs
   trigger a window "blur" event, which the anti-cheat logic would otherwise
   mistake for the student switching tabs/apps. */
.custom-modal-overlay { position: fixed; inset: 0; background: rgba(0,0,0,.55); display: none; justify-content: center; align-items: center; z-index: 99999999; }
.custom-modal-card { width: 420px; max-width: 90%; background: white; border-radius: 14px; padding: 24px; text-align: center; box-shadow: 0 10px 40px rgba(0,0,0,.35); }
.custom-modal-card h3 { color: #4361ee; font-size: 20px; margin: 0 0 10px; }
.custom-modal-card p { font-size: 14px; color: #333; line-height: 1.5; margin: 0 0 18px; }
.custom-modal-actions { display: flex; gap: 10px; justify-content: center; }
.custom-modal-actions button { border: none; border-radius: 8px; padding: 9px 20px; font-size: 14px; font-weight: 600; cursor: pointer; }
#modalConfirmBtn { background: #198754; color: white; }
#modalCancelBtn { background: #e9ecef; color: #333; }
.violation-card { width: 430px; max-width: 90%; background: white; padding: 25px; border-radius: 14px; text-align: center; }
.violation-card h2 { color: #dc3545; font-size: 25px; margin-bottom: 12px; }
.violation-card p { font-size: 15px; line-height: 1.5; }
.violation-number { font-size: 21px; font-weight: bold; color: #dc3545; margin: 15px 0; }
#returnFullScreenBtn { padding: 10px 24px; border: none; border-radius: 7px; background: #4361ee; color: white; font-size: 15px; font-weight: bold; cursor: pointer; }

body.exam-locked #examContent { visibility: hidden; }

/* ============ RESPONSIVE ============ */
@media(max-width:900px) {
    .exam-layout { grid-template-columns: 1fr; }
    .exam-palette { position: static; order: -1; }
    .palette-grid { grid-template-columns: repeat(8, 1fr); }
}
@media(max-width:768px) {
    .container { width: 96%; }
    .exam-status-bar { padding: 10px 3%; flex-direction: column; gap: 8px; }
    .exam-status-right { gap: 15px; }
    .examInfo { flex-direction: column; }
    .q-nav-buttons { justify-content: stretch; }
    .q-nav-buttons button { flex: 1 1 45%; }
    #saveNextBtn { margin-left: 0; }
}

</style>

</head>

<body>

<!-- START OVERLAY -->
<div id="examStartOverlay" class="exam-start-overlay">
    <div class="exam-start-card">
        <h2>Ready to Start Exam?</h2>
        <p><strong>${exam.examName}</strong></p>
        <p>Duration: <strong>${exam.duration} Minutes</strong></p>
        <div class="exam-rules">
            <strong>Exam Rules:</strong>
            <ul>
                <li>Mandatory full-screen mode.</li>
                <li>Do not switch tabs, windows or applications.</li>
                <li>Do not minimize or exit full-screen.</li>
                <li>Copy, paste and right-click are disabled.</li>
                <li>Leaving the exam counts as a violation.</li>
                <li>3 violations will automatically submit the exam.</li>
                <li>Use the Question Palette to jump between questions any time.</li>
            </ul>
        </div>
        <button type="button" id="startExamBtn">Start Exam</button>
    </div>
</div>

<!-- VIOLATION OVERLAY -->
<div id="violationOverlay" class="violation-overlay">
    <div class="violation-card">
        <h2>Exam Security Warning</h2>
        <p id="violationMessage">You left the secure exam environment.</p>
        <div class="violation-number">Violation: <span id="overlayViolationCount">1</span>/3</div>
        <p>Return to full-screen mode to continue.</p>
        <button type="button" id="returnFullScreenBtn">Return to Full Screen</button>
    </div>
</div>

<!-- CUSTOM MODAL (replaces native alert()/confirm() during the exam) -->
<div id="customModalOverlay" class="custom-modal-overlay">
    <div class="custom-modal-card">
        <h3 id="modalTitle">Submit Exam</h3>
        <p id="modalMessage">Are you sure?</p>
        <div class="custom-modal-actions">
            <button type="button" id="modalCancelBtn">Cancel</button>
            <button type="button" id="modalConfirmBtn">Yes, Submit</button>
        </div>
    </div>
</div>

<!-- EXAM -->
<div id="examContent">

<div class="exam-status-bar">
    <div class="exam-status-name">${exam.examName}</div>
    <div class="exam-status-right">
        <div class="violation-display">Violations: <span id="violationCounter">0</span>/3</div>
        <div class="timer-display" id="timerDisplay">Time Left: <span id="timer"></span></div>
    </div>
</div>

<div class="container">

<div class="fullscreen-banner">
    Secure Exam Mode Active. Do not leave full-screen, switch tabs or applications.
</div>

<div class="examHeader">
    <h2>${exam.examName}</h2>
    <div class="examInfo">
        <p><b>Subject :</b> ${exam.subject.subjectName}</p>
        <p><b>Total Marks :</b> ${exam.totalMarks}</p>
        <p><b>Duration :</b> ${exam.duration} Minutes</p>
        <p><b>Date :</b> ${exam.examDate}</p>
    </div>
</div>

<form id="examForm" action="${pageContext.request.contextPath}/student/submitExam" method="post">

<input type="hidden" name="examId" value="${exam.examId}">
<input type="hidden" id="violationInput" name="violationCount" value="0">

<div class="exam-layout">

  <div class="exam-main">

    <c:forEach items="${examQuestionList}" var="examQuestion" varStatus="count">
      <div class="question-slide" id="qbox-${count.index}" data-qindex="${count.index}" style="display:none;">

        <div class="q-progress-line">Question ${count.count} of ${fn:length(examQuestionList)}</div>
        <div class="questionTitle">Question ${count.count}</div>
        <p class="questionText">${examQuestion.question.questionText}</p>

        <div class="option">
          <input type="radio" id="q${examQuestion.question.questionId}A" name="${examQuestion.question.questionId}" value="A">
          <label for="q${examQuestion.question.questionId}A">${examQuestion.question.optionA}</label>
        </div>
        <div class="option">
          <input type="radio" id="q${examQuestion.question.questionId}B" name="${examQuestion.question.questionId}" value="B">
          <label for="q${examQuestion.question.questionId}B">${examQuestion.question.optionB}</label>
        </div>
        <div class="option">
          <input type="radio" id="q${examQuestion.question.questionId}C" name="${examQuestion.question.questionId}" value="C">
          <label for="q${examQuestion.question.questionId}C">${examQuestion.question.optionC}</label>
        </div>
        <div class="option">
          <input type="radio" id="q${examQuestion.question.questionId}D" name="${examQuestion.question.questionId}" value="D">
          <label for="q${examQuestion.question.questionId}D">${examQuestion.question.optionD}</label>
        </div>

      </div>
    </c:forEach>

    <div class="q-nav-buttons">
      <button type="button" id="prevBtn"><i class="bi bi-arrow-left"></i> Previous</button>
      <button type="button" id="clearBtn"><i class="bi bi-x-circle"></i> Clear Response</button>
      <button type="button" id="markReviewBtn"><i class="bi bi-bookmark-star"></i> Mark for Review &amp; Next</button>
      <button type="button" id="saveNextBtn">Save &amp; Next <i class="bi bi-arrow-right"></i></button>
    </div>

  </div>

  <div class="exam-palette">
    <div class="palette-title">Question Palette</div>
    <div class="palette-grid" id="paletteGrid">
      <c:forEach items="${examQuestionList}" var="examQuestion" varStatus="count">
        <button type="button" class="pal-btn" id="pal-${count.index}" data-qindex="${count.index}">${count.count}</button>
      </c:forEach>
    </div>

    <div class="palette-legend">
      <span><i class="legend-dot" style="background:#adb5bd;"></i> Not Visited</span>
      <span><i class="legend-dot" style="background:#dc3545;"></i> Not Answered</span>
      <span><i class="legend-dot" style="background:#198754;"></i> Answered</span>
      <span><i class="legend-dot" style="background:#6f42c1;"></i> Marked for Review</span>
      <span><i class="legend-dot" style="background:#6f42c1;position:relative;">
        <i style="position:absolute;top:-3px;right:-3px;width:7px;height:7px;background:#198754;border-radius:50%;"></i>
      </i> Answered + Marked</span>
    </div>

    <button type="button" id="finalSubmitBtn" class="submitBtn">Submit Exam</button>
  </div>

</div>

</form>

</div>

</div>

<script>

/* ============ CONFIG ============ */
const MAX_VIOLATIONS = 3;
const VIOLATION_COOLDOWN = 1600;
const TIME_WARNING_SECONDS = 300; // last 5 minutes

/* ============ ELEMENTS ============ */
const duration = Number("${exam.duration}");
let totalSeconds = duration * 60;

const timer = document.getElementById("timer");
const timerDisplay = document.getElementById("timerDisplay");
const examForm = document.getElementById("examForm");
const startExamBtn = document.getElementById("startExamBtn");
const startOverlay = document.getElementById("examStartOverlay");
const violationOverlay = document.getElementById("violationOverlay");
const violationCounter = document.getElementById("violationCounter");
const overlayViolationCount = document.getElementById("overlayViolationCount");
const violationMessage = document.getElementById("violationMessage");
const violationInput = document.getElementById("violationInput");
const returnFullScreenBtn = document.getElementById("returnFullScreenBtn");

const totalQuestions = document.querySelectorAll(".question-slide").length;
const paletteGrid = document.getElementById("paletteGrid");
const prevBtn = document.getElementById("prevBtn");
const clearBtn = document.getElementById("clearBtn");
const markReviewBtn = document.getElementById("markReviewBtn");
const saveNextBtn = document.getElementById("saveNextBtn");
const finalSubmitBtn = document.getElementById("finalSubmitBtn");
const customModalOverlay = document.getElementById("customModalOverlay");
const modalTitle = document.getElementById("modalTitle");
const modalMessage = document.getElementById("modalMessage");
const modalConfirmBtn = document.getElementById("modalConfirmBtn");
const modalCancelBtn = document.getElementById("modalCancelBtn");

/* ============ STATE ============ */
let interval = null;
let examStarted = false;
let submittingExam = false;
let violationCount = 0;
let lastViolationTime = 0;
let switchViolationPending = false;
let returningToFullscreen = false;

let currentIndex = 0;
// status per question: 'not-visited' | 'not-answered' | 'answered' | 'marked' | 'answered-marked'
const qStatus = new Array(totalQuestions).fill("not-visited");

/* ============ CUSTOM MODAL (no native alert/confirm during exam — avoids
   the window "blur" event that native dialogs cause, which would otherwise
   get wrongly flagged as a tab/app switch) ============ */
function showConfirmModal(title, message, confirmLabel, onConfirm) {
    modalTitle.textContent = title;
    modalMessage.textContent = message;
    modalConfirmBtn.textContent = confirmLabel;
    customModalOverlay.style.display = "flex";

    function cleanup() {
        customModalOverlay.style.display = "none";
        modalConfirmBtn.removeEventListener("click", confirmHandler);
        modalCancelBtn.removeEventListener("click", cancelHandler);
    }
    function confirmHandler() { cleanup(); onConfirm(); }
    function cancelHandler() { cleanup(); }

    modalConfirmBtn.addEventListener("click", confirmHandler);
    modalCancelBtn.addEventListener("click", cancelHandler);
}

/* ============ QUESTION NAVIGATION ============ */
function isAnswered(index) {
    const box = document.getElementById("qbox-" + index);
    if (!box) return false;
    return !!box.querySelector('input[type="radio"]:checked');
}

function refreshPaletteButton(index) {
    const btn = document.getElementById("pal-" + index);
    if (!btn) return;
    btn.className = "pal-btn " + qStatus[index];
    if (index === currentIndex) btn.classList.add("current");
}

function refreshAllPalette() {
    for (let i = 0; i < totalQuestions; i++) refreshPaletteButton(i);
}

function goToQuestion(index) {
    if (index < 0 || index >= totalQuestions) return;

    document.querySelectorAll(".question-slide").forEach(function (el) {
        el.style.display = "none";
    });
    const box = document.getElementById("qbox-" + index);
    if (box) box.style.display = "block";

    currentIndex = index;

    if (qStatus[index] === "not-visited") {
        qStatus[index] = "not-answered";
    }

    prevBtn.disabled = (index === 0);
    saveNextBtn.textContent = (index === totalQuestions - 1) ? "Save" : "Save & Next";

    refreshAllPalette();
}

function commitCurrentAnswerStatus(preserveMark) {
    const answered = isAnswered(currentIndex);
    const wasMarked = qStatus[currentIndex] === "marked" || qStatus[currentIndex] === "answered-marked";
    if (preserveMark && wasMarked) {
        qStatus[currentIndex] = answered ? "answered-marked" : "marked";
    } else {
        qStatus[currentIndex] = answered ? "answered" : "not-answered";
    }
}

paletteGrid.addEventListener("click", function (event) {
    const btn = event.target.closest(".pal-btn");
    if (!btn || !examStarted) return;
    commitCurrentAnswerStatus(true);
    goToQuestion(Number(btn.dataset.qindex));
});

prevBtn.addEventListener("click", function () {
    commitCurrentAnswerStatus(true);
    goToQuestion(currentIndex - 1);
});

saveNextBtn.addEventListener("click", function () {
    commitCurrentAnswerStatus(true);
    if (currentIndex < totalQuestions - 1) {
        goToQuestion(currentIndex + 1);
    } else {
        refreshAllPalette();
    }
});

clearBtn.addEventListener("click", function () {
    const box = document.getElementById("qbox-" + currentIndex);
    if (box) {
        box.querySelectorAll('input[type="radio"]').forEach(function (r) { r.checked = false; });
    }
    const wasMarked = qStatus[currentIndex] === "marked" || qStatus[currentIndex] === "answered-marked";
    qStatus[currentIndex] = wasMarked ? "marked" : "not-answered";
    refreshAllPalette();
});

markReviewBtn.addEventListener("click", function () {
    const answered = isAnswered(currentIndex);
    qStatus[currentIndex] = answered ? "answered-marked" : "marked";
    if (currentIndex < totalQuestions - 1) {
        goToQuestion(currentIndex + 1);
    } else {
        refreshAllPalette();
    }
});

finalSubmitBtn.addEventListener("click", function () {
    commitCurrentAnswerStatus(true);
    const unanswered = qStatus.filter(function (s) { return s === "not-answered" || s === "not-visited" || s === "marked"; }).length;

    const message = unanswered > 0
        ? unanswered + " question(s) are unanswered or marked for review. Submit anyway?"
        : "Are you sure you want to submit the exam now?";

    showConfirmModal("Submit Exam", message, "Yes, Submit", function () {
        autoSubmitExam(null);
    });
});

/* ============ TIMER ============ */
function displayTimer() {
    let minutes = Math.floor(totalSeconds / 60);
    let seconds = totalSeconds % 60;
    timer.textContent = minutes + ":" + String(seconds).padStart(2, "0");

    if (totalSeconds <= TIME_WARNING_SECONDS) {
        timerDisplay.classList.add("time-warning");
    }
}

function timerTick() {
    if (!examStarted || submittingExam) return;

    if (totalSeconds <= 0) {
        displayTimer();
        autoSubmitExam("Time is over. Your exam has been submitted automatically.");
        return;
    }

    totalSeconds--;
    displayTimer();
}

displayTimer();

/* ============ FULLSCREEN HELPERS ============ */
function isFullScreen() {
    return !!(document.fullscreenElement || document.webkitFullscreenElement);
}

function enterFullScreen() {
    const element = document.documentElement;
    if (element.requestFullscreen) return element.requestFullscreen();
    if (element.webkitRequestFullscreen) return element.webkitRequestFullscreen();
    return Promise.reject(new Error("Fullscreen API not supported"));
}

function exitFullScreenIfActive() {
    if (!isFullScreen()) return;
    if (document.exitFullscreen) document.exitFullscreen();
    else if (document.webkitExitFullscreen) document.webkitExitFullscreen();
}

/* ============ START EXAM ============ */
startExamBtn.addEventListener("click", async function () {
    try {
        await enterFullScreen();

        startOverlay.style.display = "none";
        examStarted = true;

        totalSeconds = duration * 60;
        displayTimer();

        if (interval !== null) clearInterval(interval);
        interval = setInterval(timerTick, 1000);

        goToQuestion(0);
        refreshAllPalette();

    } catch (error) {
        console.error("Fullscreen failed:", error);
        alert("Full-screen mode is required to start this exam.");
    }
});

/* ============ VIOLATIONS (unchanged behaviour) ============ */
function updateViolationUI() {
    violationCounter.textContent = violationCount;
    overlayViolationCount.textContent = violationCount;
    violationInput.value = violationCount;
}

function registerViolation(reason) {
    if (!examStarted || submittingExam) return;

    const now = Date.now();
    if (now - lastViolationTime < VIOLATION_COOLDOWN) return;
    lastViolationTime = now;

    violationCount++;
    updateViolationUI();

    console.warn("SECURITY VIOLATION #" + violationCount + " : " + reason);

    if (violationCount >= MAX_VIOLATIONS) {
        autoSubmitExam("Maximum security violations reached. Your exam is being submitted automatically.");
        return;
    }

    document.body.classList.add("exam-locked");
    violationOverlay.style.display = "flex";

    violationMessage.textContent = (violationCount === 1)
        ? "Warning: You left the secure exam environment. Do not switch tabs, applications, minimize the browser or exit full-screen mode."
        : "Final Warning: One more security violation will automatically submit your exam.";
}

function handleLeavingExamWindow(reason) {
    if (!examStarted || submittingExam || returningToFullscreen) return;
    if (switchViolationPending) return;

    switchViolationPending = true;
    registerViolation(reason);
    setTimeout(function () { switchViolationPending = false; }, 1300);
}

function handleFullscreenChange() {
    if (!examStarted || submittingExam || returningToFullscreen) return;
    if (!isFullScreen()) handleLeavingExamWindow("You exited full-screen mode.");
}

document.addEventListener("fullscreenchange", handleFullscreenChange);
document.addEventListener("webkitfullscreenchange", handleFullscreenChange);

document.addEventListener("visibilitychange", function () {
    if (!examStarted || submittingExam) return;
    if (document.hidden) {
        handleLeavingExamWindow("You switched tabs, minimized the browser or switched applications.");
    }
});

let windowLostFocus = false;

window.addEventListener("blur", function () {
    if (!examStarted || submittingExam || returningToFullscreen) return;
    windowLostFocus = true;
    setTimeout(function () {
        if (examStarted && !submittingExam && windowLostFocus) {
            handleLeavingExamWindow("The exam window lost focus. Switching applications or windows is not allowed.");
        }
    }, 250);
});

window.addEventListener("focus", function () { windowLostFocus = false; });

returnFullScreenBtn.addEventListener("click", async function () {
    try {
        returningToFullscreen = true;
        if (!isFullScreen()) await enterFullScreen();

        violationOverlay.style.display = "none";
        document.body.classList.remove("exam-locked");
        switchViolationPending = false;
        windowLostFocus = false;

        setTimeout(function () { returningToFullscreen = false; }, 800);

    } catch (error) {
        console.error("Return fullscreen failed:", error);
        alert("You must return to full-screen mode to continue the exam.");
        setTimeout(function () { returningToFullscreen = false; }, 800);
    }
});

/* ============ SUBMIT ============ */
function autoSubmitExam(message) {
    if (submittingExam) return;

    submittingExam = true;
    examStarted = false;
    clearInterval(interval);
    updateViolationUI();

    if (message) alert(message);

    exitFullScreenIfActive();
    examForm.submit();
}

/* ============ SECURITY: right-click / copy-paste / drag / keys (unchanged) ============ */
document.addEventListener("contextmenu", function (event) {
    if (examStarted) event.preventDefault();
});

["copy", "cut", "paste"].forEach(function (eventName) {
    document.addEventListener(eventName, function (event) {
        if (examStarted) event.preventDefault();
    });
});

document.addEventListener("dragstart", function (event) {
    if (examStarted) event.preventDefault();
});

document.addEventListener("keydown", function (event) {
    if (!examStarted) return;

    const key = event.key.toLowerCase();

    if (event.key === "F12") {
        event.preventDefault();
        registerViolation("Developer tools shortcut was attempted.");
        return;
    }

    if (event.ctrlKey && event.shiftKey && (key === "i" || key === "j" || key === "c")) {
        event.preventDefault();
        registerViolation("Developer tools shortcut was attempted.");
        return;
    }

    if (event.ctrlKey && key === "u") {
        event.preventDefault();
        registerViolation("Page source shortcut was attempted.");
        return;
    }

    if (event.ctrlKey && (key === "c" || key === "x" || key === "v" || key === "a")) {
        event.preventDefault();
        return;
    }

    if (event.ctrlKey && (key === "p" || key === "s")) {
        event.preventDefault();
        return;
    }

    /* Keyboard shortcuts for exam navigation (only when exam active) */
    if (event.key === "ArrowRight") { saveNextBtn.click(); }
    if (event.key === "ArrowLeft" && !prevBtn.disabled) { prevBtn.click(); }
});

window.addEventListener("beforeunload", function (event) {
    if (examStarted && !submittingExam) {
        event.preventDefault();
        event.returnValue = "";
    }
});

history.pushState(null, "", window.location.href);

window.addEventListener("popstate", function () {
    if (!examStarted) return;
    history.pushState(null, "", window.location.href);
    registerViolation("Browser back navigation was attempted.");
});

</script>

</body>

</html>
