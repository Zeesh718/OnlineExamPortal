# Online Exam Portal — V3

This is an incremental upgrade of the existing Spring MVC + Hibernate + MySQL
Online Exam Portal. It is a **separate project** — the original
`OnlineExamPortal_v2_Enhanced` is untouched.

## What changed so far

**1. Auto-generated Student ID + Student ID login**

- `User` entity now has a `studentId` column (unique, nullable — only students get one).
- On registration, a Student ID is auto-generated in the format `STD<year><5-digit-sequence>`,
  e.g. `STD202600001`. Sequence resets each year, based on the highest existing sequence
  for that year (works correctly even with deletions/gaps).
- The generated Student ID is:
  - shown on-screen right after registration (login page),
  - emailed to the student in the welcome email,
  - shown in the student dashboard header,
  - visible to the admin in Manage Students.
- Login now accepts **Student ID or Email** (`loginId` field) + password.
  Students should use their Student ID; the admin account (which has no
  Student ID) keeps working via email — nothing breaks for the admin login.

**2. Exam-taking screen redesign (question palette)**

- One question shown at a time instead of a long scrolling page.
- Question Palette sidebar: numbered buttons color-coded
  Not Visited (grey) / Not Answered (red) / Answered (green) / Marked for Review (purple),
  with a green dot for "answered + marked". Click any number to jump straight there.
- Save & Next, Previous, Mark for Review & Next, Clear Response buttons.
- Left/Right arrow keys also navigate between questions.
- Last-5-minutes timer warning (timer turns red and pulses).
- Submit confirms if questions are left unanswered/marked, showing the count.
- All existing anti-cheat logic (mandatory fullscreen, tab/window-switch detection,
  dev-tools/copy-paste/right-click blocking, 3-violation auto-submit, back-button
  trap) is untouched — this was already implemented in the base project and works
  exactly as before.
- No backend/controller changes were needed for this — the same hidden radio
  inputs post to the same `/student/submitExam` endpoint, so nothing else broke.

**3. Result page redesign (with question-wise analysis)**

- New `StudentAnswer` table added (new, additive — doesn't touch existing `Result` table)
  that stores every selected option per question per attempt.
- `submitExam` now saves these rows alongside the existing aggregate `Result` row —
  old scoring logic is completely unchanged, just also records per-question detail now.
- Result page redesigned: score summary cards, Pass/Fail + Grade badge, a doughnut
  chart (Chart.js) of correct/wrong/skipped, and a full question-wise breakdown
  showing your answer vs. the correct answer for every question you got wrong or skipped.
- Added a new `/student/viewResult/{resultId}` route (with ownership check) so students
  can revisit the full breakdown of *any past* result from "My Results" — previously the
  detailed result was only visible once, right after submitting.

**4. Admin analytics dashboard**

- Dashboard now shows real stats: Total/Active Students, Total Subjects, Total Exams,
  Today's Exams, Total Questions, Completed Exam Attempts, Average Score.
- Pass/Fail doughnut chart computed from all recorded results.
- Recent Results and Recent Registrations panels.
- All existing quick-action links (Manage Students/Subjects/Exams/Questions) kept as-is.

**5. Bug fixes + Student Dashboard redesign (based on live testing feedback)**

- **Critical fix:** the exam Submit button was using the browser's native `confirm()`
  dialog. Native dialogs fire a window `blur` event — the anti-cheat logic was
  reading that as "student switched tabs/apps" and incrementing the violation
  counter *during a normal submit*. Replaced all native `alert()`/`confirm()` calls
  during an active exam with a custom in-page modal (no window blur, so no false
  violations). Same fix applied to the "return to fullscreen" fallback message.
- Made the "Answered + Marked for Review" palette state clearly distinguishable —
  it's now purple with a bold white checkmark badge (was a barely-visible dot before).
- **Student Dashboard** completely redesigned: profile completion bar, stat cards
  (Exams Completed, Available Exams, Average Score, Highest Score), a
  Lowest/Average/Highest score bar chart, Upcoming Exams + Recent Results panels,
  and 3 clean quick-action cards (Available Exams / My Results / My Profile).
  The old "Logout" card was removed from here — logout already exists as a proper
  link in the header, a full-width colored button for it didn't make sense.
- Admin dashboard's Quick Actions cards: swapped emoji icons for proper Bootstrap
  Icons for a more professional look.

## Known open item

Exception handling (`GlobalExceptionHandler` + `common/error.jsp`) config looks
structurally correct (`@ControllerAdvice`, component-scan, `mvc:annotation-driven`
are all in place) and wasn't touched in this project. If it's still not showing your
custom error page for a specific action, tell me exactly which action triggers it
(e.g. "delete a subject that's used in an exam") so it can be reproduced and fixed —
that's different from the alert()/confirm() issue above, which is now fixed.

No existing feature was removed in any of these changes. Forgot-password/OTP flow,
exam creation, PDF download, etc. are untouched.

## Known limitation (documented, not hidden)

Student ID generation reads existing students and computes the next sequence
in application code (not a DB sequence). This is correct and safe for
normal/college-project traffic, but not race-condition-safe under heavy
simultaneous registrations. If this ever needs to handle real concurrent
signups, swap it for a DB sequence or a unique-constraint-with-retry approach.

## Not done yet

This project's original request asked for a huge list of features (premium
landing page, AI performance analysis, anti-cheating monitor, certificates,
badges, live exam monitor, heatmaps, etc.). Building all of that correctly is
a multi-week effort, not a single pass — see the chat for the phased plan.
This README will be updated as later phases land.

## Setup

Same as before: MySQL running locally, DB `online_exam_portal`
(`root`/`root` — see `src/main/webapp/WEB-INF/spring-hibernate.xml`),
`hibernate.hbm2ddl.auto=update` so the new `studentId` column will be added
automatically on first run. Mail credentials are in
`src/main/resources/application.properties`.
