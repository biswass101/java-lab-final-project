<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login - City Hospital</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/style.css?v=20260614b">
</head>
<body class="min-h-screen bg-slate-100 flex items-center justify-center p-6">
  <div class="w-full max-w-md bg-white border border-slate-200 rounded shadow-sm overflow-hidden">
    <div class="px-6 py-5 border-b border-slate-200 bg-[#0b2545] text-white rounded-t flex items-center gap-3">
      <div class="w-8 h-8 rounded bg-[#1ca39a]/20 border border-[#1ca39a] flex items-center justify-center"><i class="bi bi-hospital text-[#1ca39a]"></i></div>
      <div>
        <div class="font-semibold">City Hospital</div>
        <div class="text-xs text-slate-300">Management System — Admin Login</div>
      </div>
    </div>

    <form class="p-6 space-y-4" method="post" action="${pageContext.request.contextPath}/login">
      <c:if test="${not empty error}">
        <div class="rounded border border-rose-200 bg-rose-50 px-3 py-2 text-sm text-rose-700">${error}</div>
      </c:if>

      <div>
        <label class="block text-sm text-slate-600 mb-1">Username</label>
        <input class="w-full rounded border border-slate-300 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-[#1ca39a]/30" name="username" value="admin" required />
      </div>
      <div>
        <label class="block text-sm text-slate-600 mb-1">Password</label>
        <input class="w-full rounded border border-slate-300 px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-[#1ca39a]/30" type="password" name="password" value="admin" required />
      </div>

      <button class="w-full bg-[#0b2545] hover:bg-[#15345c] text-white rounded px-4 py-2 text-sm font-medium" type="submit">Login</button>
      <div class="text-center text-xs text-slate-500 pt-2 border-t border-slate-100">
        JSP + JDBC Based Web Application
        <div class="mt-1">© 2026 City Hospital, Dhaka, Bangladesh</div>
      </div>
    </form>
  </div>
</body>
</html>
