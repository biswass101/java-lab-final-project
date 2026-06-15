import { Button, Field, Panel, Select, Table, Td, TextInput } from "../ui-bits";
import { Search } from "lucide-react";

const results = [
  { type: "Patient", id: "P-2001", name: "Rakibul Hasan", date: "2026-04-12", detail: "Registered at OPD" },
  { type: "Appointment", id: "A-1042", name: "Rakibul Hasan", date: "2026-05-25", detail: "Dr. Farhana Akter — 10:30" },
  { type: "Prescription", id: "RX-501", name: "Rakibul Hasan", date: "2026-05-20", detail: "Hypertension — Amlodipine 5mg" },
  { type: "Billing", id: "B-9001", name: "Rakibul Hasan", date: "2026-05-20", detail: "৳ 1,850 — Paid" },
];

export function SearchRecordsPage() {
  return (
    <div className="space-y-6">
      <Panel title="Search Records">
        <form className="grid grid-cols-1 md:grid-cols-4 gap-4" onSubmit={(e) => e.preventDefault()}>
          <div className="md:col-span-2">
            <Field label="Search by Patient ID / Name / Doctor / Date">
              <TextInput placeholder="e.g. P-2001, Rakibul, Dr. Farhana, 2026-05-25" />
            </Field>
          </div>
          <Field label="Record Type">
            <Select defaultValue="">
              <option value="" disabled>-- Select Type --</option>
              <option>Patient</option>
              <option>Appointment</option>
              <option>Prescription</option>
              <option>Billing</option>
            </Select>
          </Field>
          <div className="flex items-end">
            <Button variant="primary" type="submit" className="w-full justify-center">
              <Search className="w-4 h-4" /> Search
            </Button>
          </div>
        </form>
      </Panel>

      <Panel title="Search Results">
        <Table columns={["Record Type", "Record ID", "Name", "Date", "Details", "Action"]}>
          {results.map((r) => (
            <tr key={r.id} className="hover:bg-slate-50">
              <Td>{r.type}</Td>
              <Td>{r.id}</Td>
              <Td>{r.name}</Td>
              <Td>{r.date}</Td>
              <Td>{r.detail}</Td>
              <Td>
                <Button variant="secondary">Open</Button>
              </Td>
            </tr>
          ))}
        </Table>
        <div className="mt-3 text-xs text-slate-500">Showing 4 of 4 results</div>
      </Panel>
    </div>
  );
}
