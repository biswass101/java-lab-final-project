<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="fragments/layout-start.jspf" %>

<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
  <div class="bg-white border border-slate-200 rounded p-4 flex items-center justify-between gap-3">
    <div>
      <div class="text-xs text-slate-500 uppercase">Total Patients</div>
      <div class="text-3xl text-[#0b2545] mt-1">${stats.totalPatients}</div>
    </div>
    <div class="w-11 h-11 rounded bg-slate-100 text-[#0b2545] flex items-center justify-center text-xl"><i class="bi bi-people"></i></div>
  </div>
  <div class="bg-white border border-slate-200 rounded p-4 flex items-center justify-between gap-3">
    <div>
      <div class="text-xs text-slate-500 uppercase">Total Doctors</div>
      <div class="text-3xl text-[#0b2545] mt-1">${stats.totalDoctors}</div>
    </div>
    <div class="w-11 h-11 rounded bg-teal-50 text-teal-700 flex items-center justify-center text-xl"><i class="bi bi-person-badge"></i></div>
  </div>
  <div class="bg-white border border-slate-200 rounded p-4 flex items-center justify-between gap-3">
    <div>
      <div class="text-xs text-slate-500 uppercase">Today's Appointments</div>
      <div class="text-3xl text-[#0b2545] mt-1">${stats.todayAppointments}</div>
    </div>
    <div class="w-11 h-11 rounded bg-blue-50 text-blue-700 flex items-center justify-center text-xl"><i class="bi bi-calendar-check"></i></div>
  </div>
  <div class="bg-white border border-slate-200 rounded p-4 flex items-center justify-between gap-3">
    <div>
      <div class="text-xs text-slate-500 uppercase">Pending Bills</div>
      <div class="text-3xl text-[#0b2545] mt-1">${stats.pendingBills}</div>
    </div>
    <div class="w-11 h-11 rounded bg-rose-50 text-rose-700 flex items-center justify-center text-xl"><i class="bi bi-receipt"></i></div>
  </div>
</div>

<div class="grid grid-cols-1 xl:grid-cols-2 gap-6">
  <div class="bg-white border border-slate-200 rounded p-4">
    <div class="font-medium text-slate-800 mb-3">Hospital Snapshot</div>
    <div class="h-72">
      <canvas id="kpiChart"></canvas>
    </div>
  </div>
  <div class="bg-white border border-slate-200 rounded p-4">
    <div class="font-medium text-slate-800 mb-3">Recent Appointments Trend</div>
    <div class="h-72">
      <canvas id="appointmentsTrendChart"></canvas>
    </div>
  </div>
</div>

<div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
  <div class="lg:col-span-2 bg-white border border-slate-200 rounded overflow-hidden">
    <div class="px-4 py-3 border-b border-slate-200 font-medium flex items-center justify-between gap-2">
      <span>Recent Appointments</span>
      <a href="${pageContext.request.contextPath}/app/appointments" class="inline-flex items-center gap-1 rounded border border-slate-300 bg-slate-50 hover:bg-slate-100 px-3 py-1.5 text-xs text-slate-700">
        <i class="bi bi-list-ul"></i>
        <span>View All</span>
      </a>
    </div>
    <div class="overflow-x-auto">
      <table class="w-full text-sm">
        <thead class="bg-slate-50 text-slate-600">
        <tr><th class="text-left p-3">Appt ID</th><th class="text-left p-3">Patient</th><th class="text-left p-3">Doctor</th><th class="text-left p-3">Date</th><th class="text-left p-3">Time</th><th class="text-left p-3">Status</th></tr>
        </thead>
        <tbody>
        <c:forEach items="${recentAppointments}" var="a">
          <tr class="border-t border-slate-100">
            <td class="p-3">${a.appointmentCode}</td>
            <td class="p-3">${a.patientName}</td>
            <td class="p-3">${a.doctorName}</td>
            <td class="p-3">${a.appointmentDate}</td>
            <td class="p-3">${a.appointmentTime}</td>
            <td class="p-3"><span class="inline-flex px-2 py-1 rounded text-xs ${a.status == 'Confirmed' || a.status == 'Completed' ? 'bg-emerald-100 text-emerald-700' : (a.status == 'Pending' ? 'bg-amber-100 text-amber-700' : 'bg-rose-100 text-rose-700')}">${a.status}</span></td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>

  <div class="bg-white border border-slate-200 rounded p-4">
    <div class="font-medium text-slate-800 mb-3">Quick Actions</div>
    <div class="grid grid-cols-1 gap-2">
      <a href="${pageContext.request.contextPath}/app/patients" class="inline-flex items-center gap-2 justify-center rounded bg-[#0b2545] hover:bg-[#15345c] text-white px-3 py-2 text-sm"><i class="bi bi-person-plus"></i><span>Add Patient</span></a>
      <a href="${pageContext.request.contextPath}/app/doctors" class="inline-flex items-center gap-2 justify-center rounded bg-[#1ca39a] hover:bg-[#188a82] text-white px-3 py-2 text-sm"><i class="bi bi-person-badge"></i><span>Add Doctor</span></a>
      <a href="${pageContext.request.contextPath}/app/appointments" class="inline-flex items-center gap-2 justify-center rounded bg-[#0b2545] hover:bg-[#15345c] text-white px-3 py-2 text-sm"><i class="bi bi-calendar-plus"></i><span>Book Appointment</span></a>
      <a href="${pageContext.request.contextPath}/app/billing" class="inline-flex items-center gap-2 justify-center rounded bg-[#1ca39a] hover:bg-[#188a82] text-white px-3 py-2 text-sm"><i class="bi bi-receipt"></i><span>Generate Bill</span></a>
    </div>
    <div class="mt-4 pt-4 border-t border-slate-200 text-xs text-slate-500 space-y-1">
      <div>System Status: <span class="text-emerald-700">Online</span></div>
      <div>Database: <span class="text-emerald-700">Connected (JDBC)</span></div>
      <div>Last Backup: 2026-05-24 22:00</div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.3/dist/chart.umd.min.js"></script>
<script>
  document.addEventListener('DOMContentLoaded', function () {
    const kpiCtx = document.getElementById('kpiChart');
    const trendCtx = document.getElementById('appointmentsTrendChart');

    if (kpiCtx && window.Chart) {
      new Chart(kpiCtx, {
        type: 'doughnut',
        data: {
          labels: ['Patients', 'Doctors', "Today Appointments", 'Pending Bills'],
          datasets: [{
            data: [
              Number('${stats.totalPatients}') || 0,
              Number('${stats.totalDoctors}') || 0,
              Number('${stats.todayAppointments}') || 0,
              Number('${stats.pendingBills}') || 0
            ],
            backgroundColor: ['#0b2545', '#1ca39a', '#2563eb', '#e11d48'],
            borderWidth: 0
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: { position: 'bottom' }
          },
          cutout: '62%'
        }
      });
    }

    if (trendCtx && window.Chart) {
      const dateCountMap = {};
      const statusCountMap = { Pending: 0, Confirmed: 0, Completed: 0, Cancelled: 0 };
      <c:forEach items="${recentAppointments}" var="a">
        dateCountMap['${a.appointmentDate}'] = (dateCountMap['${a.appointmentDate}'] || 0) + 1;
        statusCountMap['${a.status}'] = (statusCountMap['${a.status}'] || 0) + 1;
      </c:forEach>

      const dateLabels = Object.keys(dateCountMap).sort();
      const dateValues = dateLabels.map(function (d) { return dateCountMap[d]; });
      const statusTotal = Object.keys(statusCountMap).map(function (k) { return statusCountMap[k]; });

      new Chart(trendCtx, {
        type: 'bar',
        data: {
          labels: dateLabels.length ? dateLabels : ['No Recent Data'],
          datasets: [
            {
              label: 'Appointments by Date',
              data: dateLabels.length ? dateValues : [0],
              backgroundColor: '#0b2545',
              borderRadius: 6
            },
            {
              label: 'Status Total',
              data: dateLabels.length ? dateLabels.map(function () { return 0; }) : [0],
              backgroundColor: '#1ca39a',
              borderRadius: 6,
              hidden: true
            }
          ]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: { position: 'bottom' },
            tooltip: {
              callbacks: {
                afterBody: function () {
                  return [
                    'Pending: ' + (statusCountMap.Pending || 0),
                    'Confirmed: ' + (statusCountMap.Confirmed || 0),
                    'Completed: ' + (statusCountMap.Completed || 0),
                    'Cancelled: ' + (statusCountMap.Cancelled || 0)
                  ];
                }
              }
            }
          },
          scales: {
            y: { beginAtZero: true, ticks: { precision: 0 } }
          }
        }
      });
    }
  });
</script>

<%@ include file="fragments/layout-end.jspf" %>
