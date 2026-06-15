import { Button, Field, Panel, Select, StatusBadge, Table, Td, TextArea, TextInput } from "../ui-bits";
import { Eye, Pencil, Trash2 } from "lucide-react";

const seed = [
  { id: "A-1042", patient: "Rakibul Hasan", doctor: "Dr. Farhana Akter", date: "2026-05-25", time: "10:30", status: "Confirmed" },
  { id: "A-1043", patient: "Sumaiya Akter", doctor: "Dr. Mahbubur Rahman", date: "2026-05-25", time: "11:00", status: "Pending" },
  { id: "A-1044", patient: "Mizanur Rahman", doctor: "Dr. Nusrat Jahan", date: "2026-05-25", time: "11:45", status: "Completed" },
  { id: "A-1045", patient: "Ayesha Siddika", doctor: "Dr. Farhana Akter", date: "2026-05-26", time: "09:00", status: "Confirmed" },
  { id: "A-1046", patient: "Imran Hossain", doctor: "Dr. Tanvir Ahmed", date: "2026-05-26", time: "10:15", status: "Cancelled" },
  { id: "A-1047", patient: "Tahmina Begum", doctor: "Dr. Sabina Yasmin", date: "2026-05-27", time: "15:00", status: "Pending" },
];

export function AppointmentsPage() {
  return (
    <div className="space-y-6">
      <Panel title="Book New Appointment">
        <form className="grid grid-cols-1 md:grid-cols-2 gap-4" onSubmit={(e) => e.preventDefault()}>
          <Field label="Select Patient">
            <Select defaultValue="">
              <option value="" disabled>-- Choose Patient --</option>
              <option>P-2001 — Rakibul Hasan</option>
              <option>P-2002 — Sumaiya Akter</option>
              <option>P-2003 — Mizanur Rahman</option>
              <option>P-2004 — Ayesha Siddika</option>
            </Select>
          </Field>
          <Field label="Select Doctor">
            <Select defaultValue="">
              <option value="" disabled>-- Choose Doctor --</option>
              <option>D-101 — Dr. Farhana Akter (Cardiology)</option>
              <option>D-102 — Dr. Mahbubur Rahman (Orthopedics)</option>
              <option>D-103 — Dr. Nusrat Jahan (Pediatrics)</option>
            </Select>
          </Field>
          <Field label="Appointment Date">
            <TextInput type="date" />
          </Field>
          <Field label="Appointment Time">
            <TextInput type="time" />
          </Field>
          <div className="md:col-span-2">
            <Field label="Reason for Visit">
              <TextArea rows={2} placeholder="Brief description of symptoms or reason" />
            </Field>
          </div>
          <div className="md:col-span-2 flex gap-2 pt-2 border-t border-slate-100">
            <Button variant="primary" type="submit">Book Appointment</Button>
            <Button variant="secondary" type="reset">Clear</Button>
          </div>
        </form>
      </Panel>

      <Panel title="Appointment List">
        <Table columns={["Appt ID", "Patient", "Doctor", "Date", "Time", "Status", "Action"]}>
          {seed.map((a) => (
            <tr key={a.id} className="hover:bg-slate-50">
              <Td>{a.id}</Td>
              <Td>{a.patient}</Td>
              <Td>{a.doctor}</Td>
              <Td>{a.date}</Td>
              <Td>{a.time}</Td>
              <Td><StatusBadge status={a.status} /></Td>
              <Td>
                <div className="flex gap-1.5">
                  <Button variant="secondary"><Eye className="w-3.5 h-3.5" /> View</Button>
                  <Button variant="primary"><Pencil className="w-3.5 h-3.5" /> Edit</Button>
                  <Button variant="danger"><Trash2 className="w-3.5 h-3.5" /> Cancel</Button>
                </div>
              </Td>
            </tr>
          ))}
        </Table>
      </Panel>
    </div>
  );
}
