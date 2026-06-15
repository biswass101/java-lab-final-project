<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="fragments/layout-start.jspf" %>

<div class="bg-amber-50 border border-amber-200 text-amber-800 rounded px-4 py-3 text-sm">This is a demo billing module. No real payment is processed.</div>

<div class="space-y-6">
  <div class="bg-white border border-slate-200 rounded">
    <div class="px-4 py-3 border-b border-slate-200 font-medium">Generate New Bill</div>
    <form method="post" action="${pageContext.request.contextPath}/app/billing" class="p-4 grid grid-cols-1 md:grid-cols-2 gap-4">
      <div><label class="block text-sm text-slate-600 mb-1">Select Patient</label><select class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="patientId" required><option value="">-- Choose Patient --</option><c:forEach items="${patients}" var="p"><option value="${p.id}">${p.patientCode} - ${p.name}</option></c:forEach></select></div>
      <div><label class="block text-sm text-slate-600 mb-1">Bill Date</label><input class="w-full rounded border border-slate-300 px-3 py-2 text-sm" type="date" name="billDate" required /></div>

      <div><label class="block text-sm text-slate-600 mb-1">Consultation Fee TK</label><input id="createConsultationFee" oninput="updateCreateTotal()" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" type="number" step="0.01" min="0" name="consultationFee" required /></div>
      <div><label class="block text-sm text-slate-600 mb-1">Medicine Cost TK</label><input id="createMedicineCost" oninput="updateCreateTotal()" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" type="number" step="0.01" min="0" name="medicineCost" required /></div>
      <div><label class="block text-sm text-slate-600 mb-1">Service Charge TK</label><input id="createServiceCharge" oninput="updateCreateTotal()" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" type="number" step="0.01" min="0" name="serviceCharge" required /></div>
      <div><label class="block text-sm text-slate-600 mb-1">Payment Status</label><select class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="paymentStatus"><option>Paid</option><option selected>Unpaid</option></select></div>

      <div class="md:col-span-2 bg-slate-50 border border-slate-200 rounded px-4 py-3 flex items-center justify-between">
        <div class="text-slate-700 text-sm">Total Cost</div>
        <div id="createTotalDisplay" class="text-2xl font-semibold text-[#0b2545]">TK 0.00</div>
      </div>

      <div><button class="bg-[#0b2545] hover:bg-[#15345c] text-white rounded px-4 py-2 text-sm" type="submit">Generate Bill</button></div>
    </form>
  </div>

  <div class="bg-white border border-slate-200 rounded overflow-hidden">
    <div class="px-4 py-3 border-b border-slate-200 flex flex-wrap items-center justify-between gap-2">
      <div class="font-medium">Billing Records</div>
      <input id="billingSearchInput" oninput="filterBillRows()" class="w-64 rounded border border-slate-300 px-3 py-2 text-sm" placeholder="Search billing records..." />
    </div>
    <div class="overflow-x-auto">
      <table class="w-full text-sm">
        <thead class="bg-slate-50 text-slate-600"><tr><th class="text-left p-3">Bill ID</th><th class="text-left p-3">Patient</th><th class="text-left p-3">Total Amount</th><th class="text-left p-3">Status</th><th class="text-left p-3">Date</th><th class="text-left p-3">Action</th></tr></thead>
        <tbody id="billTableBody">
        <c:forEach items="${bills}" var="b">
          <tr class="border-t border-slate-100 bill-row" data-search="${b.billCode} ${b.patientName} ${b.paymentStatus} ${b.billDate}">
            <td class="p-3">${b.billCode}</td>
            <td class="p-3">${b.patientName}</td>
            <td class="p-3">TK <fmt:formatNumber value="${b.totalAmount}" type="number" minFractionDigits="2" maxFractionDigits="2"/></td>
            <td class="p-3"><span class="inline-flex px-2 py-1 rounded text-xs ${b.paymentStatus == 'Paid' ? 'bg-emerald-100 text-emerald-700' : 'bg-amber-100 text-amber-700'}">${b.paymentStatus}</span></td>
            <td class="p-3">${b.billDate}</td>
            <td class="p-3">
              <div class="flex flex-wrap items-center gap-1.5">
                <button type="button" onclick="openBillViewModal(this)" class="bg-slate-100 hover:bg-slate-200 text-slate-700 rounded px-2.5 py-1.5 text-xs inline-flex items-center gap-1"><i class="bi bi-eye"></i><span>View</span></button>
                <a href="${pageContext.request.contextPath}/app/billing/print?id=${b.id}" target="_blank" class="bg-emerald-600 hover:bg-emerald-700 text-white rounded px-2.5 py-1.5 text-xs inline-flex items-center gap-1"><i class="bi bi-printer"></i><span>Print</span></a>
                <button type="button" onclick="openBillEditModal(this)" class="bg-blue-600 hover:bg-blue-700 text-white rounded px-2.5 py-1.5 text-xs inline-flex items-center gap-1"><i class="bi bi-pencil"></i><span>Edit</span></button>
                <button type="button" onclick="openBillDeleteModal(this)" class="bg-rose-600 hover:bg-rose-700 text-white rounded px-2.5 py-1.5 text-xs inline-flex items-center gap-1"><i class="bi bi-trash"></i><span>Delete</span></button>
              </div>
              <input type="hidden" class="b-id" value="${b.id}" />
              <input type="hidden" class="b-code" value="${b.billCode}" />
              <input type="hidden" class="b-patient-id" value="${b.patientId}" />
              <input type="hidden" class="b-patient" value="${b.patientName}" />
              <input type="hidden" class="b-date" value="${b.billDate}" />
              <input type="hidden" class="b-consult" value="${b.consultationFee}" />
              <input type="hidden" class="b-med" value="${b.medicineCost}" />
              <input type="hidden" class="b-service" value="${b.serviceCharge}" />
              <input type="hidden" class="b-total" value="${b.totalAmount}" />
              <input type="hidden" class="b-status" value="${b.paymentStatus}" />
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</div>

<div id="billViewModal" class="fixed inset-0 z-[9999] hidden">
  <div class="absolute inset-0 bg-black/40 backdrop-blur-sm" onclick="closeBillModal('billViewModal')"></div>
  <div class="relative z-10 flex min-h-full w-full items-center justify-center p-2 md:p-4">
    <div class="bg-white rounded-lg shadow-xl w-full max-w-3xl max-h-[96vh] flex flex-col">
      <div class="px-5 py-3 border-b border-slate-200 flex items-center justify-between">
        <h3 class="font-semibold text-slate-800">Bill Details</h3>
        <button type="button" onclick="closeBillModal('billViewModal')" class="text-slate-500 hover:text-slate-700"><i class="bi bi-x-lg"></i></button>
      </div>
      <div class="p-5 grid grid-cols-1 md:grid-cols-2 gap-3 text-sm overflow-y-auto">
        <div><div class="text-slate-500">Bill ID</div><div id="bvCode" class="font-medium"></div></div>
        <div><div class="text-slate-500">Patient</div><div id="bvPatient" class="font-medium"></div></div>
        <div><div class="text-slate-500">Date</div><div id="bvDate" class="font-medium"></div></div>
        <div><div class="text-slate-500">Payment Status</div><div id="bvStatus" class="font-medium"></div></div>
        <div><div class="text-slate-500">Consultation Fee</div><div id="bvConsult" class="font-medium"></div></div>
        <div><div class="text-slate-500">Medicine Cost</div><div id="bvMed" class="font-medium"></div></div>
        <div><div class="text-slate-500">Service Charge</div><div id="bvService" class="font-medium"></div></div>
        <div><div class="text-slate-500">Total Amount</div><div id="bvTotal" class="font-medium text-[#0b2545]"></div></div>
      </div>
      <div class="px-5 py-3 border-t border-slate-200 text-right"><button type="button" onclick="closeBillModal('billViewModal')" class="bg-slate-100 hover:bg-slate-200 text-slate-700 rounded px-4 py-2 text-sm">Close</button></div>
    </div>
  </div>
</div>

<div id="billEditModal" class="fixed inset-0 z-[9999] hidden">
  <div class="absolute inset-0 bg-black/40 backdrop-blur-sm" onclick="closeBillModal('billEditModal')"></div>
  <div class="relative z-10 flex min-h-full w-full items-center justify-center p-2 md:p-4">
    <div class="bg-white rounded-lg shadow-xl w-full max-w-5xl max-h-[96vh] flex flex-col">
      <div class="px-5 py-3 border-b border-slate-200 flex items-center justify-between">
        <h3 class="font-semibold text-slate-800">Edit Bill</h3>
        <button type="button" onclick="closeBillModal('billEditModal')" class="text-slate-500 hover:text-slate-700"><i class="bi bi-x-lg"></i></button>
      </div>
      <form method="post" action="${pageContext.request.contextPath}/app/billing" class="p-5 grid grid-cols-1 md:grid-cols-2 gap-3 content-start overflow-y-auto">
        <input type="hidden" name="action" value="update" />
        <input type="hidden" id="beId" name="id" />
        <div><label class="block text-sm text-slate-600 mb-1">Select Patient</label><select id="bePatientId" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="patientId" required><option value="">-- Choose Patient --</option><c:forEach items="${patients}" var="p"><option value="${p.id}">${p.patientCode} - ${p.name}</option></c:forEach></select></div>
        <div><label class="block text-sm text-slate-600 mb-1">Bill Date</label><input id="beDate" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" type="date" name="billDate" required /></div>
        <div><label class="block text-sm text-slate-600 mb-1">Consultation Fee TK</label><input id="beConsult" oninput="updateEditTotal()" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" type="number" step="0.01" min="0" name="consultationFee" required /></div>
        <div><label class="block text-sm text-slate-600 mb-1">Medicine Cost TK</label><input id="beMed" oninput="updateEditTotal()" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" type="number" step="0.01" min="0" name="medicineCost" required /></div>
        <div><label class="block text-sm text-slate-600 mb-1">Service Charge TK</label><input id="beService" oninput="updateEditTotal()" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" type="number" step="0.01" min="0" name="serviceCharge" required /></div>
        <div><label class="block text-sm text-slate-600 mb-1">Payment Status</label><select id="beStatus" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="paymentStatus"><option>Paid</option><option>Unpaid</option></select></div>
        <div class="md:col-span-2 bg-slate-50 border border-slate-200 rounded px-4 py-3 flex items-center justify-between">
          <div class="text-slate-700 text-sm">Total Cost</div>
          <div id="editTotalDisplay" class="text-2xl font-semibold text-[#0b2545]">TK 0.00</div>
        </div>
        <div class="md:col-span-2 flex items-center justify-end gap-2 pt-2 border-t border-slate-100 sticky bottom-0 bg-white">
          <button type="button" onclick="closeBillModal('billEditModal')" class="bg-slate-100 hover:bg-slate-200 text-slate-700 rounded px-4 py-2 text-sm">Cancel</button>
          <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white rounded px-4 py-2 text-sm">Update</button>
        </div>
      </form>
    </div>
  </div>
</div>

<div id="billDeleteModal" class="fixed inset-0 z-[9999] hidden">
  <div class="absolute inset-0 bg-black/40 backdrop-blur-sm" onclick="closeBillModal('billDeleteModal')"></div>
  <div class="relative z-10 flex min-h-full w-full items-center justify-center p-4">
    <div class="bg-white rounded-lg shadow-xl w-full max-w-md">
      <div class="px-5 py-4 border-b border-slate-200 flex items-center gap-2">
        <div class="w-8 h-8 rounded-full bg-rose-100 text-rose-700 flex items-center justify-center"><i class="bi bi-exclamation-triangle"></i></div>
        <h3 class="font-semibold text-slate-800">Delete Bill?</h3>
      </div>
      <div class="p-5 text-sm text-slate-600">This action will permanently remove <span id="bdCode" class="font-semibold text-slate-800"></span>.</div>
      <form method="post" action="${pageContext.request.contextPath}/app/billing" class="px-5 pb-5 flex items-center justify-end gap-2">
        <input type="hidden" name="action" value="delete" />
        <input type="hidden" id="bdId" name="id" />
        <button type="button" onclick="closeBillModal('billDeleteModal')" class="bg-slate-100 hover:bg-slate-200 text-slate-700 rounded px-4 py-2 text-sm">Cancel</button>
        <button type="submit" class="bg-rose-600 hover:bg-rose-700 text-white rounded px-4 py-2 text-sm">Delete</button>
      </form>
    </div>
  </div>
</div>

<script>
  function toMoney(n) {
    const val = isNaN(n) ? 0 : n;
    return 'TK ' + val.toLocaleString('en-BD', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
  }

  function num(id) {
    const v = parseFloat(document.getElementById(id).value);
    return isNaN(v) ? 0 : v;
  }

  function updateCreateTotal() {
    const total = num('createConsultationFee') + num('createMedicineCost') + num('createServiceCharge');
    document.getElementById('createTotalDisplay').textContent = toMoney(total);
  }

  function updateEditTotal() {
    const total = num('beConsult') + num('beMed') + num('beService');
    document.getElementById('editTotalDisplay').textContent = toMoney(total);
  }

  function getBillData(button) {
    const row = button.closest('tr');
    return {
      id: row.querySelector('.b-id').value,
      code: row.querySelector('.b-code').value,
      patientId: row.querySelector('.b-patient-id').value,
      patient: row.querySelector('.b-patient').value,
      date: row.querySelector('.b-date').value,
      consult: parseFloat(row.querySelector('.b-consult').value) || 0,
      med: parseFloat(row.querySelector('.b-med').value) || 0,
      service: parseFloat(row.querySelector('.b-service').value) || 0,
      total: parseFloat(row.querySelector('.b-total').value) || 0,
      status: row.querySelector('.b-status').value
    };
  }

  function showBillModal(id) { document.getElementById(id).classList.remove('hidden'); }
  function closeBillModal(id) { document.getElementById(id).classList.add('hidden'); }

  function openBillViewModal(button) {
    const b = getBillData(button);
    document.getElementById('bvCode').textContent = b.code;
    document.getElementById('bvPatient').textContent = b.patient;
    document.getElementById('bvDate').textContent = b.date;
    document.getElementById('bvStatus').textContent = b.status;
    document.getElementById('bvConsult').textContent = toMoney(b.consult);
    document.getElementById('bvMed').textContent = toMoney(b.med);
    document.getElementById('bvService').textContent = toMoney(b.service);
    document.getElementById('bvTotal').textContent = toMoney(b.total);
    showBillModal('billViewModal');
  }

  function openBillEditModal(button) {
    const b = getBillData(button);
    document.getElementById('beId').value = b.id;
    document.getElementById('bePatientId').value = b.patientId;
    document.getElementById('beDate').value = b.date;
    document.getElementById('beConsult').value = b.consult;
    document.getElementById('beMed').value = b.med;
    document.getElementById('beService').value = b.service;
    document.getElementById('beStatus').value = b.status;
    updateEditTotal();
    showBillModal('billEditModal');
  }

  function openBillDeleteModal(button) {
    const b = getBillData(button);
    document.getElementById('bdId').value = b.id;
    document.getElementById('bdCode').textContent = b.code;
    showBillModal('billDeleteModal');
  }

  function filterBillRows() {
    const q = (document.getElementById('billingSearchInput').value || '').toLowerCase().trim();
    const rows = document.querySelectorAll('#billTableBody .bill-row');
    rows.forEach(function (row) {
      const hay = (row.getAttribute('data-search') || '').toLowerCase();
      row.style.display = hay.includes(q) ? '' : 'none';
    });
  }

  document.addEventListener('DOMContentLoaded', function () {
    updateCreateTotal();
    filterBillRows();
  });
</script>

<%@ include file="fragments/layout-end.jspf" %>
