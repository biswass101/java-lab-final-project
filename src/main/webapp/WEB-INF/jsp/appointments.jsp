<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="fragments/layout-start.jspf" %>

<div class="space-y-6">
  <div class="bg-white border border-slate-200 rounded">
    <div class="px-4 py-3 border-b border-slate-200 font-medium">Book New Appointment</div>
    <form method="post" action="${pageContext.request.contextPath}/app/appointments" class="p-4 grid grid-cols-1 md:grid-cols-2 gap-4">
      <div><label class="block text-sm text-slate-600 mb-1">Select Patient</label><select class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="patientId" required><option value="">-- Choose Patient --</option><c:forEach items="${patients}" var="p"><option value="${p.id}">${p.patientCode} - ${p.name}</option></c:forEach></select></div>
      <div><label class="block text-sm text-slate-600 mb-1">Select Doctor</label><select class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="doctorId" required><option value="">-- Choose Doctor --</option><c:forEach items="${doctors}" var="d"><option value="${d.id}">${d.doctorCode} - ${d.name} (${d.specialization})</option></c:forEach></select></div>
      <div><label class="block text-sm text-slate-600 mb-1">Appointment Date</label><input class="w-full rounded border border-slate-300 px-3 py-2 text-sm" type="date" name="appointmentDate" required /></div>
      <div><label class="block text-sm text-slate-600 mb-1">Appointment Time</label><input class="w-full rounded border border-slate-300 px-3 py-2 text-sm" type="time" name="appointmentTime" required /></div>
      <div><label class="block text-sm text-slate-600 mb-1">Status</label><select class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="status"><option>Pending</option><option>Confirmed</option><option>Completed</option><option>Cancelled</option></select></div>
      <div class="md:col-span-2"><label class="block text-sm text-slate-600 mb-1">Reason for Visit</label><textarea class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="reason" rows="2"></textarea></div>
      <div><button class="bg-[#0b2545] hover:bg-[#15345c] text-white rounded px-4 py-2 text-sm" type="submit">Book Appointment</button></div>
    </form>
  </div>

  <div class="bg-white border border-slate-200 rounded overflow-hidden">
    <div class="px-4 py-3 border-b border-slate-200 flex flex-wrap items-center justify-between gap-2">
      <div class="font-medium">Appointment List</div>
      <div class="flex gap-2">
        <form class="flex gap-2" onsubmit="return false;">
          <input id="appointmentSearchInput" oninput="filterAppointmentRows()" class="w-64 rounded border border-slate-300 px-3 py-2 text-sm" placeholder="Search appointment..." />
          <button class="bg-[#1ca39a] text-white rounded px-3 py-2 text-sm" type="button" onclick="filterAppointmentRows()">Search</button>
        </form>
      </div>
    </div>
    <div class="overflow-x-auto">
      <table class="w-full text-sm">
        <thead class="bg-slate-50 text-slate-600"><tr><th class="text-left p-3">Appt ID</th><th class="text-left p-3">Patient</th><th class="text-left p-3">Doctor</th><th class="text-left p-3">Date</th><th class="text-left p-3">Time</th><th class="text-left p-3">Status</th><th class="text-left p-3">Action</th></tr></thead>
        <tbody id="appointmentTableBody">
        <c:forEach items="${appointments}" var="a">
          <tr class="border-t border-slate-100 appointment-row" data-search="${a.appointmentCode} ${a.patientName} ${a.doctorName} ${a.appointmentDate} ${a.appointmentTime} ${a.status}">
            <td class="p-3">${a.appointmentCode}</td>
            <td class="p-3">${a.patientName}</td>
            <td class="p-3">${a.doctorName}</td>
            <td class="p-3">${a.appointmentDate}</td>
            <td class="p-3">${a.appointmentTime}</td>
            <td class="p-3"><span class="inline-flex px-2 py-1 rounded text-xs ${a.status == 'Confirmed' || a.status == 'Completed' ? 'bg-emerald-100 text-emerald-700' : (a.status == 'Pending' ? 'bg-amber-100 text-amber-700' : 'bg-rose-100 text-rose-700')}">${a.status}</span></td>
            <td class="p-3">
              <div class="flex flex-wrap items-center gap-1.5">
                <button type="button" onclick="openAppointmentViewModal(this)" class="bg-slate-100 hover:bg-slate-200 text-slate-700 rounded px-2.5 py-1.5 text-xs inline-flex items-center gap-1"><i class="bi bi-eye"></i><span>View</span></button>
                <button type="button" onclick="openAppointmentEditModal(this)" class="bg-blue-600 hover:bg-blue-700 text-white rounded px-2.5 py-1.5 text-xs inline-flex items-center gap-1"><i class="bi bi-pencil"></i><span>Edit</span></button>
                <button type="button" onclick="openAppointmentDeleteModal(this)" class="bg-rose-600 hover:bg-rose-700 text-white rounded px-2.5 py-1.5 text-xs inline-flex items-center gap-1"><i class="bi bi-trash"></i><span>Delete</span></button>
              </div>
              <input type="hidden" class="a-id" value="${a.id}" />
              <input type="hidden" class="a-code" value="${a.appointmentCode}" />
              <input type="hidden" class="a-patient-id" value="${a.patientId}" />
              <input type="hidden" class="a-doctor-id" value="${a.doctorId}" />
              <input type="hidden" class="a-patient" value="${a.patientName}" />
              <input type="hidden" class="a-doctor" value="${a.doctorName}" />
              <input type="hidden" class="a-date" value="${a.appointmentDate}" />
              <input type="hidden" class="a-time" value="${a.appointmentTime}" />
              <input type="hidden" class="a-status" value="${a.status}" />
              <input type="hidden" class="a-reason" value="${a.reason}" />
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</div>

<div id="appointmentViewModal" class="fixed inset-0 z-[9999] hidden">
  <div class="absolute inset-0 bg-black/40 backdrop-blur-sm" onclick="closeAppointmentModal('appointmentViewModal')"></div>
  <div class="relative z-10 flex min-h-full w-full items-center justify-center p-2 md:p-4">
    <div class="bg-white rounded-lg shadow-xl w-full max-w-4xl max-h-[96vh] flex flex-col">
      <div class="px-5 py-3 border-b border-slate-200 flex items-center justify-between">
        <h3 class="font-semibold text-slate-800">Appointment Details</h3>
        <button type="button" onclick="closeAppointmentModal('appointmentViewModal')" class="text-slate-500 hover:text-slate-700"><i class="bi bi-x-lg"></i></button>
      </div>
      <div class="p-5 grid grid-cols-1 md:grid-cols-2 gap-3 text-sm overflow-y-auto">
        <div><div class="text-slate-500">Appointment ID</div><div id="avCode" class="font-medium"></div></div>
        <div><div class="text-slate-500">Patient</div><div id="avPatient" class="font-medium"></div></div>
        <div><div class="text-slate-500">Doctor</div><div id="avDoctor" class="font-medium"></div></div>
        <div><div class="text-slate-500">Date</div><div id="avDate" class="font-medium"></div></div>
        <div><div class="text-slate-500">Time</div><div id="avTime" class="font-medium"></div></div>
        <div><div class="text-slate-500">Status</div><div id="avStatus" class="font-medium"></div></div>
        <div class="md:col-span-2"><div class="text-slate-500">Reason</div><div id="avReason" class="font-medium"></div></div>
      </div>
      <div class="px-5 py-3 border-t border-slate-200 text-right"><button type="button" onclick="closeAppointmentModal('appointmentViewModal')" class="bg-slate-100 hover:bg-slate-200 text-slate-700 rounded px-4 py-2 text-sm">Close</button></div>
    </div>
  </div>
</div>

<div id="appointmentEditModal" class="fixed inset-0 z-[9999] hidden">
  <div class="absolute inset-0 bg-black/40 backdrop-blur-sm" onclick="closeAppointmentModal('appointmentEditModal')"></div>
  <div class="relative z-10 flex min-h-full w-full items-center justify-center p-2 md:p-4">
    <div class="bg-white rounded-lg shadow-xl w-full max-w-5xl max-h-[96vh] flex flex-col">
      <div class="px-5 py-3 border-b border-slate-200 flex items-center justify-between">
        <h3 class="font-semibold text-slate-800">Edit Appointment</h3>
        <button type="button" onclick="closeAppointmentModal('appointmentEditModal')" class="text-slate-500 hover:text-slate-700"><i class="bi bi-x-lg"></i></button>
      </div>
      <form method="post" action="${pageContext.request.contextPath}/app/appointments" class="p-5 grid grid-cols-1 md:grid-cols-2 gap-3 content-start overflow-y-auto">
        <input type="hidden" name="action" value="update" />
        <input type="hidden" id="aeId" name="id" />
        <div><label class="block text-sm text-slate-600 mb-1">Select Patient</label><select id="aePatientId" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="patientId" required><option value="">-- Choose Patient --</option><c:forEach items="${patients}" var="p"><option value="${p.id}">${p.patientCode} - ${p.name}</option></c:forEach></select></div>
        <div><label class="block text-sm text-slate-600 mb-1">Select Doctor</label><select id="aeDoctorId" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="doctorId" required><option value="">-- Choose Doctor --</option><c:forEach items="${doctors}" var="d"><option value="${d.id}">${d.doctorCode} - ${d.name} (${d.specialization})</option></c:forEach></select></div>
        <div><label class="block text-sm text-slate-600 mb-1">Appointment Date</label><input id="aeDate" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" type="date" name="appointmentDate" required /></div>
        <div><label class="block text-sm text-slate-600 mb-1">Appointment Time</label><input id="aeTime" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" type="time" name="appointmentTime" required /></div>
        <div><label class="block text-sm text-slate-600 mb-1">Status</label><select id="aeStatus" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="status"><option>Pending</option><option>Confirmed</option><option>Completed</option><option>Cancelled</option></select></div>
        <div class="md:col-span-2"><label class="block text-sm text-slate-600 mb-1">Reason for Visit</label><textarea id="aeReason" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="reason" rows="2"></textarea></div>
        <div class="md:col-span-2 flex items-center justify-end gap-2 pt-2 border-t border-slate-100 sticky bottom-0 bg-white">
          <button type="button" onclick="closeAppointmentModal('appointmentEditModal')" class="bg-slate-100 hover:bg-slate-200 text-slate-700 rounded px-4 py-2 text-sm">Cancel</button>
          <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white rounded px-4 py-2 text-sm">Update</button>
        </div>
      </form>
    </div>
  </div>
</div>

<div id="appointmentDeleteModal" class="fixed inset-0 z-[9999] hidden">
  <div class="absolute inset-0 bg-black/40 backdrop-blur-sm" onclick="closeAppointmentModal('appointmentDeleteModal')"></div>
  <div class="relative z-10 flex min-h-full w-full items-center justify-center p-4">
    <div class="bg-white rounded-lg shadow-xl w-full max-w-md">
      <div class="px-5 py-4 border-b border-slate-200 flex items-center gap-2">
        <div class="w-8 h-8 rounded-full bg-rose-100 text-rose-700 flex items-center justify-center"><i class="bi bi-exclamation-triangle"></i></div>
        <h3 class="font-semibold text-slate-800">Delete Appointment?</h3>
      </div>
      <div class="p-5 text-sm text-slate-600">This action will permanently remove <span id="adCode" class="font-semibold text-slate-800"></span>.</div>
      <form method="post" action="${pageContext.request.contextPath}/app/appointments" class="px-5 pb-5 flex items-center justify-end gap-2">
        <input type="hidden" name="action" value="delete" />
        <input type="hidden" id="adId" name="id" />
        <button type="button" onclick="closeAppointmentModal('appointmentDeleteModal')" class="bg-slate-100 hover:bg-slate-200 text-slate-700 rounded px-4 py-2 text-sm">Cancel</button>
        <button type="submit" class="bg-rose-600 hover:bg-rose-700 text-white rounded px-4 py-2 text-sm">Delete</button>
      </form>
    </div>
  </div>
</div>

<script>
  function getAppointmentData(button) {
    const row = button.closest('tr');
    return {
      id: row.querySelector('.a-id').value,
      code: row.querySelector('.a-code').value,
      patientId: row.querySelector('.a-patient-id').value,
      doctorId: row.querySelector('.a-doctor-id').value,
      patient: row.querySelector('.a-patient').value,
      doctor: row.querySelector('.a-doctor').value,
      date: row.querySelector('.a-date').value,
      time: row.querySelector('.a-time').value,
      status: row.querySelector('.a-status').value,
      reason: row.querySelector('.a-reason').value
    };
  }

  function showAppointmentModal(id) { document.getElementById(id).classList.remove('hidden'); }
  function closeAppointmentModal(id) { document.getElementById(id).classList.add('hidden'); }

  function openAppointmentViewModal(button) {
    const a = getAppointmentData(button);
    document.getElementById('avCode').textContent = a.code || '-';
    document.getElementById('avPatient').textContent = a.patient || '-';
    document.getElementById('avDoctor').textContent = a.doctor || '-';
    document.getElementById('avDate').textContent = a.date || '-';
    document.getElementById('avTime').textContent = a.time || '-';
    document.getElementById('avStatus').textContent = a.status || '-';
    document.getElementById('avReason').textContent = a.reason || '-';
    showAppointmentModal('appointmentViewModal');
  }

  function openAppointmentEditModal(button) {
    const a = getAppointmentData(button);
    document.getElementById('aeId').value = a.id;
    document.getElementById('aePatientId').value = a.patientId;
    document.getElementById('aeDoctorId').value = a.doctorId;
    document.getElementById('aeDate').value = a.date;
    document.getElementById('aeTime').value = a.time;
    document.getElementById('aeStatus').value = a.status;
    document.getElementById('aeReason').value = a.reason;
    showAppointmentModal('appointmentEditModal');
  }

  function openAppointmentDeleteModal(button) {
    const a = getAppointmentData(button);
    document.getElementById('adId').value = a.id;
    document.getElementById('adCode').textContent = a.code;
    showAppointmentModal('appointmentDeleteModal');
  }

  function filterAppointmentRows() {
    const q = (document.getElementById('appointmentSearchInput').value || '').toLowerCase().trim();
    const rows = document.querySelectorAll('#appointmentTableBody .appointment-row');
    rows.forEach(function (row) {
      const hay = (row.getAttribute('data-search') || '').toLowerCase();
      row.style.display = hay.includes(q) ? '' : 'none';
    });
  }

  document.addEventListener('DOMContentLoaded', filterAppointmentRows);
</script>

<%@ include file="fragments/layout-end.jspf" %>
