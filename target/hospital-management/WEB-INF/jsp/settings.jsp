<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="fragments/layout-start.jspf" %>

<div class="space-y-6">
  <div class="bg-white border border-slate-200 rounded">
    <div class="px-4 py-3 border-b border-slate-200 font-medium">Hospital Information</div>
    <form method="post" action="${pageContext.request.contextPath}/app/settings" class="p-4 grid grid-cols-1 md:grid-cols-2 gap-4">
      <input type="hidden" name="section" value="hospital" />
      <input type="hidden" name="id" value="${setting.id}" />
      <div><label class="block text-sm text-slate-600 mb-1">Hospital Name</label><input class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="hospitalName" value="${setting.hospitalName}" required /></div>
      <div><label class="block text-sm text-slate-600 mb-1">Contact Number</label><input class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="contactNumber" value="${setting.contactNumber}" /></div>
      <div><label class="block text-sm text-slate-600 mb-1">Address</label><input class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="address" value="${setting.address}" /></div>
      <div><label class="block text-sm text-slate-600 mb-1">Email</label><input class="w-full rounded border border-slate-300 px-3 py-2 text-sm" type="email" name="email" value="${setting.email}" /></div>
      <div><button class="bg-[#0b2545] hover:bg-[#15345c] text-white rounded px-4 py-2 text-sm" type="submit">Save Changes</button></div>
    </form>
  </div>

  <div class="bg-white border border-slate-200 rounded">
    <div class="px-4 py-3 border-b border-slate-200 font-medium">Admin Account</div>
    <form method="post" action="${pageContext.request.contextPath}/app/settings" class="p-4 grid grid-cols-1 md:grid-cols-2 gap-4">
      <input type="hidden" name="section" value="admin" />
      <div><label class="block text-sm text-slate-600 mb-1">Username</label><input class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="username" value="${admin.username}" required /></div>
      <div><label class="block text-sm text-slate-600 mb-1">Role</label><select class="w-full rounded border border-slate-300 px-3 py-2 text-sm" name="role"><option ${admin.role == 'Administrator' ? 'selected' : ''}>Administrator</option><option ${admin.role == 'Doctor' ? 'selected' : ''}>Doctor</option><option ${admin.role == 'Receptionist' ? 'selected' : ''}>Receptionist</option></select></div>
      <div><label class="block text-sm text-slate-600 mb-1">New Password</label><input class="w-full rounded border border-slate-300 px-3 py-2 text-sm" type="password" name="newPassword" placeholder="Leave blank to keep current" /></div>
      <div class="flex items-end"><button class="bg-[#1ca39a] hover:bg-[#188a82] text-white rounded px-4 py-2 text-sm" type="submit">Update Account</button></div>
    </form>
  </div>

  <div class="bg-white border border-slate-200 rounded">
    <div class="px-4 py-3 border-b border-slate-200 font-medium">Database Connection (JDBC)</div>
    <div class="p-4 text-sm text-slate-700 space-y-1">
      <div>Driver: <code class="bg-slate-100 px-1 rounded">com.mysql.cj.jdbc.Driver</code></div>
      <div>URL: <code class="bg-slate-100 px-1 rounded">jdbc:mysql://localhost:3306/city_hospital_db</code></div>
      <div>Status: <span class="text-emerald-700">Connected</span></div>
    </div>
  </div>
</div>

<%@ include file="fragments/layout-end.jspf" %>
