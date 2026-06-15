import { Button, Field, Panel, Select, Table, Td, TextArea, TextInput } from "../ui-bits";
import { Eye, Printer, Trash2 } from "lucide-react";

const seed = [
  { id: "RX-501", patient: "Rakibul Hasan", doctor: "Dr. Farhana Akter", date: "2026-05-20", diag: "Hypertension" },
  { id: "RX-502", patient: "Sumaiya Akter", doctor: "Dr. Mahbubur Rahman", date: "2026-05-21", diag: "Knee Pain" },
  { id: "RX-503", patient: "Mizanur Rahman", doctor: "Dr. Tanvir Ahmed", date: "2026-05-22", diag: "Viral Fever" },
  { id: "RX-504", patient: "Ayesha Siddika", doctor: "Dr. Sabina Yasmin", date: "2026-05-23", diag: "Skin Allergy" },
];

export function PrescriptionsPage() {
  return (
    <div className="space-y-6">
      <Panel title="New Prescription">
        <form className="grid grid-cols-1 md:grid-cols-2 gap-4" onSubmit={(e) => e.preventDefault()}>
          <Field label="Select Patient">
            <Select defaultValue="">
              <option value="" disabled>-- Choose Patient --</option>
              <option>P-2001 — Rakibul Hasan</option>
              <option>P-2002 — Sumaiya Akter</option>
              <option>P-2003 — Mizanur Rahman</option>
            </Select>
          </Field>
          <Field label="Select Doctor">
            <Select defaultValue="">
              <option value="" disabled>-- Choose Doctor --</option>
              <option>D-101 — Dr. Farhana Akter</option>
              <option>D-102 — Dr. Mahbubur Rahman</option>
            </Select>
          </Field>
          <div className="md:col-span-2">
            <Field label="Diagnosis">
              <TextInput placeholder="e.g. Hypertension, Stage 1" />
            </Field>
          </div>
          <Field label="Medicine Name">
            <TextInput placeholder="e.g. Amlodipine 5mg" />
          </Field>
          <Field label="Dosage">
            <TextInput placeholder="e.g. 1 tablet twice daily" />
          </Field>
          <div className="md:col-span-2">
            <Field label="Instructions">
              <TextArea rows={3} placeholder="Take after meals, avoid salty food, review in 2 weeks..." />
            </Field>
          </div>
          <div className="md:col-span-2 flex gap-2 pt-2 border-t border-slate-100">
            <Button variant="primary" type="submit">Save Prescription</Button>
            <Button variant="secondary" type="reset">Reset</Button>
          </div>
        </form>
      </Panel>

      <Panel title="Prescription History">
        <Table columns={["Prescription ID", "Patient", "Doctor", "Date", "Diagnosis", "Action"]}>
          {seed.map((r) => (
            <tr key={r.id} className="hover:bg-slate-50">
              <Td>{r.id}</Td>
              <Td>{r.patient}</Td>
              <Td>{r.doctor}</Td>
              <Td>{r.date}</Td>
              <Td>{r.diag}</Td>
              <Td>
                <div className="flex gap-1.5">
                  <Button variant="secondary"><Eye className="w-3.5 h-3.5" /> View</Button>
                  <Button variant="primary"><Printer className="w-3.5 h-3.5" /> Print</Button>
                  <Button variant="danger"><Trash2 className="w-3.5 h-3.5" /> Delete</Button>
                </div>
              </Td>
            </tr>
          ))}
        </Table>
      </Panel>
    </div>
  );
}
