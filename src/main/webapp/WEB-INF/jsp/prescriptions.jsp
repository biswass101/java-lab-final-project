<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="fragments/layout-start.jspf" %>

<div class="space-y-6">
  <div class="bg-white border border-slate-200 rounded">
    <div class="px-4 py-3 border-b border-slate-200 font-medium">New Prescription</div>
    <form method="post" action="${pageContext.request.contextPath}/app/prescriptions" class="p-4 grid grid-cols-1 md:grid-cols-2 gap-4">
      <div><label class="block text-sm text-slate-600 mb-1">Select Patient</label><select class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="patientId" required><option value="">-- Choose Patient --</option><c:forEach items="${patients}" var="p"><option value="${p.id}">${p.patientCode} - ${p.name}</option></c:forEach></select></div>
      <div><label class="block text-sm text-slate-600 mb-1">Select Doctor</label><select class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="doctorId" required><option value="">-- Choose Doctor --</option><c:forEach items="${doctors}" var="d"><option value="${d.id}">${d.doctorCode} - ${d.name}</option></c:forEach></select></div>
      <div><label class="block text-sm text-slate-600 mb-1">Date</label><input class="w-full rounded border border-slate-300 px-3 py-2 text-sm" type="date" name="prescriptionDate" required /></div>
      <div class="md:col-span-2"><label class="block text-sm text-slate-600 mb-1">Diagnosis</label><input class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="diagnosis" required /></div>

      <div class="md:col-span-2">
        <div class="flex items-center justify-between mb-2">
          <label class="block text-sm text-slate-600">Medicines & Dosage</label>
          <button type="button" onclick="addMedicineRow('createMedicineRows')" class="text-xs bg-slate-100 hover:bg-slate-200 text-slate-700 px-2 py-1 rounded">+ Add Medicine</button>
        </div>
        <div id="createMedicineRows" class="space-y-2"></div>
      </div>

      <div class="md:col-span-2"><label class="block text-sm text-slate-600 mb-1">Instructions</label><textarea class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="instructions" rows="3"></textarea></div>
      <div><button class="bg-[#0b2545] hover:bg-[#15345c] text-white rounded px-4 py-2 text-sm" type="submit">Save Prescription</button></div>
    </form>
  </div>

  <div class="bg-white border border-slate-200 rounded overflow-hidden">
    <div class="px-4 py-3 border-b border-slate-200 flex flex-wrap items-center justify-between gap-2">
      <div class="font-medium">Prescription History</div>
      <div class="flex gap-2">
        <input id="prescriptionSearchInput" oninput="filterPrescriptionRows()" class="w-64 rounded border border-slate-300 px-3 py-2 text-sm" placeholder="Search prescription..." />
      </div>
    </div>
    <div class="overflow-x-auto">
      <table class="w-full text-sm">
        <thead class="bg-slate-50 text-slate-600"><tr><th class="text-left p-3">Prescription ID</th><th class="text-left p-3">Patient</th><th class="text-left p-3">Doctor</th><th class="text-left p-3">Date</th><th class="text-left p-3">Diagnosis</th><th class="text-left p-3">Medicines</th><th class="text-left p-3">Action</th></tr></thead>
        <tbody id="prescriptionTableBody">
        <c:forEach items="${prescriptions}" var="r">
          <tr class="border-t border-slate-100 prescription-row" data-search="${r.prescriptionCode} ${r.patientName} ${r.doctorName} ${r.prescriptionDate} ${r.diagnosis} ${r.medicinesSummary}">
            <td class="p-3">${r.prescriptionCode}</td>
            <td class="p-3">${r.patientName}</td>
            <td class="p-3">${r.doctorName}</td>
            <td class="p-3">${r.prescriptionDate}</td>
            <td class="p-3">${r.diagnosis}</td>
            <td class="p-3">${r.medicinesSummary}</td>
            <td class="p-3">
              <div class="flex flex-wrap items-center gap-1.5">
                <button type="button" onclick="openPrescriptionViewModal(this)" class="bg-slate-100 hover:bg-slate-200 text-slate-700 rounded px-2.5 py-1.5 text-xs inline-flex items-center gap-1"><i class="bi bi-eye"></i><span>View</span></button>
                <button type="button" onclick="openPrescriptionEditModal(this)" class="bg-blue-600 hover:bg-blue-700 text-white rounded px-2.5 py-1.5 text-xs inline-flex items-center gap-1"><i class="bi bi-pencil"></i><span>Edit</span></button>
                <a href="${pageContext.request.contextPath}/app/prescriptions/print?id=${r.id}" target="_blank" class="bg-emerald-600 hover:bg-emerald-700 text-white rounded px-2.5 py-1.5 text-xs inline-flex items-center gap-1"><i class="bi bi-printer"></i><span>Print</span></a>
                <button type="button" onclick="openPrescriptionDeleteModal(this)" class="bg-rose-600 hover:bg-rose-700 text-white rounded px-2.5 py-1.5 text-xs inline-flex items-center gap-1"><i class="bi bi-trash"></i><span>Delete</span></button>
              </div>
              <input type="hidden" class="pr-id" value="${r.id}" />
              <input type="hidden" class="pr-code" value="${r.prescriptionCode}" />
              <input type="hidden" class="pr-patient-id" value="${r.patientId}" />
              <input type="hidden" class="pr-doctor-id" value="${r.doctorId}" />
              <input type="hidden" class="pr-patient" value="${r.patientName}" />
              <input type="hidden" class="pr-doctor" value="${r.doctorName}" />
              <input type="hidden" class="pr-date" value="${r.prescriptionDate}" />
              <input type="hidden" class="pr-diagnosis" value="${r.diagnosis}" />
              <input type="hidden" class="pr-instructions" value="${r.instructions}" />
              <input type="hidden" class="pr-items" value="${r.itemsBlob}" />
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</div>

<div id="prescriptionViewModal" class="fixed inset-0 z-[9999] hidden">
  <div class="absolute inset-0 bg-black/40 backdrop-blur-sm" onclick="closePrescriptionModal('prescriptionViewModal')"></div>
  <div class="relative z-10 flex min-h-full w-full items-center justify-center p-2 md:p-4">
    <div class="bg-white rounded-lg shadow-xl w-full max-w-4xl max-h-[96vh] flex flex-col">
      <div class="px-5 py-3 border-b border-slate-200 flex items-center justify-between">
        <h3 class="font-semibold text-slate-800">Prescription Details</h3>
        <button type="button" onclick="closePrescriptionModal('prescriptionViewModal')" class="text-slate-500 hover:text-slate-700"><i class="bi bi-x-lg"></i></button>
      </div>
      <div class="p-5 space-y-3 overflow-y-auto text-sm">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
          <div><div class="text-slate-500">Prescription ID</div><div id="rvCode" class="font-medium"></div></div>
          <div><div class="text-slate-500">Date</div><div id="rvDate" class="font-medium"></div></div>
          <div><div class="text-slate-500">Patient</div><div id="rvPatient" class="font-medium"></div></div>
          <div><div class="text-slate-500">Doctor</div><div id="rvDoctor" class="font-medium"></div></div>
          <div class="md:col-span-2"><div class="text-slate-500">Diagnosis</div><div id="rvDiagnosis" class="font-medium"></div></div>
        </div>
        <div>
          <div class="text-slate-500 mb-1">Medicines</div>
          <div id="rvMedicineRows" class="space-y-1"></div>
        </div>
        <div><div class="text-slate-500">Instructions</div><div id="rvInstructions" class="font-medium"></div></div>
      </div>
      <div class="px-5 py-3 border-t border-slate-200 text-right"><button type="button" onclick="closePrescriptionModal('prescriptionViewModal')" class="bg-slate-100 hover:bg-slate-200 text-slate-700 rounded px-4 py-2 text-sm">Close</button></div>
    </div>
  </div>
</div>

<div id="prescriptionEditModal" class="fixed inset-0 z-[9999] hidden">
  <div class="absolute inset-0 bg-black/40 backdrop-blur-sm" onclick="closePrescriptionModal('prescriptionEditModal')"></div>
  <div class="relative z-10 flex min-h-full w-full items-center justify-center p-2 md:p-4">
    <div class="bg-white rounded-lg shadow-xl w-full max-w-5xl max-h-[96vh] flex flex-col">
      <div class="px-5 py-3 border-b border-slate-200 flex items-center justify-between">
        <h3 class="font-semibold text-slate-800">Edit Prescription</h3>
        <button type="button" onclick="closePrescriptionModal('prescriptionEditModal')" class="text-slate-500 hover:text-slate-700"><i class="bi bi-x-lg"></i></button>
      </div>
      <form method="post" action="${pageContext.request.contextPath}/app/prescriptions" class="p-5 grid grid-cols-1 md:grid-cols-2 gap-3 content-start overflow-y-auto">
        <input type="hidden" name="action" value="update" />
        <input type="hidden" id="reId" name="id" />
        <div><label class="block text-sm text-slate-600 mb-1">Select Patient</label><select id="rePatientId" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="patientId" required><option value="">-- Choose Patient --</option><c:forEach items="${patients}" var="p"><option value="${p.id}">${p.patientCode} - ${p.name}</option></c:forEach></select></div>
        <div><label class="block text-sm text-slate-600 mb-1">Select Doctor</label><select id="reDoctorId" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="doctorId" required><option value="">-- Choose Doctor --</option><c:forEach items="${doctors}" var="d"><option value="${d.id}">${d.doctorCode} - ${d.name}</option></c:forEach></select></div>
        <div><label class="block text-sm text-slate-600 mb-1">Date</label><input id="reDate" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" type="date" name="prescriptionDate" required /></div>
        <div class="md:col-span-2"><label class="block text-sm text-slate-600 mb-1">Diagnosis</label><input id="reDiagnosis" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="diagnosis" required /></div>
        <div class="md:col-span-2">
          <div class="flex items-center justify-between mb-2">
            <label class="block text-sm text-slate-600">Medicines & Dosage</label>
            <button type="button" onclick="addMedicineRow('editMedicineRows')" class="text-xs bg-slate-100 hover:bg-slate-200 text-slate-700 px-2 py-1 rounded">+ Add Medicine</button>
          </div>
          <div id="editMedicineRows" class="space-y-2"></div>
        </div>
        <div class="md:col-span-2"><label class="block text-sm text-slate-600 mb-1">Instructions</label><textarea id="reInstructions" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="instructions" rows="3"></textarea></div>
        <div class="md:col-span-2 flex items-center justify-end gap-2 pt-2 border-t border-slate-100 sticky bottom-0 bg-white">
          <button type="button" onclick="closePrescriptionModal('prescriptionEditModal')" class="bg-slate-100 hover:bg-slate-200 text-slate-700 rounded px-4 py-2 text-sm">Cancel</button>
          <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white rounded px-4 py-2 text-sm">Update</button>
        </div>
      </form>
    </div>
  </div>
</div>

<div id="prescriptionDeleteModal" class="fixed inset-0 z-[9999] hidden">
  <div class="absolute inset-0 bg-black/40 backdrop-blur-sm" onclick="closePrescriptionModal('prescriptionDeleteModal')"></div>
  <div class="relative z-10 flex min-h-full w-full items-center justify-center p-4">
    <div class="bg-white rounded-lg shadow-xl w-full max-w-md">
      <div class="px-5 py-4 border-b border-slate-200 flex items-center gap-2">
        <div class="w-8 h-8 rounded-full bg-rose-100 text-rose-700 flex items-center justify-center"><i class="bi bi-exclamation-triangle"></i></div>
        <h3 class="font-semibold text-slate-800">Delete Prescription?</h3>
      </div>
      <div class="p-5 text-sm text-slate-600">This action will permanently remove <span id="rdCode" class="font-semibold text-slate-800"></span>.</div>
      <form method="post" action="${pageContext.request.contextPath}/app/prescriptions" class="px-5 pb-5 flex items-center justify-end gap-2">
        <input type="hidden" name="action" value="delete" />
        <input type="hidden" id="rdId" name="id" />
        <button type="button" onclick="closePrescriptionModal('prescriptionDeleteModal')" class="bg-slate-100 hover:bg-slate-200 text-slate-700 rounded px-4 py-2 text-sm">Cancel</button>
        <button type="submit" class="bg-rose-600 hover:bg-rose-700 text-white rounded px-4 py-2 text-sm">Delete</button>
      </form>
    </div>
  </div>
</div>

<script>
  function medicineRowHtml(medicine, dosage) {
    const med = medicine || '';
    const dos = dosage || '';
    return '<div class="grid grid-cols-1 md:grid-cols-2 gap-2 medicine-row">' +
      '<input class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="medicineName[]" placeholder="Medicine Name" value="' + escapeHtml(med) + '" required />' +
      '<div class="flex gap-2">' +
      '<input class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="dosage[]" placeholder="Dosage" value="' + escapeHtml(dos) + '" />' +
      '<button type="button" onclick="removeMedicineRow(this)" class="shrink-0 px-2 py-2 rounded bg-rose-50 text-rose-700 border border-rose-200"><i class="bi bi-x-lg"></i></button>' +
      '</div>' +
      '</div>';
  }

  function escapeHtml(v) {
    return (v || '').replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/\"/g, '&quot;').replace(/'/g, '&#39;');
  }

  function addMedicineRow(containerId, medicine, dosage) {
    const wrap = document.getElementById(containerId);
    wrap.insertAdjacentHTML('beforeend', medicineRowHtml(medicine, dosage));
  }

  function removeMedicineRow(btn) {
    const wrap = btn.closest('.medicine-row').parentElement;
    btn.closest('.medicine-row').remove();
    if (!wrap.querySelector('.medicine-row')) {
      addMedicineRow(wrap.id);
    }
  }

  function parseItemsBlob(blob) {
    const out = [];
    if (!blob) return out;
    blob.split('##').forEach(function (row) {
      if (!row) return;
      const p = row.split('||');
      out.push({ medicine: p[0] || '', dosage: p[1] || '' });
    });
    return out;
  }

  function getPrescriptionData(button) {
    const row = button.closest('tr');
    return {
      id: row.querySelector('.pr-id').value,
      code: row.querySelector('.pr-code').value,
      patientId: row.querySelector('.pr-patient-id').value,
      doctorId: row.querySelector('.pr-doctor-id').value,
      patient: row.querySelector('.pr-patient').value,
      doctor: row.querySelector('.pr-doctor').value,
      date: row.querySelector('.pr-date').value,
      diagnosis: row.querySelector('.pr-diagnosis').value,
      instructions: row.querySelector('.pr-instructions').value,
      items: parseItemsBlob(row.querySelector('.pr-items').value)
    };
  }

  function showPrescriptionModal(id) { document.getElementById(id).classList.remove('hidden'); }
  function closePrescriptionModal(id) { document.getElementById(id).classList.add('hidden'); }

  function openPrescriptionViewModal(button) {
    const p = getPrescriptionData(button);
    document.getElementById('rvCode').textContent = p.code;
    document.getElementById('rvDate').textContent = p.date;
    document.getElementById('rvPatient').textContent = p.patient;
    document.getElementById('rvDoctor').textContent = p.doctor;
    document.getElementById('rvDiagnosis').textContent = p.diagnosis;
    document.getElementById('rvInstructions').textContent = p.instructions || '-';

    const rows = document.getElementById('rvMedicineRows');
    rows.innerHTML = '';
    if (!p.items.length) {
      rows.innerHTML = '<div class="text-slate-500">No medicine item.</div>';
    } else {
      p.items.forEach(function (item, idx) {
        rows.insertAdjacentHTML('beforeend', '<div class="rounded border border-slate-200 px-3 py-2"><span class="text-slate-500 mr-2">' + (idx + 1) + '.</span>' + escapeHtml(item.medicine) + '<span class="text-slate-500"> - ' + escapeHtml(item.dosage) + '</span></div>');
      });
    }
    showPrescriptionModal('prescriptionViewModal');
  }

  function openPrescriptionEditModal(button) {
    const p = getPrescriptionData(button);
    document.getElementById('reId').value = p.id;
    document.getElementById('rePatientId').value = p.patientId;
    document.getElementById('reDoctorId').value = p.doctorId;
    document.getElementById('reDate').value = p.date;
    document.getElementById('reDiagnosis').value = p.diagnosis;
    document.getElementById('reInstructions').value = p.instructions;

    const wrap = document.getElementById('editMedicineRows');
    wrap.innerHTML = '';
    if (!p.items.length) {
      addMedicineRow('editMedicineRows');
    } else {
      p.items.forEach(function (i) { addMedicineRow('editMedicineRows', i.medicine, i.dosage); });
    }
    showPrescriptionModal('prescriptionEditModal');
  }

  function openPrescriptionDeleteModal(button) {
    const p = getPrescriptionData(button);
    document.getElementById('rdId').value = p.id;
    document.getElementById('rdCode').textContent = p.code;
    showPrescriptionModal('prescriptionDeleteModal');
  }

  function filterPrescriptionRows() {
    const q = (document.getElementById('prescriptionSearchInput').value || '').toLowerCase().trim();
    const rows = document.querySelectorAll('#prescriptionTableBody .prescription-row');
    rows.forEach(function (row) {
      const hay = (row.getAttribute('data-search') || '').toLowerCase();
      row.style.display = hay.includes(q) ? '' : 'none';
    });
  }

  document.addEventListener('DOMContentLoaded', function () {
    addMedicineRow('createMedicineRows');
    filterPrescriptionRows();
  });
</script>

<%@ include file="fragments/layout-end.jspf" %>
