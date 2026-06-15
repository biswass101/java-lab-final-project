import { useState } from "react";
import { Sidebar, type PageKey } from "./components/Sidebar";
import { Header } from "./components/Header";
import { LoginPage } from "./components/pages/Login";
import { DashboardPage } from "./components/pages/Dashboard";
import { DoctorsPage } from "./components/pages/Doctors";
import { PatientsPage } from "./components/pages/Patients";
import { AppointmentsPage } from "./components/pages/Appointments";
import { PrescriptionsPage } from "./components/pages/Prescriptions";
import { BillingPage } from "./components/pages/Billing";
import { SearchRecordsPage } from "./components/pages/SearchRecords";
import { SettingsPage } from "./components/pages/Settings";

const titles: Record<PageKey, string> = {
  dashboard: "Dashboard",
  doctors: "Doctor Management",
  patients: "Patient Management",
  appointments: "Appointments",
  prescriptions: "Prescriptions",
  billing: "Billing System",
  search: "Search Records",
  settings: "Admin Settings",
};

export default function App() {
  const [loggedIn, setLoggedIn] = useState(false);
  const [page, setPage] = useState<PageKey>("dashboard");

  if (!loggedIn) {
    return <LoginPage onLogin={() => setLoggedIn(true)} />;
  }

  return (
    <div className="min-h-screen bg-slate-100 flex">
      <Sidebar current={page} onNavigate={setPage} onLogout={() => setLoggedIn(false)} />
      <div className="flex-1 flex flex-col min-w-0">
        <Header title={titles[page]} />
        <main className="flex-1 p-6 overflow-x-auto">
          {page === "dashboard" && <DashboardPage onNavigate={setPage} />}
          {page === "doctors" && <DoctorsPage />}
          {page === "patients" && <PatientsPage />}
          {page === "appointments" && <AppointmentsPage />}
          {page === "prescriptions" && <PrescriptionsPage />}
          {page === "billing" && <BillingPage />}
          {page === "search" && <SearchRecordsPage />}
          {page === "settings" && <SettingsPage />}
        </main>
        <footer className="bg-white border-t border-slate-200 px-6 py-3 text-xs text-slate-500 flex items-center justify-between">
          <div>© 2026 City Hospital, Dhaka — JSP + JDBC Based Web Application</div>
          <div>v1.0.0 • For academic/demo use only</div>
        </footer>
      </div>
    </div>
  );
}
