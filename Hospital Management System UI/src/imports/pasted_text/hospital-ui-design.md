Design a simple, legacy-style, robust Hospital Management System web application UI for a student software project built using JSP and JDBC.

The system should feel like a practical enterprise Java web application: clean, structured, easy to understand, slightly traditional, and developer-friendly. Do not make it too modern, complex, animated, or fancy. The goal is that developers can easily convert the React-style UI into JSP pages using simple HTML, CSS, Bootstrap-like layout, and JDBC backend logic.

Project Context:
This Hospital Management System will help hospitals manage patient information, doctor schedules, appointments, prescriptions, billing, search/filter, and simple dashboard analytics. JSP will be used for dynamic web pages and JDBC will connect the application to the database.

Design Style:
- Legacy but polished hospital software feel
- Robust, simple, practical, and trustworthy
- Light background with clean white/grey panels
- Use hospital-friendly colours: navy blue, teal, light grey, white
- Avoid complex gradients, glassmorphism, heavy animations, or overly modern SaaS effects
- Use simple cards, tables, forms, buttons, tabs, and side navigation
- Make it look like a real internal admin system used by hospital staff
- Keep spacing clean and readable
- Use standard web fonts
- Use simple icons only where useful
- Prioritise usability over decoration

Layout Requirements:
Create a full web app dashboard layout with:
1. Left sidebar navigation
2. Top header bar
3. Main content area
4. Simple footer or system note if needed

Sidebar Menu Items:
- Dashboard
- Doctors
- Patients
- Appointments
- Prescriptions
- Billing
- Search Records
- Admin Settings
- Logout

Pages/Screens to Design:

1. Admin Login Page
Design a simple login screen with:
- System title: Hospital Management System
- Admin Login form
- Username field
- Password field
- Login button
- Small note: JSP + JDBC Based Web Application
Keep it professional and minimal.

2. Dashboard Page
Create simple dashboard cards:
- Total Patients
- Total Doctors
- Today’s Appointments
- Pending Bills
Below the cards, add:
- Recent Appointments table
- Quick Actions section with buttons:
  - Add Patient
  - Add Doctor
  - Book Appointment
  - Generate Bill

3. Doctor Management Page
Create a simple table-based page with:
- Page title: Doctor Management
- Add Doctor button
- Search doctor input
- Table columns:
  - Doctor ID
  - Name
  - Specialisation
  - Phone
  - Availability
  - Action
Actions should include small buttons:
- View
- Edit
- Delete
Also show a simple Add/Edit Doctor form section with:
- Doctor Name
- Specialisation
- Phone Number
- Email
- Available Days
- Submit button

4. Patient Management Page
Create a table-based patient records page with:
- Add Patient button
- Search patient input
- Table columns:
  - Patient ID
  - Name
  - Age
  - Gender
  - Phone
  - Blood Group
  - Action
Add a simple patient form:
- Patient Name
- Age
- Gender dropdown
- Phone
- Address
- Blood Group
- Submit button

5. Appointment Booking Page
Design a very simple appointment booking interface:
- Select Patient
- Select Doctor
- Appointment Date
- Appointment Time
- Reason for Visit
- Book Appointment button
Below the form, show an appointment list table:
- Appointment ID
- Patient Name
- Doctor Name
- Date
- Time
- Status
- Action

6. Prescription Records Page
Design a simple prescription page:
- Select Patient
- Select Doctor
- Diagnosis
- Medicine Name
- Dosage
- Instructions
- Save Prescription button
Below it, show a prescription history table:
- Prescription ID
- Patient
- Doctor
- Date
- Diagnosis
- Action

7. Billing System Page
Create a dummy billing interface:
- Select Patient
- Consultation Fee
- Medicine Cost
- Service Charge
- Total Amount
- Payment Status dropdown: Paid / Unpaid
- Generate Bill button
Show billing records table:
- Bill ID
- Patient Name
- Total Amount
- Payment Status
- Date
- Action
Make it clear that this is a dummy payment system, not real payment integration.

8. Search / Filter Page
Create a simple search records page:
- Search by Patient ID / Name / Doctor / Date
- Filter dropdown for record type:
  - Patient
  - Appointment
  - Prescription
  - Billing
- Search button
Below, show a generic search result table.

UI Component Guidelines:
- Use simple rectangular cards with light shadows or borders
- Use standard table layouts with clear column headers
- Use simple form fields with labels above inputs
- Use primary buttons in navy/teal
- Use secondary buttons in grey
- Use danger buttons in red for delete
- Keep all pages highly readable
- Avoid complex modals unless necessary
- Make design easy for JSP developers to split into pages like dashboard.jsp, doctors.jsp, patients.jsp, appointments.jsp, prescriptions.jsp, billing.jsp, search.jsp

Developer-Friendly Requirements:
- Use reusable layout structure
- Keep component names simple
- Use clear sections and headings
- Avoid advanced React-only interactions
- Avoid complicated state-heavy UI
- Design should be easily convertible into JSP with JDBC database operations
- Keep tables, forms, and buttons straightforward

Final Output:
Generate a complete clickable UI prototype with all main screens. The design should feel like a simple but complete hospital admin system suitable for a university software project using JSP and JDBC.