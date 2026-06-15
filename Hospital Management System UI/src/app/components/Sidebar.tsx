import {
  LayoutDashboard,
  Stethoscope,
  Users,
  CalendarCheck,
  FileText,
  Receipt,
  Search,
  Settings,
  LogOut,
} from "lucide-react";

export type PageKey =
  | "dashboard"
  | "doctors"
  | "patients"
  | "appointments"
  | "prescriptions"
  | "billing"
  | "search"
  | "settings";

const items: { key: PageKey; label: string; icon: React.ComponentType<{ className?: string }> }[] = [
  { key: "dashboard", label: "Dashboard", icon: LayoutDashboard },
  { key: "doctors", label: "Doctors", icon: Stethoscope },
  { key: "patients", label: "Patients", icon: Users },
  { key: "appointments", label: "Appointments", icon: CalendarCheck },
  { key: "prescriptions", label: "Prescriptions", icon: FileText },
  { key: "billing", label: "Billing", icon: Receipt },
  { key: "search", label: "Search Records", icon: Search },
  { key: "settings", label: "Admin Settings", icon: Settings },
];

interface Props {
  current: PageKey;
  onNavigate: (k: PageKey) => void;
  onLogout: () => void;
}

export function Sidebar({ current, onNavigate, onLogout }: Props) {
  return (
    <aside className="w-60 bg-[#0b2545] text-slate-100 flex flex-col min-h-screen">
      <div className="px-5 py-5 border-b border-white/10">
        <div className="text-white tracking-wide">City Hospital</div>
        <div className="text-[11px] text-slate-300 mt-1">Management System</div>
      </div>
      <nav className="flex-1 py-3">
        {items.map((it) => {
          const Icon = it.icon;
          const active = current === it.key;
          return (
            <button
              key={it.key}
              onClick={() => onNavigate(it.key)}
              className={`w-full flex items-center gap-3 px-5 py-2.5 text-left border-l-4 ${
                active
                  ? "bg-[#13366b] border-[#1ca39a] text-white"
                  : "border-transparent text-slate-200 hover:bg-[#13366b]/60"
              }`}
            >
              <Icon className="w-4 h-4" />
              <span>{it.label}</span>
            </button>
          );
        })}
      </nav>
      <button
        onClick={onLogout}
        className="flex items-center gap-3 px-5 py-3 border-t border-white/10 text-slate-200 hover:bg-[#13366b]/60"
      >
        <LogOut className="w-4 h-4" />
        <span>Logout</span>
      </button>
    </aside>
  );
}
