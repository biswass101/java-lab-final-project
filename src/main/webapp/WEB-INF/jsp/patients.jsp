<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="fragments/layout-start.jspf" %>

<div class="space-y-6">
  <div class="bg-white border border-slate-200 rounded overflow-hidden">
    <div class="px-4 py-3 border-b border-slate-200 flex flex-wrap items-center justify-between gap-2">
      <div class="font-medium">Patient Management</div>
      <div class="flex gap-2">
        <form method="get" action="${pageContext.request.contextPath}/app/patients" class="flex gap-2" onsubmit="return false;">
          <input id="patientSearchInput" oninput="filterPatientRows()" class="w-64 rounded border border-slate-300 px-3 py-2 text-sm" name="q" value="${query}" placeholder="Search patient..." />
          <button class="bg-[#1ca39a] text-white rounded px-3 py-2 text-sm" type="button" onclick="filterPatientRows()">Search</button>
        </form>
        <button type="button" onclick="openPatientAddModal()" class="bg-[#0b2545] text-white rounded px-3 py-2 text-sm inline-flex items-center gap-2">
          <i class="bi bi-plus-lg"></i>
          <span>Add Patient</span>
        </button>
      </div>
    </div>
    <div class="overflow-x-auto">
      <table class="w-full text-sm">
        <thead class="bg-slate-50 text-slate-600"><tr><th class="text-left p-3">Patient ID</th><th class="text-left p-3">Name</th><th class="text-left p-3">Age</th><th class="text-left p-3">Gender</th><th class="text-left p-3">Phone</th><th class="text-left p-3">Blood Group</th><th class="text-left p-3">Action</th></tr></thead>
        <tbody id="patientTableBody">
        <c:forEach items="${patients}" var="p">
          <tr class="border-t border-slate-100 patient-row" data-search="${p.patientCode} ${p.name} ${p.phone} ${p.bloodGroup} ${p.gender}">
            <td class="p-3">${p.patientCode}</td>
            <td class="p-3">${p.name}</td>
            <td class="p-3">${p.age}</td>
            <td class="p-3">${p.gender}</td>
            <td class="p-3">${p.phone}</td>
            <td class="p-3">${p.bloodGroup}</td>
            <td class="p-3">
              <div class="flex flex-wrap items-center gap-1.5">
                <button type="button" onclick="openPatientViewModal(this)" class="bg-slate-100 hover:bg-slate-200 text-slate-700 rounded px-2.5 py-1.5 text-xs inline-flex items-center gap-1"><i class="bi bi-eye"></i><span>View</span></button>
                <button type="button" onclick="openPatientEditModal(this)" class="bg-blue-600 hover:bg-blue-700 text-white rounded px-2.5 py-1.5 text-xs inline-flex items-center gap-1"><i class="bi bi-pencil"></i><span>Edit</span></button>
                <button type="button" onclick="openPatientDeleteModal(this)" class="bg-rose-600 hover:bg-rose-700 text-white rounded px-2.5 py-1.5 text-xs inline-flex items-center gap-1"><i class="bi bi-trash"></i><span>Delete</span></button>
              </div>
              <input type="hidden" class="p-id" value="${p.id}" />
              <input type="hidden" class="p-code" value="${p.patientCode}" />
              <input type="hidden" class="p-name" value="${p.name}" />
              <input type="hidden" class="p-age" value="${p.age}" />
              <input type="hidden" class="p-gender" value="${p.gender}" />
              <input type="hidden" class="p-phone" value="${p.phone}" />
              <input type="hidden" class="p-blood" value="${p.bloodGroup}" />
              <input type="hidden" class="p-email" value="${p.email}" />
              <input type="hidden" class="p-address" value="${p.address}" />
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</div>

<div id="patientViewModal" class="fixed inset-0 z-[9999] hidden">
  <div class="absolute inset-0 bg-black/40 backdrop-blur-sm" onclick="closePatientModal('patientViewModal')"></div>
  <div class="relative z-10 flex min-h-full w-full items-center justify-center p-2 md:p-4">
    <div class="bg-white rounded-lg shadow-xl w-full max-w-5xl max-h-[96vh] flex flex-col">
      <div class="px-5 py-3 border-b border-slate-200 flex items-center justify-between">
        <h3 class="font-semibold text-slate-800">Patient Details</h3>
        <button type="button" onclick="closePatientModal('patientViewModal')" class="text-slate-500 hover:text-slate-700"><i class="bi bi-x-lg"></i></button>
      </div>
      <div class="p-5 grid grid-cols-1 md:grid-cols-2 gap-3 text-sm overflow-y-auto">
        <div><div class="text-slate-500">Patient ID</div><div id="pvCode" class="font-medium"></div></div>
        <div><div class="text-slate-500">Name</div><div id="pvName" class="font-medium"></div></div>
        <div><div class="text-slate-500">Age</div><div id="pvAge" class="font-medium"></div></div>
        <div><div class="text-slate-500">Gender</div><div id="pvGender" class="font-medium"></div></div>
        <div><div class="text-slate-500">Phone</div><div id="pvPhone" class="font-medium"></div></div>
        <div><div class="text-slate-500">Blood Group</div><div id="pvBlood" class="font-medium"></div></div>
        <div><div class="text-slate-500">Email</div><div id="pvEmail" class="font-medium"></div></div>
        <div class="md:col-span-2"><div class="text-slate-500">Address</div><div id="pvAddress" class="font-medium"></div></div>
      </div>
      <div class="px-5 py-3 border-t border-slate-200 text-right">
        <button type="button" onclick="closePatientModal('patientViewModal')" class="bg-slate-100 hover:bg-slate-200 text-slate-700 rounded px-4 py-2 text-sm">Close</button>
      </div>
    </div>
  </div>
</div>

<div id="patientAddModal" class="fixed inset-0 z-[9999] hidden">
  <div class="absolute inset-0 bg-black/40 backdrop-blur-sm" onclick="closePatientModal('patientAddModal')"></div>
  <div class="relative z-10 flex min-h-full w-full items-center justify-center p-2 md:p-4">
    <div class="bg-white rounded-lg shadow-xl w-full max-w-5xl max-h-[96vh] flex flex-col">
      <div class="px-5 py-3 border-b border-slate-200 flex items-center justify-between">
        <h3 class="font-semibold text-slate-800">Add Patient</h3>
        <button type="button" onclick="closePatientModal('patientAddModal')" class="text-slate-500 hover:text-slate-700"><i class="bi bi-x-lg"></i></button>
      </div>
      <form method="post" action="${pageContext.request.contextPath}/app/patients" class="p-5 grid grid-cols-1 md:grid-cols-2 gap-3 content-start overflow-y-auto">
        <div><label class="block text-sm text-slate-600 mb-1">Patient Name</label><input class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="name" required /></div>
        <div><label class="block text-sm text-slate-600 mb-1">Age</label><input class="w-full rounded border border-slate-300 px-3 py-2 text-sm" type="number" min="0" name="age" required /></div>
        <div><label class="block text-sm text-slate-600 mb-1">Gender</label><select class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="gender"><option>Male</option><option>Female</option><option>Other</option></select></div>
        <div><label class="block text-sm text-slate-600 mb-1">Phone</label><input class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="phone" /></div>
        <div><label class="block text-sm text-slate-600 mb-1">Blood Group</label><select class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="bloodGroup"><option>A+</option><option>A-</option><option>B+</option><option>B-</option><option>O+</option><option>O-</option><option>AB+</option><option>AB-</option></select></div>
        <div><label class="block text-sm text-slate-600 mb-1">Email</label><input class="w-full rounded border border-slate-300 px-3 py-2 text-sm" type="email" name="email" /></div>
        <div class="md:col-span-2"><label class="block text-sm text-slate-600 mb-1">Address</label><textarea class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="address" rows="2"></textarea></div>
        <div class="md:col-span-2 flex items-center justify-end gap-2 pt-2 border-t border-slate-100 sticky bottom-0 bg-white">
          <button type="button" onclick="closePatientModal('patientAddModal')" class="bg-slate-100 hover:bg-slate-200 text-slate-700 rounded px-4 py-2 text-sm">Cancel</button>
          <button type="submit" class="bg-[#0b2545] hover:bg-[#15345c] text-white rounded px-4 py-2 text-sm">Submit</button>
        </div>
      </form>
    </div>
  </div>
</div>

<div id="patientEditModal" class="fixed inset-0 z-[9999] hidden">
  <div class="absolute inset-0 bg-black/40 backdrop-blur-sm" onclick="closePatientModal('patientEditModal')"></div>
  <div class="relative z-10 flex min-h-full w-full items-center justify-center p-2 md:p-4">
    <div class="bg-white rounded-lg shadow-xl w-full max-w-5xl max-h-[96vh] flex flex-col">
      <div class="px-5 py-3 border-b border-slate-200 flex items-center justify-between">
        <h3 class="font-semibold text-slate-800">Edit Patient</h3>
        <button type="button" onclick="closePatientModal('patientEditModal')" class="text-slate-500 hover:text-slate-700"><i class="bi bi-x-lg"></i></button>
      </div>
      <form method="post" action="${pageContext.request.contextPath}/app/patients" class="p-5 grid grid-cols-1 md:grid-cols-2 gap-3 content-start overflow-y-auto">
        <input type="hidden" name="action" value="update" />
        <input type="hidden" id="peId" name="id" />
        <div><label class="block text-sm text-slate-600 mb-1">Patient Name</label><input id="peName" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="name" required /></div>
        <div><label class="block text-sm text-slate-600 mb-1">Age</label><input id="peAge" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" type="number" min="0" name="age" required /></div>
        <div><label class="block text-sm text-slate-600 mb-1">Gender</label><select id="peGender" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="gender"><option>Male</option><option>Female</option><option>Other</option></select></div>
        <div><label class="block text-sm text-slate-600 mb-1">Phone</label><input id="pePhone" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="phone" /></div>
        <div><label class="block text-sm text-slate-600 mb-1">Blood Group</label><select id="peBlood" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="bloodGroup"><option>A+</option><option>A-</option><option>B+</option><option>B-</option><option>O+</option><option>O-</option><option>AB+</option><option>AB-</option></select></div>
        <div><label class="block text-sm text-slate-600 mb-1">Email</label><input id="peEmail" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" type="email" name="email" /></div>
        <div class="md:col-span-2"><label class="block text-sm text-slate-600 mb-1">Address</label><textarea id="peAddress" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="address" rows="2"></textarea></div>
        <div class="md:col-span-2 flex items-center justify-end gap-2 pt-2 border-t border-slate-100 sticky bottom-0 bg-white">
          <button type="button" onclick="closePatientModal('patientEditModal')" class="bg-slate-100 hover:bg-slate-200 text-slate-700 rounded px-4 py-2 text-sm">Cancel</button>
          <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white rounded px-4 py-2 text-sm">Update</button>
        </div>
      </form>
    </div>
  </div>
</div>

<div id="patientDeleteModal" class="fixed inset-0 z-[9999] hidden">
  <div class="absolute inset-0 bg-black/40 backdrop-blur-sm" onclick="closePatientModal('patientDeleteModal')"></div>
  <div class="relative z-10 flex min-h-full w-full items-center justify-center p-4">
    <div class="bg-white rounded-lg shadow-xl w-full max-w-md">
      <div class="px-5 py-4 border-b border-slate-200 flex items-center gap-2">
        <div class="w-8 h-8 rounded-full bg-rose-100 text-rose-700 flex items-center justify-center"><i class="bi bi-exclamation-triangle"></i></div>
        <h3 class="font-semibold text-slate-800">Delete Patient Record?</h3>
      </div>
      <div class="p-5 text-sm text-slate-600">This action will permanently remove <span id="pdName" class="font-semibold text-slate-800"></span> from patient records.</div>
      <form method="post" action="${pageContext.request.contextPath}/app/patients" class="px-5 pb-5 flex items-center justify-end gap-2">
        <input type="hidden" name="action" value="delete" />
        <input type="hidden" id="pdId" name="id" />
        <button type="button" onclick="closePatientModal('patientDeleteModal')" class="bg-slate-100 hover:bg-slate-200 text-slate-700 rounded px-4 py-2 text-sm">Cancel</button>
        <button type="submit" class="bg-rose-600 hover:bg-rose-700 text-white rounded px-4 py-2 text-sm">Delete</button>
      </form>
    </div>
  </div>
</div>

<script>
  function getPatientData(button) {
    const row = button.closest('tr');
    return {
      id: row.querySelector('.p-id').value,
      code: row.querySelector('.p-code').value,
      name: row.querySelector('.p-name').value,
      age: row.querySelector('.p-age').value,
      gender: row.querySelector('.p-gender').value,
      phone: row.querySelector('.p-phone').value,
      blood: row.querySelector('.p-blood').value,
      email: row.querySelector('.p-email').value,
      address: row.querySelector('.p-address').value
    };
  }

  function showPatientModal(id) {
    document.getElementById(id).classList.remove('hidden');
  }

  function closePatientModal(id) {
    document.getElementById(id).classList.add('hidden');
  }

  function openPatientAddModal() { showPatientModal('patientAddModal'); }

  function openPatientViewModal(button) {
    const p = getPatientData(button);
    document.getElementById('pvCode').textContent = p.code || '-';
    document.getElementById('pvName').textContent = p.name || '-';
    document.getElementById('pvAge').textContent = p.age || '-';
    document.getElementById('pvGender').textContent = p.gender || '-';
    document.getElementById('pvPhone').textContent = p.phone || '-';
    document.getElementById('pvBlood').textContent = p.blood || '-';
    document.getElementById('pvEmail').textContent = p.email || '-';
    document.getElementById('pvAddress').textContent = p.address || '-';
    showPatientModal('patientViewModal');
  }

  function openPatientEditModal(button) {
    const p = getPatientData(button);
    document.getElementById('peId').value = p.id;
    document.getElementById('peName').value = p.name;
    document.getElementById('peAge').value = p.age;
    document.getElementById('peGender').value = p.gender;
    document.getElementById('pePhone').value = p.phone;
    document.getElementById('peBlood').value = p.blood;
    document.getElementById('peEmail').value = p.email;
    document.getElementById('peAddress').value = p.address;
    showPatientModal('patientEditModal');
  }

  function openPatientDeleteModal(button) {
    const p = getPatientData(button);
    document.getElementById('pdId').value = p.id;
    document.getElementById('pdName').textContent = p.name;
    showPatientModal('patientDeleteModal');
  }

  function filterPatientRows() {
    const q = (document.getElementById('patientSearchInput').value || '').toLowerCase().trim();
    const rows = document.querySelectorAll('#patientTableBody .patient-row');
    rows.forEach(function (row) {
      const hay = (row.getAttribute('data-search') || '').toLowerCase();
      row.style.display = hay.includes(q) ? '' : 'none';
    });
  }

  document.addEventListener('DOMContentLoaded', filterPatientRows);
</script>

<%@ include file="fragments/layout-end.jspf" %>
