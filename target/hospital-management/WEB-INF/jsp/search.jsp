<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="fragments/layout-start.jspf" %>

<div class="space-y-6">
  <div class="bg-white border border-slate-200 rounded">
    <div class="px-4 py-3 border-b border-slate-200 font-medium">Search Records</div>
    <form id="searchForm" method="get" action="${pageContext.request.contextPath}/app/search" class="p-4 grid grid-cols-1 md:grid-cols-4 gap-4">
      <div class="md:col-span-2">
        <label class="block text-sm text-slate-600 mb-1">Search by Patient ID / Name / Doctor / Date</label>
        <input id="searchQ" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="q" value="${q}" placeholder="e.g. P-2001, Rakibul, Dr. Farhana, 2026-05-25" />
      </div>
      <div>
        <label class="block text-sm text-slate-600 mb-1">Record Type</label>
        <select id="searchType" class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="type">
          <option value="" ${empty type ? 'selected' : ''}>All</option>
          <option ${type == 'Patient' ? 'selected' : ''}>Patient</option>
          <option ${type == 'Appointment' ? 'selected' : ''}>Appointment</option>
          <option ${type == 'Prescription' ? 'selected' : ''}>Prescription</option>
          <option ${type == 'Billing' ? 'selected' : ''}>Billing</option>
        </select>
      </div>
      <div class="flex items-end"><button class="w-full bg-[#0b2545] hover:bg-[#15345c] text-white rounded px-4 py-2 text-sm" type="submit">Search</button></div>
    </form>
  </div>

  <div class="bg-white border border-slate-200 rounded overflow-hidden">
    <div class="px-4 py-3 border-b border-slate-200 font-medium">Search Results</div>
    <div class="overflow-x-auto">
      <table class="w-full text-sm">
        <thead class="bg-slate-50 text-slate-600"><tr><th class="text-left p-3">Record Type</th><th class="text-left p-3">Record ID</th><th class="text-left p-3">Name</th><th class="text-left p-3">Date</th><th class="text-left p-3">Details</th><th class="text-left p-3">Action</th></tr></thead>
        <tbody id="searchResultsBody">
        <c:forEach items="${results}" var="r">
          <tr class="border-t border-slate-100">
            <td class="p-3">${r.type}</td>
            <td class="p-3">${r.recordId}</td>
            <td class="p-3">${r.name}</td>
            <td class="p-3">${r.date}</td>
            <td class="p-3">${r.detail}</td>
            <td class="p-3">
              <a href="${pageContext.request.contextPath}/app/${r.type == 'Patient' ? 'patients' : r.type == 'Appointment' ? 'appointments' : r.type == 'Prescription' ? 'prescriptions' : 'billing'}" class="bg-slate-100 hover:bg-slate-200 text-slate-700 rounded px-2.5 py-1.5 text-xs inline-flex items-center gap-1">
                <i class="bi bi-box-arrow-up-right"></i><span>Open</span>
              </a>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
    <div id="searchResultCount" class="px-4 py-3 text-xs text-slate-500 border-t border-slate-100">Showing ${fn:length(results)} result(s)</div>
  </div>
</div>

<script>
  function escapeHtml(text) {
    const map = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' };
    return String(text == null ? '' : text).replace(/[&<>"']/g, function (m) { return map[m]; });
  }

  function openUrlForType(type) {
    if (type === 'Patient') return '${pageContext.request.contextPath}/app/patients';
    if (type === 'Appointment') return '${pageContext.request.contextPath}/app/appointments';
    if (type === 'Prescription') return '${pageContext.request.contextPath}/app/prescriptions';
    return '${pageContext.request.contextPath}/app/billing';
  }

  function renderSearchResults(results) {
    const tbody = document.getElementById('searchResultsBody');
    const count = document.getElementById('searchResultCount');
    const rows = results.map(function (r) {
      const openUrl = openUrlForType(r.type);
      return '<tr class="border-t border-slate-100">' +
        '<td class="p-3">' + escapeHtml(r.type) + '</td>' +
        '<td class="p-3">' + escapeHtml(r.recordId) + '</td>' +
        '<td class="p-3">' + escapeHtml(r.name) + '</td>' +
        '<td class="p-3">' + escapeHtml(r.date) + '</td>' +
        '<td class="p-3">' + escapeHtml(r.detail) + '</td>' +
        '<td class="p-3"><a href="' + openUrl + '" class="bg-slate-100 hover:bg-slate-200 text-slate-700 rounded px-2.5 py-1.5 text-xs inline-flex items-center gap-1"><i class="bi bi-box-arrow-up-right"></i><span>Open</span></a></td>' +
        '</tr>';
    });
    tbody.innerHTML = rows.join('');
    count.textContent = 'Showing ' + results.length + ' result(s)';
  }

  let searchTimer = null;
  let searchRequestVersion = 0;

  function runRealtimeSearch() {
    const q = document.getElementById('searchQ').value || '';
    const type = document.getElementById('searchType').value || '';
    const reqVersion = ++searchRequestVersion;
    const params = new URLSearchParams({ q: q, type: type, format: 'json' });
    fetch('${pageContext.request.contextPath}/app/search?' + params.toString(), {
      headers: { 'X-Requested-With': 'XMLHttpRequest' }
    })
      .then(function (res) { return res.json(); })
      .then(function (data) {
        if (reqVersion !== searchRequestVersion) return;
        renderSearchResults(data.results || []);
      })
      .catch(function () { });
  }

  function scheduleRealtimeSearch() {
    if (searchTimer) clearTimeout(searchTimer);
    searchTimer = setTimeout(runRealtimeSearch, 250);
  }

  document.addEventListener('DOMContentLoaded', function () {
    const qInput = document.getElementById('searchQ');
    const typeSelect = document.getElementById('searchType');
    document.getElementById('searchForm').addEventListener('submit', function (e) {
      e.preventDefault();
      runRealtimeSearch();
    });
    qInput.addEventListener('input', scheduleRealtimeSearch);
    typeSelect.addEventListener('change', runRealtimeSearch);
  });
</script>

<%@ include file="fragments/layout-end.jspf" %>
