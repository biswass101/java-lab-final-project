<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="fragments/layout-start.jspf" %>

<div class="space-y-6">
  <div class="bg-white border border-slate-200 rounded overflow-hidden">
    <div class="px-4 py-3 border-b border-slate-200 flex flex-wrap items-center justify-between gap-2">
      <div class="font-medium">Doctor Management</div>
      <div class="flex gap-2">
        <form method="get" action="${pageContext.request.contextPath}/app/doctors" class="flex gap-2" onsubmit="return false;">
          <input id="doctorSearchInput" oninput="filterDoctorRows()" class="w-64 rounded border border-slate-300 px-3 py-2 text-sm" name="q" value="${query}" placeholder="Search doctor..." />
          <button class="bg-[#1ca39a] text-white rounded px-3 py-2 text-sm" type="button" onclick="filterDoctorRows()">Search</button>
        </form>
        <button type="button" onclick="openAddModal()" class="bg-[#0b2545] text-white rounded px-3 py-2 text-sm inline-flex items-center gap-2">
          <i class="bi bi-plus-lg"></i>
          <span>Add Doctor</span>
        </button>
      </div>
    </div>
    <div class="overflow-x-auto">
      <table class="w-full text-sm">
        <thead class="bg-slate-50 text-slate-600"><tr><th class="text-left p-3">Doctor ID</th><th class="text-left p-3">Name</th><th class="text-left p-3">Specialisation</th><th class="text-left p-3">Phone</th><th class="text-left p-3">Availability</th><th class="text-left p-3">Action</th></tr></thead>
        <tbody id="doctorTableBody">
        <c:forEach items="${doctors}" var="d">
          <tr class="border-t border-slate-100 doctor-row" data-search="${d.doctorCode} ${d.name} ${d.specialization} ${d.phone} ${d.availability}">
            <td class="p-3">${d.doctorCode}</td>
            <td class="p-3">${d.name}</td>
            <td class="p-3">${d.specialization}</td>
            <td class="p-3">${d.phone}</td>
            <td class="p-3"><span class="inline-flex px-2 py-1 rounded text-xs ${d.availability == 'Available' ? 'bg-emerald-100 text-emerald-700' : 'bg-rose-100 text-rose-700'}">${d.availability}</span></td>
            <td class="p-3">
              <div class="flex flex-wrap items-center gap-1.5">
                <button type="button" onclick="openViewModal(this)" class="bg-slate-100 hover:bg-slate-200 text-slate-700 rounded px-2.5 py-1.5 text-xs inline-flex items-center gap-1"><i class="bi bi-eye"></i><span>View</span></button>
                <button type="button" onclick="openEditModal(this)" class="bg-blue-600 hover:bg-blue-700 text-white rounded px-2.5 py-1.5 text-xs inline-flex items-center gap-1"><i class="bi bi-pencil"></i><span>Edit</span></button>
                <button type="button" onclick="openDeleteModal(this)" class="bg-rose-600 hover:bg-rose-700 text-white rounded px-2.5 py-1.5 text-xs inline-flex items-center gap-1"><i class="bi bi-trash"></i><span>Delete</span></button>
              </div>
              <input type="hidden" class="d-id" value="${d.id}" />
              <input type="hidden" class="d-code" value="${d.doctorCode}" />
              <input type="hidden" class="d-name" value="${d.name}" />
              <input type="hidden" class="d-specialization" value="${d.specialization}" />
              <input type="hidden" class="d-phone" value="${d.phone}" />
              <input type="hidden" class="d-email" value="${d.email}" />
              <input type="hidden" class="d-available-days" value="${d.availableDays}" />
              <input type="hidden" class="d-fee" value="${d.consultationFee}" />
              <input type="hidden" class="d-availability" value="${d.availability}" />
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</div>

<div id="viewModal" class="fixed inset-0 z-[9999] hidden">
  <div class="absolute inset-0 bg-black/40 backdrop-blur-sm" onclick="closeModal('viewModal')"></div>
  <div class="relative z-10 flex min-h-full w-full items-center justify-center p-2 md:p-4">
  <div class="bg-white rounded-lg shadow-xl w-full max-w-5xl max-h-[96vh] flex flex-col">
    <div class="px-5 py-3 border-b border-slate-200 flex items-center justify-between">
      <h3 class="font-semibold text-slate-800">Doctor Details</h3>
      <button type="button" onclick="closeModal('viewModal')" class="text-slate-500 hover:text-slate-700"><i class="bi bi-x-lg"></i></button>
    </div>
    <div class="p-5 grid grid-cols-1 md:grid-cols-2 gap-3 text-sm overflow-y-auto">
      <div><div class="text-slate-500">Doctor ID</div><div id="viewCode" class="font-medium"></div></div>
      <div><div class="text-slate-500">Name</div><div id="viewName" class="font-medium"></div></div>
      <div><div class="text-slate-500">Specialisation</div><div id="viewSpecialization" class="font-medium"></div></div>
      <div><div class="text-slate-500">Phone</div><div id="viewPhone" class="font-medium"></div></div>
      <div><div class="text-slate-500">Email</div><div id="viewEmail" class="font-medium"></div></div>
      <div><div class="text-slate-500">Available Days</div><div id="viewAvailableDays" class="font-medium"></div></div>
      <div><div class="text-slate-500">Consultation Fee</div><div id="viewFee" class="font-medium"></div></div>
      <div><div class="text-slate-500">Availability</div><div id="viewAvailability" class="font-medium"></div></div>
    </div>
    <div class="px-5 py-3 border-t border-slate-200 text-right">
      <button type="button" onclick="closeModal('viewModal')" class="bg-slate-100 hover:bg-slate-200 text-slate-700 rounded px-4 py-2 text-sm">Close</button>
    </div>
  </div>
  </div>
</div>

<div id="addModal" class="fixed inset-0 z-[9999] hidden">
  <div class="absolute inset-0 bg-black/40 backdrop-blur-sm" onclick="closeModal('addModal')"></div>
  <div class="relative z-10 flex min-h-full w-full items-center justify-center p-2 md:p-4">
  <div class="bg-white rounded-lg shadow-xl w-full max-w-5xl max-h-[96vh] flex flex-col">
    <div class="px-5 py-3 border-b border-slate-200 flex items-center justify-between">
      <h3 class="font-semibold text-slate-800">Add Doctor</h3>
      <button type="button" onclick="closeModal('addModal')" class="text-slate-500 hover:text-slate-700"><i class="bi bi-x-lg"></i></button>
    </div>
    <form method="post" action="${pageContext.request.contextPath}/app/doctors" class="p-5 grid grid-cols-1 md:grid-cols-2 gap-3 content-start overflow-y-auto">
      <div><label class="block text-sm text-slate-600 mb-1">Doctor Name</label><input class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="name" required /></div>
      <div><label class="block text-sm text-slate-600 mb-1">Specialisation</label><input class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="specialization" required /></div>
      <div><label class="block text-sm text-slate-600 mb-1">Phone Number</label><input class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="phone" /></div>
      <div><label class="block text-sm text-slate-600 mb-1">Email</label><input class="w-full rounded border border-slate-300 px-3 py-2 text-sm" type="email" name="email" /></div>
      <div><label class="block text-sm text-slate-600 mb-1">Available Days</label><input class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="availableDays" placeholder="Sat, Sun, Mon" /></div>
      <div><label class="block text-sm text-slate-600 mb-1">Consultation Fee</label><input class="w-full rounded border border-slate-300 px-3 py-2 text-sm" type="number" step="0.01" min="0" name="consultationFee" /></div>
      <div><label class="block text-sm text-slate-600 mb-1">Availability</label><select class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="availability"><option>Available</option><option>On Leave</option></select></div>
      <div class="md:col-span-2 flex items-center justify-end gap-2 pt-2 border-t border-slate-100 sticky bottom-0 bg-white">
        <button type="button" onclick="closeModal('addModal')" class="bg-slate-100 hover:bg-slate-200 text-slate-700 rounded px-4 py-2 text-sm">Cancel</button>
        <button type="submit" class="bg-[#0b2545] hover:bg-[#15345c] text-white rounded px-4 py-2 text-sm">Submit</button>
      </div>
    </form>
  </div>
  </div>
</div>

<div id="editModal" class="fixed inset-0 z-[9999] hidden">
  <div class="absolute inset-0 bg-black/40 backdrop-blur-sm" onclick="closeModal('editModal')"></div>
  <div class="relative z-10 flex min-h-full w-full items-center justify-center p-2 md:p-4">
  <div class="bg-white rounded-lg shadow-xl w-full max-w-5xl max-h-[96vh] flex flex-col">
    <div class="px-5 py-3 border-b border-slate-200 flex items-center justify-between">
      <h3 class="font-semibold text-slate-800">Edit Doctor</h3>
      <button type="button" onclick="closeModal('editModal')" class="text-slate-500 hover:text-slate-700"><i class="bi bi-x-lg"></i></button>
    </div>
    <form method="post" action="${pageContext.request.contextPath}/app/doctors" class="p-5 grid grid-cols-1 md:grid-cols-2 gap-3 content-start overflow-y-auto">
      <input type="hidden" name="action" value="update" />
      <input type="hidden" id="editId" name="id" />
      <div><label class="block text-sm text-slate-600 mb-1">Doctor Name</label><input id="editName" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="name" required /></div>
      <div><label class="block text-sm text-slate-600 mb-1">Specialisation</label><input id="editSpecialization" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="specialization" required /></div>
      <div><label class="block text-sm text-slate-600 mb-1">Phone Number</label><input id="editPhone" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="phone" /></div>
      <div><label class="block text-sm text-slate-600 mb-1">Email</label><input id="editEmail" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" type="email" name="email" /></div>
      <div><label class="block text-sm text-slate-600 mb-1">Available Days</label><input id="editAvailableDays" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="availableDays" /></div>
      <div><label class="block text-sm text-slate-600 mb-1">Consultation Fee</label><input id="editFee" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" type="number" step="0.01" min="0" name="consultationFee" /></div>
      <div><label class="block text-sm text-slate-600 mb-1">Availability</label><select id="editAvailability" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="availability"><option>Available</option><option>On Leave</option></select></div>
      <div class="md:col-span-2 flex items-center justify-end gap-2 pt-2 border-t border-slate-100 sticky bottom-0 bg-white">
        <button type="button" onclick="closeModal('editModal')" class="bg-slate-100 hover:bg-slate-200 text-slate-700 rounded px-4 py-2 text-sm">Cancel</button>
        <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white rounded px-4 py-2 text-sm">Update</button>
      </div>
    </form>
  </div>
  </div>
</div>

<div id="deleteModal" class="fixed inset-0 z-[9999] hidden">
  <div class="absolute inset-0 bg-black/40 backdrop-blur-sm" onclick="closeModal('deleteModal')"></div>
  <div class="relative z-10 flex min-h-full w-full items-center justify-center p-4">
  <div class="bg-white rounded-lg shadow-xl w-full max-w-md">
    <div class="px-5 py-4 border-b border-slate-200 flex items-center gap-2">
      <div class="w-8 h-8 rounded-full bg-rose-100 text-rose-700 flex items-center justify-center"><i class="bi bi-exclamation-triangle"></i></div>
      <h3 class="font-semibold text-slate-800">Delete Doctor Record?</h3>
    </div>
    <div class="p-5 text-sm text-slate-600">
      This action will permanently remove <span id="deleteDoctorName" class="font-semibold text-slate-800"></span> from doctor records.
    </div>
    <form method="post" action="${pageContext.request.contextPath}/app/doctors" class="px-5 pb-5 flex items-center justify-end gap-2">
      <input type="hidden" name="action" value="delete" />
      <input type="hidden" id="deleteId" name="id" />
      <button type="button" onclick="closeModal('deleteModal')" class="bg-slate-100 hover:bg-slate-200 text-slate-700 rounded px-4 py-2 text-sm">Cancel</button>
      <button type="submit" class="bg-rose-600 hover:bg-rose-700 text-white rounded px-4 py-2 text-sm">Delete</button>
    </form>
  </div>
  </div>
</div>

<script>
  function getDoctorData(button) {
    const row = button.closest('tr');
    return {
      id: row.querySelector('.d-id').value,
      code: row.querySelector('.d-code').value,
      name: row.querySelector('.d-name').value,
      specialization: row.querySelector('.d-specialization').value,
      phone: row.querySelector('.d-phone').value,
      email: row.querySelector('.d-email').value,
      availableDays: row.querySelector('.d-available-days').value,
      fee: row.querySelector('.d-fee').value,
      availability: row.querySelector('.d-availability').value
    };
  }

  function showModal(id) {
    const modal = document.getElementById(id);
    modal.classList.remove('hidden');
  }

  function closeModal(id) {
    const modal = document.getElementById(id);
    modal.classList.add('hidden');
  }

  function openAddModal() {
    showModal('addModal');
  }

  function openViewModal(button) {
    const d = getDoctorData(button);
    document.getElementById('viewCode').textContent = d.code || '-';
    document.getElementById('viewName').textContent = d.name || '-';
    document.getElementById('viewSpecialization').textContent = d.specialization || '-';
    document.getElementById('viewPhone').textContent = d.phone || '-';
    document.getElementById('viewEmail').textContent = d.email || '-';
    document.getElementById('viewAvailableDays').textContent = d.availableDays || '-';
    document.getElementById('viewFee').textContent = d.fee || '0';
    document.getElementById('viewAvailability').textContent = d.availability || '-';
    showModal('viewModal');
  }

  function openEditModal(button) {
    const d = getDoctorData(button);
    document.getElementById('editId').value = d.id;
    document.getElementById('editName').value = d.name;
    document.getElementById('editSpecialization').value = d.specialization;
    document.getElementById('editPhone').value = d.phone;
    document.getElementById('editEmail').value = d.email;
    document.getElementById('editAvailableDays').value = d.availableDays;
    document.getElementById('editFee').value = d.fee;
    document.getElementById('editAvailability').value = d.availability;
    showModal('editModal');
  }

  function openDeleteModal(button) {
    const d = getDoctorData(button);
    document.getElementById('deleteId').value = d.id;
    document.getElementById('deleteDoctorName').textContent = d.name;
    showModal('deleteModal');
  }

  function filterDoctorRows() {
    const q = (document.getElementById('doctorSearchInput').value || '').toLowerCase().trim();
    const rows = document.querySelectorAll('#doctorTableBody .doctor-row');
    rows.forEach(function (row) {
      const hay = (row.getAttribute('data-search') || '').toLowerCase();
      row.style.display = hay.includes(q) ? '' : 'none';
    });
  }

  document.addEventListener('DOMContentLoaded', filterDoctorRows);

</script>

<%@ include file="fragments/layout-end.jspf" %>
