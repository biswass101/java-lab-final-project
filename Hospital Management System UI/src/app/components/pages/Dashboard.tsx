import { Users, Stethoscope, CalendarCheck, Receipt, UserPlus, CalendarPlus, FilePlus2 } from "lucide-react";
import { Button, Panel, StatusBadge, Table, Td } from "../ui-bits";
import type { PageKey } from "../Sidebar";

interface Props {
  onNavigate: (k: PageKey) => void;
}

function StatCard({
  label,
  value,
  icon: Icon,
  color,
}: {
  label: string;
  value: string;
  icon: React.ComponentType<{ className?: string }>;
  color: string;
}) {
  return (
    <div className="bg-white border border-slate-200 rounded p-4 flex items-center gap-4">
      <div className={`w-12 h-12 rounded flex items-center justify-center ${color}`}>
        <Icon className="w-6 h-6 text-white" />
      </div>
      <div>
        <div className="text-xs text-slate-500 uppercase tracking-wide">{label}</div>
        <div className="text-2xl text-[#0b2545] mt-0.5">{value}</div>
      </div>
    </div>
  );
}

export function DashboardPage({ onNavigate }: Props) {
  const recent = [
    { id: "A-1042", patient: "Rakibul Hasan", doctor: "Dr. Farhana Akter", date: "2026-05-25", time: "10:30", status: "Confirmed" },
    { id: "A-1043", patient: "Sumaiya Akter", doctor: "Dr. Mahbubur Rahman", date: "2026-05-25", time: "11:00", status: "Pending" },
    { id: "A-1044", patient: "Mizanur Rahman", doctor: "Dr. Nusrat Jahan", date: "2026-05-25", time: "11:45", status: "Completed" },
    { id: "A-1045", patient: "Ayesha Siddika", doctor: "Dr. Farhana Akter", date: "2026-05-25", time: "12:30", status: "Confirmed" },
    { id: "A-1046", patient: "Imran Hossain", doctor: "Dr. Tanvir Ahmed", date: "2026-05-25", time: "14:00", status: "Cancelled" },
  ];

  return (
    <div className="space-y-6">
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        <StatCard label="Total Patients" value="1,284" icon={Users} color="bg-[#0b2545]" />
        <StatCard label="Total Doctors" value="42" icon={Stethoscope} color="bg-[#1ca39a]" />
        <StatCard label="Today's Appointments" value="38" icon={CalendarCheck} color="bg-[#3a7bd5]" />
        <StatCard label="Pending Bills" value="17" icon={Receipt} color="bg-[#b3261e]" />
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <div className="lg:col-span-2">
          <Panel
            title="Recent Appointments"
            actions={
              <Button variant="secondary" onClick={() => onNavigate("appointments")}>
                View All
              </Button>
            }
          >
            <Table columns={["Appt ID", "Patient", "Doctor", "Date", "Time", "Status"]}>
              {recent.map((r) => (
                <tr key={r.id} className="hover:bg-slate-50">
                  <Td>{r.id}</Td>
                  <Td>{r.patient}</Td>
                  <Td>{r.doctor}</Td>
                  <Td>{r.date}</Td>
                  <Td>{r.time}</Td>
                  <Td><StatusBadge status={r.status} /></Td>
                </tr>
              ))}
            </Table>
          </Panel>
        </div>

        <Panel title="Quick Actions">
          <div className="grid grid-cols-1 gap-2">
            <Button variant="primary" onClick={() => onNavigate("patients")}>
              <UserPlus className="w-4 h-4" /> Add Patient
            </Button>
            <Button variant="teal" onClick={() => onNavigate("doctors")}>
              <Stethoscope className="w-4 h-4" /> Add Doctor
            </Button>
            <Button variant="primary" onClick={() => onNavigate("appointments")}>
              <CalendarPlus className="w-4 h-4" /> Book Appointment
            </Button>
            <Button variant="teal" onClick={() => onNavigate("billing")}>
              <FilePlus2 className="w-4 h-4" /> Generate Bill
            </Button>
          </div>
          <div className="mt-4 pt-4 border-t border-slate-200 text-xs text-slate-500">
            <div>System Status: <span className="text-emerald-700">Online</span></div>
            <div>Database: <span className="text-emerald-700">Connected (JDBC)</span></div>
            <div>Last Backup: 2026-05-24 22:00</div>
          </div>
        </Panel>
      </div>
    </div>
  );
}
