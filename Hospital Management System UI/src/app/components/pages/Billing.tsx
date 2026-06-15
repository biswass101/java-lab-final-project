import { useState } from "react";
import { Button, Field, Panel, Select, StatusBadge, Table, Td, TextInput } from "../ui-bits";
import { Eye, Printer, Trash2, AlertCircle } from "lucide-react";

const seed = [
  { id: "B-9001", patient: "Rakibul Hasan", total: 1850, status: "Paid", date: "2026-05-20" },
  { id: "B-9002", patient: "Sumaiya Akter", total: 3200, status: "Unpaid", date: "2026-05-21" },
  { id: "B-9003", patient: "Mizanur Rahman", total: 950, status: "Paid", date: "2026-05-22" },
  { id: "B-9004", patient: "Ayesha Siddika", total: 2400, status: "Unpaid", date: "2026-05-23" },
  { id: "B-9005", patient: "Imran Hossain", total: 5600, status: "Paid", date: "2026-05-24" },
];

export function BillingPage() {
  const [consult, setConsult] = useState(500);
  const [med, setMed] = useState(750);
  const [service, setService] = useState(200);
  const total = consult + med + service;

  return (
    <div className="space-y-6">
      <div className="bg-amber-50 border border-amber-200 text-amber-800 rounded px-4 py-3 flex items-center gap-2 text-sm">
        <AlertCircle className="w-4 h-4" />
        <span>This is a dummy billing module for demonstration only. No real payment is processed.</span>
      </div>

      <Panel title="Generate New Bill">
        <form className="grid grid-cols-1 md:grid-cols-2 gap-4" onSubmit={(e) => e.preventDefault()}>
          <Field label="Select Patient">
            <Select defaultValue="">
              <option value="" disabled>-- Choose Patient --</option>
              <option>P-2001 — Rakibul Hasan</option>
              <option>P-2002 — Sumaiya Akter</option>
              <option>P-2003 — Mizanur Rahman</option>
            </Select>
          </Field>
          <Field label="Bill Date">
            <TextInput type="date" defaultValue="2026-05-25" />
          </Field>
          <Field label="Consultation Fee (৳)">
            <TextInput type="number" value={consult} onChange={(e) => setConsult(Number(e.target.value) || 0)} />
          </Field>
          <Field label="Medicine Cost (৳)">
            <TextInput type="number" value={med} onChange={(e) => setMed(Number(e.target.value) || 0)} />
          </Field>
          <Field label="Service Charge (৳)">
            <TextInput type="number" value={service} onChange={(e) => setService(Number(e.target.value) || 0)} />
          </Field>
          <Field label="Payment Status">
            <Select defaultValue="Unpaid">
              <option>Paid</option>
              <option>Unpaid</option>
            </Select>
          </Field>
          <div className="md:col-span-2 bg-slate-50 border border-slate-200 rounded px-4 py-3 flex items-center justify-between">
            <div className="text-slate-700">Total Amount</div>
            <div className="text-2xl text-[#0b2545]">৳ {total.toLocaleString()}</div>
          </div>
          <div className="md:col-span-2 flex gap-2 pt-2 border-t border-slate-100">
            <Button variant="primary" type="submit">Generate Bill</Button>
            <Button variant="secondary" type="reset">Reset</Button>
          </div>
        </form>
      </Panel>

      <Panel title="Billing Records">
        <Table columns={["Bill ID", "Patient", "Total Amount", "Payment Status", "Date", "Action"]}>
          {seed.map((b) => (
            <tr key={b.id} className="hover:bg-slate-50">
              <Td>{b.id}</Td>
              <Td>{b.patient}</Td>
              <Td>৳ {b.total.toLocaleString()}</Td>
              <Td><StatusBadge status={b.status} /></Td>
              <Td>{b.date}</Td>
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
